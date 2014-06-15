/mob/living/simple_animal/hostile/syndicate
	name = "Syndicate Operative"
	desc = "Death to Nanotrasen."
	icon_state = "syndicate"
	icon_living = "syndicate"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	turns_per_move = 5
	response_help = "pokes the"
	response_disarm = "shoves the"
	response_harm = "hits the"
	speed = 4
	stop_automated_movement_when_pulled = 0
	maxHealth = 120
	health = 120
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = "harm"
	var/corpse = /obj/effect/landmark/mobcorpse/syndicatesoldier
	var/weapon1
	var/weapon2
	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 230	//Below -50 Degrees Celcius
	maxbodytemp = 400	//Above 50 Degrees Celcius
	unsuitable_atoms_damage = 15
	wall_smash = 1
	faction = "syndicate"
	status_flags = CANPUSH
	speak = list("Death to Nanotrasen!","I hate NT scum!","I wish I was somwhere else.","Can't wait to kick some Nanotrasen ass!","Huh.","Hail Syndicate!","Only good Nanotrasen employee is a dead one.","Huh?","Those Nanotrasen dogs are as good as dead.","I once beat a NT employee to death with my bare arms.","I’m here to kick ass and chew ambrosia leaves and I’m all out of ambrosia")
	speak_emote = list("says")
	emote_hear = list("says")
	emote_see = list("grunts","shrugs","yawns","chuckles","sighs","coughs","looks around")
	speak_chance = 2

/mob/living/simple_animal/hostile/syndicate/Die()
	..()
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	if(weapon2)
		new weapon2 (src.loc)
	del src
	return

///////////////Sword and shield////////////

/mob/living/simple_animal/hostile/syndicate/melee
	melee_damage_lower = 20
	melee_damage_upper = 25
	icon_state = "syndicatemelee"
	icon_living = "syndicatemelee"
	weapon1 = /obj/item/weapon/melee/energy/sword/red
	weapon2 = /obj/item/weapon/shield/energy
	attacktext = "slashes"
	status_flags = 0
	attack_sound = 'sound/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/syndicate/melee/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(O.force)
		if(prob(80))
			var/damage = O.force
			if (O.damtype == HALLOSS)
				damage = 0
			health -= damage
			visible_message("\red \b [src] has been attacked with the [O] by [user]. ")
		else
			visible_message("\red \b [src] blocks the [O] with its shield! ")
	else
		usr << "\red This weapon is ineffective, it does no damage."
		visible_message("\red [user] gently taps [src] with the [O]. ")


/mob/living/simple_animal/hostile/syndicate/melee/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)	return
	if(prob(65))
		src.health -= Proj.damage
	else
		visible_message("\red <B>[src] blocks [Proj] with its shield!</B>")
	return 0


/mob/living/simple_animal/hostile/syndicate/melee/space
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	icon_state = "syndicatemeleespace"
	icon_living = "syndicatemeleespace"
	name = "Syndicate Commando"
	corpse = /obj/effect/landmark/mobcorpse/syndicatecommando
	speed = 0

/mob/living/simple_animal/hostile/syndicate/melee/space/Process_Spacemove(var/check_drift = 0)
	return

/mob/living/simple_animal/hostile/syndicate/ranged
	ranged = 1
	rapid = 1
	icon_state = "syndicateranged"
	icon_living = "syndicateranged"
	casingtype = /obj/item/ammo_casing/a12mm
	projectilesound = 'sound/weapons/Gunshot_smg.ogg'
	projectiletype = /obj/item/projectile/bullet/midbullet2

	weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r

/mob/living/simple_animal/hostile/syndicate/ranged/space
	icon_state = "syndicaterangedpsace"
	icon_living = "syndicaterangedpsace"
	name = "Syndicate Commando"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	corpse = /obj/effect/landmark/mobcorpse/syndicatecommando
	speed = 0

/mob/living/simple_animal/hostile/syndicate/ranged/space/Process_Spacemove(var/check_drift = 0)
	return



/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon = 'icons/mob/critter.dmi'
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASSTABLE
	health = 15
	maxHealth = 15
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "cuts"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = "syndicate"
	speak = list("Bzzzt")
	speak_emote = list("beeps","buzzes")
	emote_hear = list("beeps")
	emote_see = list("buzzes","beeps")
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

/mob/living/simple_animal/hostile/viscerator/Die()
	..()
	visible_message("\red <b>[src]</b> is smashed into pieces!")
	del src
	return