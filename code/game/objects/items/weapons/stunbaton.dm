#define POWER_FOR_STUN 50

/obj/item/weapon/melee/baton
	name = "stun baton"
	desc = "A stun baton for incapacitating people with."
	icon_state = "stunbaton"
	item_state = "baton"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 7
	w_class = 3
	var/cell_type = "/obj/item/weapon/cell/cartridge/classic"
	var/obj/item/weapon/cell/cartridge/power_supply = null
	var/status = 0
	var/mob/foundmob = "" //Used in throwing proc.
	var/removable = 1

	origin_tech = "combat=2"

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is putting the live [src.name] in \his mouth! It looks like \he's trying to commit suicide.</b>"
		return (FIRELOSS)

	New()
		..()
		if(cell_type)
			power_supply = new cell_type(src)
		update_icon()

/obj/item/weapon/melee/baton/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/weapon/cell/cartridge))
		if(!power_supply)
			user.drop_item()
			W.loc = src
			power_supply = W
		else
			usr << "You can't insert this [W.name]. [src.name] is full!"
	else
		..()
	return

/obj/item/weapon/melee/baton/update_icon()
	if(status && power_supply)
		icon_state = "stunbaton_active"
	else
		icon_state = "stunbaton"

/obj/item/weapon/melee/baton/verb/Take_Cartrige()
	set src in range(1)
	set category = "objects"
	if(!removable || !istype(usr, /mob/living/carbon/human))
		usr << "You can't remove cartridge from [src.name]."
		return
	if(!src.power_supply)
		usr << "[src.name] is empty."
		return
	usr.put_in_hands(power_supply)
	src.power_supply = null
	status = 0
	update_icon()
	src << "You empty [src.name]."

/obj/item/weapon/melee/baton/attack_self(mob/user as mob)
	if(!power_supply)
		status = 0
		user << "<span class='warning'>\The [src] is out of charge.</span>"
	else if(status && (CLUMSY in user.mutations) && prob(50))
		user << "\red You grab the [src] on the wrong side."
		user.Weaken(30)
		power_supply.charge -= POWER_FOR_STUN
		if(power_supply.charge < 1)
			status = 0
			update_icon()
		return
	else if(power_supply.charge > 0)
		status = !status
		user << "<span class='notice'>\The [src] is now [status ? "on" : "off"].</span>"
		playsound(src.loc, "sparks", 75, 1, -1)
		update_icon()

	add_fingerprint(user)

/obj/item/weapon/melee/baton/attack(mob/M as mob, mob/user as mob)
	if(status && (CLUMSY in user.mutations) && prob(50))
		user << "<span class='danger'>You accidentally hit yourself with the [src]!</span>"
		user.Weaken(30)
		power_supply.charge -= POWER_FOR_STUN
		if(power_supply.charge < 1)
			status = 0
			update_icon()
		return

	var/mob/living/carbon/human/H = M
	if(isrobot(M))
		..()
		return

	if(user.a_intent == "hurt")
		if(!..()) return
		//H.apply_effect(5, WEAKEN, 0)
		H.visible_message("<span class='danger'>[M] has been beaten with the [src] by [user]!</span>")
		playsound(src.loc, "swing_hit", 50, 1, -1)
	else if(!status)
		H.visible_message("<span class='warning'>[M] has been prodded with the [src] by [user]. Luckily it was off.</span>")
		return

	if(status)
		H.apply_effect(10, STUN, 0)
		H.apply_effect(10, WEAKEN, 0)
		H.apply_effect(10, STUTTER, 0)
		user.lastattacked = M
		H.lastattacker = user
		if(isrobot(src.loc))
			var/mob/living/silicon/robot/R = src.loc
			if(R && R.cell)
				R.cell.use(50)
		else
			power_supply.charge -= POWER_FOR_STUN
		H.visible_message("<span class='danger'>[M] has been stunned with the [src] by [user]!</span>")
		user.attack_log += "\[[time_stamp()]\]<font color='red'> Stunned [H.name] ([H.ckey]) with [src.name]</font>"
		H.attack_log += "\[[time_stamp()]\]<font color='orange'> Stunned by [user.name] ([user.ckey]) with [src.name]</font>"
		log_attack("<font color='red'>[user.name] ([user.ckey]) stunned [H.name] ([H.ckey]) with [src.name]</font>" )

		playsound(src.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		if(power_supply.charge < 1)
			status = 0
			update_icon()

	add_fingerprint(user)

/obj/item/weapon/melee/baton/throw_impact(atom/hit_atom)
	if (prob(50))
		if(istype(hit_atom, /mob/living))
			var/mob/living/carbon/human/H = hit_atom
			if(status)
				H.apply_effect(10, STUN, 0)
				H.apply_effect(10, WEAKEN, 0)
				H.apply_effect(10, STUTTER, 0)
				power_supply.charge -= POWER_FOR_STUN

				for(var/mob/M in player_list) if(M.key == src.fingerprintslast)
					foundmob = M
					break

				H.visible_message("<span class='danger'>[src], thrown by [foundmob.name], strikes [H] and stuns them!</span>")

				H.attack_log += "\[[time_stamp()]\]<font color='orange'> Stunned by thrown [src.name] (([src.fingerprintslast]))</font>"
				log_attack("<font color='red'>Flying [src.name], thrown by ([src.fingerprintslast]) stunned [H.name] ([H.ckey])</font>" )

				return
	return ..()

/obj/item/weapon/melee/baton/emp_act(severity)
	switch(severity)
		if(1)
			power_supply.charge = 0
		if(2)
			power_supply.charge = max(0,power_supply.charge -(POWER_FOR_STUN * 5))
	if(power_supply.charge < 1)
		status = 0
		update_icon()
