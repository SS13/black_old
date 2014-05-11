/obj/item/weapon/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
	max_w_class = 3
	max_combined_w_class = 16

/obj/item/weapon/storage/briefcase/New()
	..()

/obj/item/weapon/storage/briefcase/attack(mob/living/M as mob, mob/living/user as mob)
	//..()

	if ((CLUMSY in user.mutations) && prob(50))
		user << "\red The [src] slips out of your hand and hits your head."
		user.take_organ_damage(10)
		user.Paralyse(2)
		return


	M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [M.name] ([M.ckey])</font>")
	msg_admin_attack("[user.name] ([user.ckey]) attacked [M.name] ([M.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>)")

	if (M.stat < 2 && M.health < 50 && prob(90))
		var/mob/H = M
		// ******* Check
		if ((istype(H, /mob/living/carbon/human) && istype(H, /obj/item/clothing/head) && H.flags & 8 && prob(80)))
			M << "\red The helmet protects you from being hit hard in the head!"
			return
		var/time = rand(2, 6)
		if (prob(75))
			M.Paralyse(time)
		else
			M.Stun(time)
		if(M.stat != 2)	M.stat = 1
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red <B>[] has been knocked unconscious!</B>", M), 1, "\red You hear someone fall.", 2)
	else
		M << text("\red [] tried to knock you unconcious!",user)
		M.eye_blurry += 3

	return

/obj/item/weapon/storage/briefcase/metal
	name = "metal briefcase"
	desc = "It's made of nano-alloy of aluminium and chugunium, although you have no idea what chugunium is. As seen in gangster movies."
	icon_state = "briefcasemetal"
	item_state = "sheet_metal"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 9.0
	throw_speed = 1
	throw_range = 3
	w_class = 4.0
	max_w_class = 4
	max_combined_w_class = 18

/obj/item/weapon/storage/briefcase/med
	name = "medical briefcase"
	desc = "Sturdy plastic briefcase for storing essential tools and supplies. When you are too cool to carry a first-aid kit around."
	icon_state = "medbriefcase"
	item_state = "medicalpack"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 3.0
	throw_speed = 1
	throw_range = 5