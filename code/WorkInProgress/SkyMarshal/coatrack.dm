/obj/structure/coatrack
	name = "Coat Rack"
	desc = "A hanger for your coat and hat."
	icon = 'icons/obj/coatrack.dmi'
	icon_state = "coatrack0"
	anchored = 1
	opacity = 0
	density = 1
	layer = 3.5
	var/obj/item/clothing/suit/storage/det_suit/coat
	var/obj/item/clothing/head/det_hat/hat

/obj/structure/coatrack/update_icon()
	var/items = 0
	if (coat)
		if(istype(coat,/obj/item/clothing/suit/storage/det_suit/black))
			items+=6
		else
			items+=3
	if (hat)
		if(istype(hat,/obj/item/clothing/head/det_hat/black))
			items+=5
		else
			items+=1
	src.icon_state = "coatrack[items]"

/obj/structure/coatrack/attack_hand(mob/user as mob)
	var/list/items = new /list() //Создаем список того, что есть на вешалке.
	if (coat) items+="Coat"
	if (hat) items+="Hat"
	if (!hat && !coat) return //Если на вешалке ничего - выходим. Все логично.
	else items+="None" //Добавим возможность ничего не брать
	switch(input("What do you want from the coat rack?") in items)
		if("None") return
		if("Coat")
			if (get_dist(usr, src) > 1)
				usr << "\red You must be near [src]!"
				return
			if(!coat)
				usr << "Somebody already get coat" //Если кто-нибудь заберет пальто с вешалки, пока игрок думает
				return
			if(!user.get_active_hand()) // Если можем дать в руки
				user.put_in_active_hand(coat) // Дадим
				for(var/mob/M in viewers(src, null))
					if(M.client)
						M.show_message(text("\blue [user] took off a coat from hangers."), 2)
			else
				coat.loc = usr.loc // Иначе положим на пол
			coat = null
		if("Hat")
			if (get_dist(usr, src) > 1)
				usr << "\red You must be near [src]!"
				return
			if(!hat)
				usr << "Somebody already get hat" //Если кто-нибудь заберет шляпу с вешалки, пока игрок думает
				return
			if(!user.get_active_hand()) // Если можем дать в руки
				user.put_in_active_hand(hat) // Дадим
				for(var/mob/M in viewers(src, null))
					if(M.client)
						M.show_message(text("\blue [user] took off a hat from hangers."), 2)
			else
				hat.loc = usr.loc // Иначе положим на пол
			hat = null
	update_icon()
	src.add_fingerprint(usr)

/obj/structure/coatrack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if ( istype(W,/obj/item/clothing/head/det_hat) && !hat)
		user.drop_item()
		W.loc = src
		hat = W
		update_icon()
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his hat onto the hanger."), 2)
		return // Так как мы уже знаем, что W - шляпа, то дальше проверять что это нет смысла. Выходим

	if ( istype(W,/obj/item/clothing/suit/storage/det_suit) && !coat)
		user.drop_item()
		W.loc = src
		coat = W
		update_icon()
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue [user] puts his coat onto the hanger."), 2)
		return

	if ( istype(W, /obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
		user << "\blue You begin to " + (anchored?"un":"")+"fasten \the [src]."
		if (do_after(user, 75))
			user.visible_message( \
				"[user]" +(anchored?"un":"")+"fastens \the [src].", \
				"\blue You have" +(anchored?"un":"")+"fastened \the [src]." + (anchored?" Now it can be pulled somewhere else.":"")+ "", \
				"You hear ratchet.")
	src.anchored = !anchored
	src.add_fingerprint(usr)

/obj/structure/coatrack/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if ( istype(mover,/obj/item/clothing/head/det_hat) && !hat)
		mover.loc = src
		hat = mover
		update_icon()
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue The hat lands perfectly atop its hanger!"), 2)
		return 0
	if ( istype(mover,/obj/item/clothing/suit/storage/det_suit) && !coat)
		mover.loc = src.loc
		for(var/mob/M in viewers(src, null))
			if(M.client)
				M.show_message(text("\blue The coat just fell near the hanger."), 2)
		return 0
	else return ..()