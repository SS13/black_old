/mob/dead/observer
	name = "ghost"
	desc = "It's a g-g-g-g-ghooooost!" //jinkies!
	icon = 'mob.dmi'
	icon_state = "ghost"
	layer = 4
	stat = DEAD
	density = 0
	canmove = 0
	blinded = 0
	anchored = 1	//  don't get pushed around
	invisibility = 10
	universal_speak = 1	//Ghosts are multi-lingual!
	var/mob/corpse = null	//	observer mode
	var/datum/hud/living/carbon/hud = null // hud
	var/atom/movable/following = null
	var/can_reenter_corpse

/mob/dead/observer/New(mob/body)
	sight |= SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_SELF
	see_invisible = 15
	see_in_dark = 100
	verbs += /mob/dead/observer/proc/dead_tele
	stat = DEAD

	var/turf/T
	if(ismob(body))
		T = get_turf(body)				//Where is the body located?
		attack_log = body.attack_log	//preserve our attack logs by copying them to our ghost

		gender = body.gender
		if(body.mind && body.name)
			name = body.name
		else
			if(body.real_name)
				name = body.real_name
			else
				if(gender == MALE)
					name = capitalize(pick(first_names_male)) + " " + capitalize(pick(last_names))
				else
					name = capitalize(pick(first_names_female)) + " " + capitalize(pick(last_names))

		mind = body.mind	//we don't transfer the mind but we keep a reference to it.

	if(!T)	T = pick(latejoin)			//Safety in case we cannot find the body's position
	loc = T

	if(!name)							//To prevent nameless ghosts
		name = capitalize(pick(first_names_male)) + " " + capitalize(pick(last_names))
	real_name = name
	..()

/mob/dead/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	return 1
/*
Transfer_mind is there to check if mob is being deleted/not going to have a body.
Works together with spawning an observer, noted above.
*/

/mob/proc/ghostize(var/can_reenter_corpse = 1)
	if(key)
		var/mob/dead/observer/ghost = new(src)	//Transfer safety to observer spawning proc.
		ghost.can_reenter_corpse = can_reenter_corpse
		ghost.timeofdeath = timeofdeath //BS12 EDIT
		ghost.key = key
		return ghost

/mob/proc/adminghostize()
	if(client)
		client.mob = new/mob/dead/observer(src)
	return

/mob/dead/observer/verb/follow()
	set category = "Ghost"
	set name = "Follow" // "Haunt"
	set desc = "Follow and haunt a mob."

	if(istype(usr, /mob/dead/observer))
		var/list/mobs = getmobs()
		var/input = input("Please, select a mob!", "Haunt", null, null) as null|anything in mobs
		var/mob/target = mobs[input]
		if(target && target != usr)
			following = target
			spawn(0)
				var/turf/pos = get_turf(src)
				while(src.loc == pos)

					var/turf/T = get_turf(target)
					if(!T)
						break
					if(following != target)
						break
					if(!client)
						break
					src.loc = T
					pos = src.loc
					sleep(15)
				following = null

/mob/dead/observer/Move(NewLoc, direct)
	if(NewLoc)
		loc = NewLoc
		for(var/obj/effect/step_trigger/S in NewLoc)
			S.HasEntered(src)

		return
	loc = get_turf(src) //Get out of closets and such as a ghost
	if((direct & NORTH) && y < world.maxy)
		y++
	if((direct & SOUTH) && y > 1)
		y--
	if((direct & EAST) && x < world.maxx)
		x++
	if((direct & WEST) && x > 1)
		x--

	for(var/obj/effect/step_trigger/S in locate(x, y, z))
		S.HasEntered(src)

/mob/dead/observer/examine()
	if(usr)
		usr << desc

/mob/dead/observer/can_use_hands()	return 0
/mob/dead/observer/is_active()		return 0

/mob/dead/observer/Stat()
	..()
	statpanel("Status")
	if (client.statpanel == "Status")
		if(ticker)
			if(ticker.mode)
				//world << "DEBUG: ticker not null"
				if(ticker.mode.name == "AI malfunction")
					//world << "DEBUG: malf mode ticker test"
					if(ticker.mode:malf_mode_declared)
						stat(null, "Time left: [max(ticker.mode:AI_win_timeleft/(ticker.mode:apcs/3), 0)]")
		if(emergency_shuttle)
			if(emergency_shuttle.online && emergency_shuttle.location < 2)
				var/timeleft = emergency_shuttle.timeleft()
				if (timeleft)
					stat(null, "ETA-[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")

