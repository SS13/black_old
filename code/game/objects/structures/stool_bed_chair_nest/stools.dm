/obj/structure/stool
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stool"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15

/obj/structure/stool/barstool
	name = "bar stool"
	icon_state = "barstool"


/obj/structure/stool/barstool/tall
	name = "tall stool"
	icon_state = "barstool2"
	desc = "This barstool looks way to heavy to lift and swing."


/obj/structure/stool/orange
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolorange"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15

/obj/structure/stool/black
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolblack"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15

/obj/structure/stool/wooden
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolwooden"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15

/obj/structure/stool/darkgreen
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stooldarkgreen"
	anchored = 1.0
	flags = FPRINT
	pressure_resistance = 15


/obj/structure/stool/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			if (prob(50))
				del(src)
				return
		if(3.0)
			if (prob(5))
				del(src)
				return
	return

/obj/structure/stool/blob_act()
	if(prob(75))
		new /obj/item/stack/sheet/metal(src.loc)
		del(src)

/obj/structure/stool/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/sheet/metal(src.loc)
		del(src)
	return

/obj/structure/stool/wooden/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		new /obj/item/stack/sheet/mineral/wood(src.loc)
		del(src)
	return

/obj/structure/stool/MouseDrop(atom/over_object)
	if (istype(over_object, /mob/living/carbon/human) && (usr == over_object) && get_dist(over_object, src) <= 1)
		var/mob/living/carbon/human/H = over_object
		if (!H.restrained() && !H.stat)
			var/obj/item/weapon/stool/S = new/obj/item/weapon/stool()
			S.origin = src
			src.loc = S
			H.put_in_hands(S)
			H.visible_message("\red [H] grabs [src] from the floor!", "\red You grab [src] from the floor!")

/obj/structure/stool/barstool/MouseDrop(atom/over_object)
	if (istype(over_object, /mob/living/carbon/human) && (usr == over_object) && get_dist(over_object, src) <= 1)
		var/mob/living/carbon/human/H = over_object
		if (!H.restrained() && !H.stat)
			var/obj/item/weapon/stool/barstool/S = new/obj/item/weapon/stool/barstool()
			S.origin = src
			src.loc = S
			H.put_in_hands(S)
			H.visible_message("\red [H] grabs [src] from the floor!", "\red You grab [src] from the floor!")

/obj/structure/stool/black/MouseDrop(atom/over_object)
	if (istype(over_object, /mob/living/carbon/human) && (usr == over_object) && get_dist(over_object, src) <= 1)
		var/mob/living/carbon/human/H = over_object
		if (!H.restrained() && !H.stat)
			var/obj/item/weapon/stool/black/S = new/obj/item/weapon/stool/black()
			S.origin = src
			src.loc = S
			H.put_in_hands(S)
			H.visible_message("\red [H] grabs [src] from the floor!", "\red You grab [src] from the floor!")

/obj/structure/stool/green/MouseDrop(atom/over_object)
	if (istype(over_object, /mob/living/carbon/human) && (usr == over_object) && get_dist(over_object, src) <= 1)
		var/mob/living/carbon/human/H = over_object
		if (!H.restrained() && !H.stat)
			var/obj/item/weapon/stool/darkgreen/S = new/obj/item/weapon/stool/darkgreen()
			S.origin = src
			src.loc = S
			H.put_in_hands(S)
			H.visible_message("\red [H] grabs [src] from the floor!", "\red You grab [src] from the floor!")

/obj/item/weapon/stool
	name = "stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stool"
	force = 10
	throwforce = 10
	w_class = 5.0
	var/obj/structure/stool/origin = null

/obj/item/weapon/stool/barstool
	name = "bar stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "barstool"
	force = 10
	throwforce = 10
	w_class = 5.0

/obj/item/weapon/stool/darkgreen
	name = "stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stooldarkgreen"
	force = 10
	throwforce = 10
	w_class = 5.0

/obj/item/weapon/stool/orange
	name = "stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolorange"
	force = 10
	throwforce = 10
	w_class = 5.0

/obj/item/weapon/stool/wooden
	name = "stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolwooden"
	force = 10
	throwforce = 10
	w_class = 5.0

/obj/item/weapon/stool/black
	name = "stool"
	desc = "Uh-hoh, bar is heating up."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stoolblack"
	force = 10
	throwforce = 10
	w_class = 5.0

/obj/item/weapon/stool/attack_self(mob/user as mob)
	..()
	origin.loc = get_turf(src)
	user.u_equip(src)
	user.visible_message("\blue [user] puts [src] down.", "\blue You put [src] down.")
	del src

/obj/item/weapon/stool/attack(mob/M as mob, mob/user as mob)
	if (prob(25) && istype(M,/mob/living))
		user.visible_message("\red [user] breaks [src] over [M]'s back!.")
		user.u_equip(src)
		var/obj/item/stack/sheet/mineral/wood/m = new/obj/item/stack/sheet/mineral/wood
		m.loc = get_turf(src)
		del src
		var/mob/living/T = M
		T.Weaken(10)
		T.apply_damage(15)
		return
	..()


/obj/item/weapon/stool/attack(mob/M as mob, mob/user as mob)
	if (prob(25) && istype(M,/mob/living))
		user.visible_message("\red [user] breaks [src] over [M]'s back!.")
		user.u_equip(src)
		var/obj/item/stack/sheet/metal/m = new/obj/item/stack/sheet/metal
		m.loc = get_turf(src)
		del src
		var/mob/living/T = M
		T.Weaken(10)
		T.apply_damage(20)
		return
	..()
