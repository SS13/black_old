//This is where crafted hats, suits and unders go.

/obj/item/clothing/head/monkeypelt //Moved form head/misc. Yeah, gib 'em monkeys!
	name = "monkey pelt hat"
	desc = "What kind of minster would wear this?"
	icon_state = "monkeypelt"
	item_state = "monkeypelt"
	flags = FPRINT | TABLEPASS | BLOCKHAIR
	siemens_coefficient = 2.0


/obj/item/clothing/head/sheik
	name = " kufiya"
	icon_state = "sheik"
	desc = "Headwear of choice for arid environments, favored by Tajarans. Protects you head from heat."
	item_state = "sheik"
	flags = FPRINT | TABLEPASS | BLOCKHAIR
	flags_inv = HIDEEARS
	siemens_coefficient = 2.0
	heat_protection = HEAD
	max_heat_protection_temperature = (FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE /3)

/obj/item/clothing/under/sheik
	name = "thawb"
	icon_state = "sheik"
	desc = "Traditional garment of choice for arid environments, favored by Tajarans. Will keep you cool."
	item_state = "sheik"
	item_color = "sheik"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = (FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE /3)



//Crafting the armor vest
// clothing/suits/jobs handles the object itself
/obj/item/clothing/suit/storage/hazardvest/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/weapon/wirecutters))
		if(punctured)
			usr << "\blue There are already holes in this vest, and wirecutters won't fit anyway.."
			return
		else
			punctured = 1
			usr << "\blue You cut holes in the vest!"
			icon_state = "hazard_hole"
			name = "punctured hazard vest"
			user.visible_message("\blue [user] cuts holes in [src]")
			playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
			update_icon(user)
			return
	if (istype(O, /obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/C = O
		C.use(1)
		if(punctured)
			usr << "\blue You put cables through the holes, making a webbing."
			icon_state = "hazard_hole_wire"
			name = "hazard vest with wires"
			playsound(src.loc, 'sound/weapons/cablecuff.ogg', 50, 1)
			wired = 1
			update_icon(user)
			return
		else
			usr << "\blue There are no pockets that the coil would fit in."
			return
	if (istype(O, /obj/item/stack/sheet/plasteel))
		var/obj/item/stack/sheet/plasteel/C = O
		if(wired)
			C.use(1)
			usr << "\blue You tie a sheet of steel to the inside of the vest with cables."
			icon_state = "hazard_wire_metal"
			name = "hazard vest with a steel plate"
			playsound(src.loc, 'sound/weapons/cablecuff.ogg', 50, 1)
			armored = 1
			update_icon(user)
			return
		else
			usr << "\blue There are no pockets that the coil would fit in."
			return
	if (istype(O, /obj/item/weapon/weldingtool))
		if(armored)
			usr << "\blue You tie a sheet of steel to the inside of the vest with cables."
			playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
			user.visible_message("\blue [user] welds a steel plate to a cable webbing inside of [src]")
			new	/obj/item/clothing/suit/armor/vest/hazard(user.loc)
			user.drop_item(O)
			update_icon(user)
			return
		else
			usr << "\blue You can't figure out a way to use welding tool here..."
			return

/obj/item/clothing/suit/storage/hazardvest/examine()
	..()
	if (punctured)
		usr << "It has a few holes cut in it."
	if (wired)
		usr << "A few wires are running through the holes, tied to each other."
	if (armored)
		usr << "It has a sheet of steel tied to it with wires on the inside."
		return

