/obj/machinery/shotgunrack
	name = "Shotgun Rack"
	desc = "A rack to display your shotgun."
	icon = 'icons/obj/shotgunrack.dmi'
	icon_state = "rack_empty"
	anchored = 1
	opacity = 0
	density = 0
	layer = 3.5
	var/gun

/obj/machinery/shotgunrack/attack_hand(mob/user as mob)
	switch(alert("Do you want to take the shotgun off of the wall?",,"Yes","No"))
		if("Yes")
			if(!gun)
				if(!user.get_active_hand())
					user.put_in_active_hand(gun)
				else
					gun = get_turf(user)
					gun = null
					icon_state = "rack_empty"
					src.add_fingerprint(usr)
					update_icon()
					return
			else
				user << "\blue There is no gun on the rack!"
				return
		if("No")
			return
	user << "Something went wrong."
	return

/obj/machinery/shotgunrack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/obj/item/I = user.equipped()
	if ( istype(I,/obj/item/weapon/gun/projectile/shotgun/pump) && !gun)
		user.drop_item()
		I.loc = src
		gun = I
		icon_state = "rack_pump"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(I,/obj/item/weapon/gun/projectile/shotgun/pump/combat) && !gun)
		user.drop_item()
		I.loc = src
		gun = I
		icon_state = "rack_combat"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(I,/obj/item/weapon/gun/projectile/shotgun/doublebarrel) && !gun)
		user.drop_item()
		I.loc = src
		gun = I
		icon_state = "rack_dbarrel"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(I, /obj/item/weapon/wrench))
		src.add_fingerprint(usr)
		if(gun)
			user << "\red Remove the weapon first!"
			return
		anchored = !anchored
		user << "You [anchored ? "attached" : "detached"] the shotgun rack."
		playsound(loc, 'sound/items/Ratchet.ogg', 75, 1)

	else
		return ..()


