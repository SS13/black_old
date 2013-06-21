/obj/machinery/cartridge_charger
	name = "Cartridge Charger"
	desc = "It charges cartridge's."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger0"
	anchored = 1
	use_power = 1
	idle_power_usage = 5
	active_power_usage = 60
	power_channel = EQUIP
	var/obj/item/weapon/cell/charging = null
	var/chargelevel = -1

	update_icon()
		if(charging)
			if(charging.charge == charging.maxcharge)
				icon_state = "recharger2"
			else
				icon_state = "recharger1"
		else
			icon_state = "recharger0"

/*			if(charging && !(stat & (BROKEN|NOPOWER)) )

				var/newlevel = 	round(charging.percent() * 4.0 / 99)
				//world << "nl: [newlevel]"

				if(chargelevel != newlevel)

					overlays.Cut()
					overlays += "ccharger-o[newlevel]"

					chargelevel = newlevel
			else
				overlays.Cut()
*/
	examine()
		set src in oview(5)
		..()
		usr << "There's [charging ? "a" : "no"] cartridge in the charger."
		if(charging)
			usr << "Current charge: [charging.charge]"

	attackby(obj/item/weapon/W, mob/user)
		if(stat & BROKEN)
			return

		if(istype(W, /obj/item/weapon/cell/cartridge) && anchored)
			if(charging)
				user << "\red There is already a cartridge in the charger."
				return
			else
				var/area/a = loc.loc // Gets our locations location, like a dream within a dream
				if(!isarea(a))
					return
				if(a.power_equip == 0) // There's no APC in this area, don't try to cheat power!
					user << "\red The [name] blinks red as you try to insert the cartridge!"
					return

				user.drop_item()
				W.loc = src
				charging = W
				user.visible_message("[user] inserts a cartridge into the charger.", "You insert a cartridge into the charger.")
				chargelevel = -1
			update_icon()
		else if(istype(W, /obj/item/weapon/wrench))
			if(charging)
				user << "\red Remove the cartridge first!"
				return

			anchored = !anchored
			user << "You [anchored ? "attach" : "detach"] the cartridge charger [anchored ? "to" : "from"] the ground"
			playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)

	attack_hand(mob/user)
		if(charging)
			usr.put_in_hands(charging)
			charging.add_fingerprint(user)
			charging.updateicon()

			src.charging = null
			user.visible_message("[user] removes the cartridge from the charger.", "You remove the cartridge from the charger.")
			chargelevel = -1
			update_icon()

	attack_ai(mob/user)
		return

	emp_act(severity)
		if(stat & (BROKEN|NOPOWER))
			return
		if(charging)
			charging.emp_act(severity)
		..(severity)


	process()
		//world << "ccpt [charging] [stat]"
		if(!charging || (stat & (BROKEN|NOPOWER)) || !anchored)
			return

		use_power(200)		//this used to use CELLRATE, but CELLRATE is fucking awful. feel free to fix this properly!
		charging.give(100)	//inefficiency.
		update_icon()


/obj/machinery/cartridge_charger/wallcharger
	name = "wall recharger"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "wrecharger0"

	update_icon()
		if(charging)
			if(charging.charge == charging.maxcharge)
				icon_state = "wrecharger2"
			else
				icon_state = "wrecharger1"
		else
			icon_state = "wrecharger0"

	attackby(obj/item/weapon/W, mob/user)
		if(stat & BROKEN)
			return

		if(istype(W, /obj/item/weapon/cell/cartridge) && anchored)
			if(charging)
				user << "\red There is already a cartridge in the wall charger."
				return
			else
				var/area/a = loc.loc // Gets our locations location, like a dream within a dream
				if(!isarea(a))
					return
				if(a.power_equip == 0) // There's no APC in this area, don't try to cheat power!
					user << "\red The [name] blinks red as you try to insert the cartridge!"
					return

				user.drop_item()
				W.loc = src
				charging = W
				user.visible_message("[user] inserts a cartridge into the wall charger.", "You insert a cartridge into the wall charger.")
				chargelevel = -1
			update_icon()

	attack_hand(mob/user)
		if(charging)
			usr.put_in_hands(charging)
			charging.add_fingerprint(user)
			charging.updateicon()

			src.charging = null
			user.visible_message("[user] removes the cartridge from the wall charger.", "You remove the cartridge from the wall charger.")
			chargelevel = -1
			update_icon()

	attack_ai(mob/user)
		return

	emp_act(severity)
		if(stat & (BROKEN|NOPOWER))
			return
		if(charging)
			charging.emp_act(severity)
		..(severity)


	process()
		//world << "ccpt [charging] [stat]"
		if(!charging || (stat & (BROKEN|NOPOWER)) || !anchored)
			return

		use_power(200)		//this used to use CELLRATE, but CELLRATE is fucking awful. feel free to fix this properly!
		charging.give(100)	//inefficiency.
		update_icon()