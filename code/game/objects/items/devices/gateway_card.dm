/obj/item/device/gateway_frame
	name = "Frame for gateway key"
	desc = "."
	icon = 'icons/obj/card.dmi'
	icon_state = "gateway_frame"

	attack(obj/item/W as obj, mob/living/M as mob)
		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/user = M
			if(istype(W,/obj/item/weapon/card/id))
				var/obj/item/device/gateway_key/GK = new /obj/item/device/gateway_key (src.loc)
				if(user.r_hand == W || user.r_hand == src)
					user.drop_r_hand()
				if(user.l_hand == W || user.l_hand == src)
					user.drop_l_hand()
				GK.icon = W.icon
				GK.icon_state = W.icon_state
				GK.legal   = 0
				GK.secured = 0
				del(W)
		else
			M << "What? What is this"
			return


/obj/item/device/gateway_key
	name = "Gateway key"
	desc = "."
	icon = 'icons/obj/card.dmi'
	icon_state = "gold"
	item_state = "gold_id"
	var/secured = 1
	var/legal   = 1
	New()
		overlays += image(icon = 'icons/obj/card.dmi', icon_state = "gateway_frame")  //Image of frame
	attackby(obj/item/W as obj, mob/user as mob)
		if(istype(W, /obj/item/device/multitool))
			if(secured)
				return
			if(legal && prob(30))
				legal = 0
			else if (!legal && prob(5))
				legal = 1
		if(istype(W,/obj/item/weapon/screwdriver))
			secured = !secured
			if(!secured)
				legal = 0
		if(istype(W,/obj/item/device/gateway_key))
			var/obj/item/device/gateway_key/K = W
			if(!secured)
				if(K.legal)
					legal = 1
					user.visible_message("/red[src] blinks in [user] hands!", "/red[src] blinks in your hands")
