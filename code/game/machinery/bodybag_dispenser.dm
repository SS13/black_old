/obj/machinery/bodybag_dispenser
	name = "BodyBag Dispencer"
	desc = "."
	icon = 'bodybag.dmi'
	icon_state = "bodybagdispenser_on"
	var/charge = 0
	var/chargemax = 20
	var/bags   = 1


	process()
		if(stat & (NOPOWER|BROKEN))
			return
		if(bags >= 3)
			if(charge)
				charge = 0
		else
			charge++
			if(charge >= chargemax)
				bags++
				charge = 0
				update_icon()

	attack_hand(mob/living/user as mob)
		if(!bags)
			user << "/red[src] blink by red lights"
			return
		var/chance = 0
		if(user.intent == "help")
			chance += 50
		if(user.mind.assigned_role in medical_positions)
			chance += 50
		var/obj/item/bodybag/BB = new /obj/item/bodybag(src)
		if(prob(chance))
			usr.put_in_hands(BB)
			user << "/blueYou catch this flying [BB]!"
		else
			BB.loc = src.loc
			user << "You try to catch this [BB], but it flying away."
		return


	New()
		update_icon()


	update_icon()
		if(stat & (NOPOWER|BROKEN))
			icon_state = "bodybagdispenser_off"
			return
		else
			icon_state = "bodybagdispenser_on"
		if(bags)
			overlays = "bodybagdispenser_signal[bags]"
		return

