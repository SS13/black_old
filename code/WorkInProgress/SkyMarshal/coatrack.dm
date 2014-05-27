/obj/structure/coatrack
	name = "Coat Rack"
	desc = "A hanger for your coat and hat."
	icon = 'icons/obj/coatrack.dmi'
	icon_state = "coatrack0"
	anchored = 1
	opacity = 0
	density = 1
	layer = 3.5
	var/coat
	var/hat
	var/coat_black
	var/hat_black

/obj/structure/coatrack/attack_hand(mob/user as mob)
	switch(alert("What do you want from the coat rack?",,"Coat","Hat","None"))
		if("Coat")
			if(coat)
				if(!user.get_active_hand())
					user.put_in_active_hand(coat)
					update_icon()
					src.add_fingerprint(usr)
					coat = get_turf(user)
					coat = null
					if(!hat)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack1"
					if(!hat_black)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack4"
				else
					return
			else
				user << "\blue There is no coat to take!"
				return
			if(coat_black)
				if(!user.get_active_hand())
					user.put_in_active_hand(coat_black)
					update_icon()
					src.add_fingerprint(usr)
					coat = get_turf(user)
					coat = null
					if(!hat_black)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack4"
					if(!hat)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack1"
				else
					return
			else
				user << "\blue There is no coat to take!"
				return
		if("Hat")
			if(hat)
				if(!user.get_active_hand())
					user.put_in_active_hand(hat)
					update_icon()
					src.add_fingerprint(usr)
					hat = get_turf(user)
					hat = null
					if(!coat)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack2"
					if(!coat_black)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack5"
				else
					return
			else
				user << "\blue There is no hat to take!"
				return
			if(hat_black)
				if(!user.get_active_hand())
					user.put_in_active_hand(hat_black)
					update_icon()
					src.add_fingerprint(usr)
					hat = get_turf(user)
					hat = null
					if(!coat_black)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack5"
					if(!coat)
						icon_state = "coatrack0"
					else
						icon_state = "coatrack2"
				else
					return
			else
				user << "\blue There is no hat to take!"
				return
		if("None")
			return
		else
			user << "Something went wrong."
			return

/obj/structure/coatrack/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if ( istype(W,/obj/item/clothing/head/det_hat/black) && !hat_black)
		user.drop_item()
		W.loc = src
		hat_black = W
		if(!coat)
			icon_state = "coatrack4"
		else
			icon_state = "coatrack8"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his hat onto the rack."), 2)

	if ( istype(W,/obj/item/clothing/head/det_hat/black) && !hat_black)
		user.drop_item()
		W.loc = src
		hat_black = W
		if(!coat_black)
			icon_state = "coatrack4"
		else
			icon_state = "coatrack6"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his hat onto the rack."), 2)


	if ( istype(W,/obj/item/clothing/suit/storage/det_suit_black) && !coat_black)
		user.drop_item()
		W.loc = src
		coat_black = W
		if(!hat)
			icon_state = "coatrack5"
		else
			icon_state = "coatrack7"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his coat onto the rack."), 2)

	if ( istype(W,/obj/item/clothing/suit/storage/det_suit_black) && !coat_black)
		user.drop_item()
		W.loc = src
		coat_black = W
		if(!hat_black)
			icon_state = "coatrack5"
		else
			icon_state = "coatrack6"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his coat onto the rack."), 2)


	if ( istype(W,/obj/item/clothing/head/det_hat) && !hat)
		user.drop_item()
		W.loc = src
		hat = W
		if(!coat_black)
			icon_state = "coatrack1"
		else
			icon_state = "coatrack7"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his hat onto the rack."), 2)

	if ( istype(W,/obj/item/clothing/head/det_hat) && !hat)
		user.drop_item()
		W.loc = src
		hat = W
		if(!coat)
			icon_state = "coatrack1"
		else
			icon_state = "coatrack3"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his hat onto the rack."), 2)


	if ( istype(W,/obj/item/clothing/suit/storage/det_suit) && !coat)
		user.drop_item()
		W.loc = src
		coat = W
		if(!hat)
			icon_state = "coatrack2"
		else
			icon_state = "coatrack3"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his coat onto the rack."), 2)

	if ( istype(W,/obj/item/clothing/suit/storage/det_suit) && !coat)
		user.drop_item()
		W.loc = src
		coat = W
		if(!hat_black)
			icon_state = "coatrack2"
		else
			icon_state = "coatrack8"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his coat onto the rack."), 2)


	if ( istype(W, /obj/item/weapon/wrench))
		if (anchored)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
			user << "\blue You begin to unfasten \the [src]."
			if (do_after(user, 75))
				user.visible_message( \
					"[user] unfastens \the [src].", \
					"\blue You have unfastened \the [src]. Now it can be pulled somewhere else.", \
					"You hear ratchet.")
				src.anchored = 0
		else /*if (anchored)*/
			playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
			user << "\blue You begin to fasten \the [src]."
			if (do_after(user, 75))
				user.visible_message( \
					"[user] fastens \the [src].", \
					"\blue You have fastened \the [src].", \
					"You hear ratchet.")
				src.anchored = 1
		src.add_fingerprint(usr)


/*	if ( istype(W,/obj/item/clothing/head/det_hat) && hat)
		user << "There's already a hat on the rack!"

	if ( istype(W,/obj/item/clothing/suit/storage/det_suit) && coat)
		user << "There's already a coat on the rack!"
*/


/obj/structure/coatrack/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if ( istype(mover,/obj/item/clothing/head/det_hat) && !hat)
		mover.loc = src
		hat = mover
		if(!coat)
			icon_state = "coatrack1"
		else
			icon_state = "coatrack3"
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue The hat lands perfectly atop its hanger!"), 2)
		return 0
	if ( istype(mover,/obj/item/clothing/suit/storage/det_suit) && !coat)
		mover.loc = src.loc
		coat = mover
/*		if(!hat)
			icon_state = "coatrack2"
		else
			icon_state = "coatrack3" */
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue The coat just fell near the hanger."), 2)
		return 0
	else
		return 0