/obj/item/weapon/shield
	name = "shield"

/obj/item/weapon/shield/riot
	name = "riot shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "riot"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
	g_amt = 7500
	m_amt = 1000
	health = 130
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

	IsShield()
		return 1

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/melee/baton))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
				cooldown = world.time
		else
			..()

/obj/item/weapon/shield/riot/attack(mob/M as mob, mob/user as mob)
	health -= force
	..()
	if(health <= 0)
		user.drop_item()
		user.visible_message("\red [user] breaks their shield [M]!",\
			"\red The shield cracks and brakes!",\
			"You hear loud metallic noise!")
		new /obj/item/weapon/brokenriot(src.loc)
		del(src)

/obj/item/weapon/shield/metal
	name = "metal shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder. This is some serious protection."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "metal"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BACK
	force = 7.0
	throwforce = 6.0
	throw_speed = 1
	throw_range = 2
	w_class = 4.0
	g_amt = 8000
	m_amt = 1500
	origin_tech = "materials=2"
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time

	IsShield()
		return 1

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/melee/baton))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbashmetal.ogg', 50, 1)
				cooldown = world.time
		if(istype(W, /obj/item/weapon/melee/classic_baton))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbashmetal2.ogg', 50, 1)
				cooldown = world.time
		if(istype(W, /obj/item/weapon/gun/))
			if(cooldown < world.time - 25)
				user.visible_message("<span class='warning'>[user] bangs [src] with [W]!</span>")
				playsound(user.loc, 'sound/effects/shieldbashmetal2.ogg', 50, 1)
				cooldown = world.time
		else
			..()

/obj/item/weapon/shield/metal/green
	name = "metal shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder. This one comes in green."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "metalgreen"


/obj/item/weapon/shield/riot/roman
	name = "roman shield"
	desc = "Bears an inscription on the inside: <i>\"Romanes venio domus\"</i>."
	icon_state = "roman_shield"

/obj/item/weapon/shield/riot/buckler
	name = "buckler"
	desc = "Thou be waving this thingy around - thou be sitting in ye olde brig."
	icon_state = "buckler"

/obj/item/weapon/shield/energy
	name = "energy combat shield"
	desc = "A shield capable of stopping most projectile and melee attacks. It can be retracted, expanded, and stored anywhere."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "eshield0" // eshield1 for expanded
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = 1
	origin_tech = "materials=4;magnets=3;syndicate=4"
	attack_verb = list("shoved", "bashed")
	var/active = 0

/obj/item/weapon/cloaking_device
	name = "cloaking device"
	desc = "Use this to become invisible to the human eyesocket."
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	var/active = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "electronic"
	throwforce = 10.0
	throw_speed = 2
	throw_range = 10
	w_class = 2.0
	origin_tech = "magnets=3;syndicate=4"


/obj/item/weapon/cloaking_device/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		user << "\blue The cloaking device is now active."
		src.icon_state = "shield1"
	else
		user << "\blue The cloaking device is now inactive."
		src.icon_state = "shield0"
	src.add_fingerprint(user)
	return

/obj/item/weapon/cloaking_device/emp_act(severity)
	active = 0
	icon_state = "shield0"
	if(ismob(loc))
		loc:update_icons()
	..()
