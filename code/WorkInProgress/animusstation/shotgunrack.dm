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
	if(gun)
		switch(alert("Do you want to take the shotgun off of the wall?",,"Yes","No"))
			if("Yes")
				if(!user.get_active_hand())
					user.put_in_active_hand(gun)
					icon_state = "rack_empty"
					update_icon()
					src.add_fingerprint(usr)
					gun = get_turf(user)
					gun = null
				else
					return
			if("No")
				return
		return
	else
		user << "\blue There is no gun on the rack!"
		return


/obj/machinery/shotgunrack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if ( istype(W,/obj/item/weapon/gun/projectile/shotgun/pump) && !gun)
		user.drop_item()
		W.loc = src
		gun = W
		icon_state = "rack_pump"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(W,/obj/item/weapon/gun/projectile/shotgun/pump/combat) && !gun)
		user.drop_item()
		W.loc = src
		gun = W
		icon_state = "rack_combat"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(W,/obj/item/weapon/gun/projectile/shotgun/doublebarrel) && !gun)
		user.drop_item()
		W.loc = src
		gun = W
		icon_state = "rack_dbarrel"
		src.add_fingerprint(usr)
		update_icon()

	if ( istype(W, /obj/item/weapon/wrench))
		src.add_fingerprint(usr)
		if(gun)
			user << "\red Remove the weapon first!"
			return
		anchored = !anchored
		user << "You [anchored ? "attached" : "detached"] the shotgun rack."
		playsound(loc, 'sound/items/Ratchet.ogg', 75, 1)

	else
		return ..()