/mob/dead/observer/verb/reenter_corpse()
	set category = "Ghost"
	set name = "Re-enter Corpse"
	if(!corpse)
		alert("You don't have a corpse!")
		return
	if(client && client.holder && client.holder.state == 2)
		var/rank = client.holder.rank
		client.clear_admin_verbs()
		client.holder.state = 1
		client.update_admins(rank)
	if(iscultist(corpse) && corpse.ajourn==1 && corpse.stat!=2) //checks if it's an astral-journeying cultistm if it is and he's not on an astral journey rune, re-entering won't work
		var/S=0
		for(var/obj/effect/rune/R in world)
			if(corpse.loc==R.loc && R.word1 == wordhell && R.word2 == wordtravel && R.word3 == wordself)
				S=1
		if(!S)
			usr << "\red The astral cord that ties your body and your spirit has been severed. You are likely to wander the realm beyond until your body is finally dead and thus reunited with you."
			return
	if(corpse.ajourn)
		corpse.ajourn=0
	client.mob = corpse
	del(src)

/mob/dead/observer/verb/become_mouse()
	set category = "Ghost"
	set name = "Become mouse"

	//locate an empty mouse
	var/list/eligible_targets = new()
	for(var/mob/living/simple_animal/mouse/M in world)
		if(!M.ckey && !M.stat)
			eligible_targets.Add(M)

	var/mob/living/simple_animal/mouse/target_mouse
	if(ticker.spawn_vermin)
		if(eligible_targets.len)
			//grab a random existing one
			target_mouse = pick(eligible_targets)
		else
			//make a new mouse
			target_mouse = new(pick(ticker.vermin_spawn_turfs))

	if(target_mouse)
		//move player into mouse
		//the mouse ai will deactivate itself
		client.mob = target_mouse
		target_mouse.original_name = src.original_name

		//reset admin verbs
		if(client && client.holder && client.holder.state == 2)
			var/rank = client.holder.rank
			client.clear_admin_verbs()
			client.holder.state = 1
			client.update_admins(rank)

		//update allowed verbs
		target_mouse.verbs -= /mob/verb/observe
		target_mouse.verbs -= /client/verb/toggle_ghost_ears
		target_mouse.verbs -= /client/verb/toggle_ghost_sight

		del(src)

	else
		client << "\red Unable to become a mouse!"

/mob/dead/observer/proc/dead_tele()
	set category = "Ghost"
	set name = "Teleport"
	set desc= "Teleport to a location"
	if((usr.stat != 2) || !istype(usr, /mob/dead/observer))
		usr << "Not when you're not dead!"
		return
	usr.verbs -= /mob/dead/observer/proc/dead_tele
	spawn(30)
		usr.verbs += /mob/dead/observer/proc/dead_tele
	var/A
	A = input("Area to jump to", "BOOYEA", A) in ghostteleportlocs
	var/area/thearea = ghostteleportlocs[A]

	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		L+=T
	usr.loc = pick(L)

/mob/dead/observer/verb/jumptomob() //Moves the ghost instead of just changing the ghosts's eye -Nodrak
	set category = "Ghost"
	set name = "Jump to Mob"
	set desc = "Teleport to a mob"

	if(istype(usr, /mob/dead/observer)) //Make sure they're an observer!


		var/list/dest = list() //List of possible destinations (mobs)
		var/target = null	   //Chosen target.

		dest += getmobs() //Fill list, prompt user with list
		target = input("Please, select a player!", "Jump to Mob", null, null) as null|anything in dest

		if (!target)//Make sure we actually have a target
			return
		else
			var/mob/M = dest[target] //Destination mob
			var/mob/A = src			 //Source mob
			var/turf/T = get_turf(M) //Turf of the destination mob

			if(T && isturf(T))	//Make sure the turf exists, then move the source to that destination.
				A.loc = T
			else
				A << "This mob is not located in the game world."


/mob/dead/observer/verb/toggle_alien_candidate()
	set name = "Toggle Be Alien Candidate"
	set category = "Ghost"
	set desc = "Determines whether you will or will not be an alien candidate when someone bursts."
	if(client.be_alien)
		client.be_alien = 0
		src << "You are now excluded from alien candidate lists until end of round."
	else if(!client.be_alien)
		client.be_alien = 1
		src << "You are now included in alien candidate lists until end of round."

/mob/dead/observer/verb/toggle_pai_candidate()
	set name = "Toggle Be pAI Candidate"
	set category = "Ghost"
	set desc = "Receive a pop-up request when a pAI device requests a new personality. (toggle)"
	if(client.be_pai)
		client.be_pai = 0
		src << "You will no longer receive pAI recruitment pop-ups this round."
	else
		client.be_pai = 1
		src << "You will now be considered a viable candidate when a pAI device requests a new personality, effective until the end of this round."

/mob/dead/observer/memory()
	set hidden = 1
	src << "\red You are dead! You have no mind to store memory!"

/mob/dead/observer/add_memory()
	set hidden = 1
	src << "\red You are dead! You have no mind to store memory!"
