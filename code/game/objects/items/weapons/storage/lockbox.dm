//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/weapon/storage/lockbox
	name = "lockbox"
	desc = "A locked box."
	icon_state = "lockbox+l"
	item_state = "syringe_kit"
	w_class = 4
	max_w_class = 3
	max_combined_w_class = 14 //The sum of the w_classes of all the items in this storage item.
	storage_slots = 4
	req_access = list(access_brig)//This should allow shitcuritrons to use it, detective is left out
	var/locked = 1
	var/open = 0
	var/l_hacking = 0
	var/broken = 0
	var/icon_locked = "lockbox+l"
	var/icon_closed = "lockbox"
	var/icon_broken = "lockbox+b"


	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W, /obj/item/weapon/card/id))
			if(src.broken)
				user << "\red It appears to be broken."
				return
			if(src.allowed(user))
				src.locked = !( src.locked )
				if(src.locked)
					src.icon_state = src.icon_locked
					user << "\red You lock the [src.name]!"
					return
				else
					src.icon_state = src.icon_closed
					user << "\red You unlock the [src.name]!"
					return
			else
				user << "\red Access Denied"
		else if((istype(W, /obj/item/weapon/card/emag)||istype(W, /obj/item/weapon/melee/energy/blade)) && !src.broken)
			broken = 1
			locked = 0
			desc = "It appears to be broken."
			icon_state = src.icon_broken
			if(istype(W, /obj/item/weapon/melee/energy/blade))
				var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
				spark_system.set_up(5, 0, src.loc)
				spark_system.start()
				playsound(src.loc, 'sound/weapons/blade1.ogg', 50, 1)
				playsound(src.loc, "sparks", 50, 1)
				for(var/mob/O in viewers(user, 3))
					O.show_message(text("\blue The locker has been sliced open by [] with an energy blade!", user), 1, text("\red You hear metal being sliced and sparks flying."), 2)

			if (istype(W, /obj/item/weapon/screwdriver))
				if (do_after(user, 20))
					src.open =! src.open
					user.show_message(text("\blue You [] the service panel.", (src.open ? "open" : "close")))
					desc = "Lock panel is open, exposing the lock mechanism!"
				return
			if ((istype(W, /obj/item/device/multitool)) && (src.open == 1)&& (!src.l_hacking))
				user.show_message(text("\red Now attempting to reset lock, please hold."), 1)
				src.l_hacking = 1
				for(var/mob/O in viewers(user, 3))
					O.show_message(text("\blue [] is tampering with lockbox locking mechanism", user), 1)
				if (do_after(usr, 100))

					if (prob(15))
						user.show_message(text("\red Lock reset. Give it a few seconds to reinitialize."), 1)
						playsound(src.loc, "click", 75, 1, -1)
						sleep(80)
						src.l_hacking = 0
					else
						user.show_message(text("\red Unable to reset lock. Try again."), 1)
						src.l_hacking = 0
			else
				for(var/mob/O in viewers(user, 3))
					O.show_message(text("\blue The locker has been broken by [] with an electromagnetic card!", user), 1, text("You hear a faint electrical spark."), 2)

		if(!locked)
			..()
		else
			user << "\red Its locked!"
		return


	show_to(mob/user as mob)
		if(locked)
			user << "\red Its locked!"
		else
			..()
		return


/obj/item/weapon/storage/lockbox/loyalty
	name = "Lockbox (Loyalty Implants)"
	req_access = list(access_security)

	New()
		..()
		new /obj/item/weapon/implantcase/loyalty(src)
		new /obj/item/weapon/implantcase/loyalty(src)
		new /obj/item/weapon/implantcase/loyalty(src)
		new /obj/item/weapon/implanter/loyalty(src)


/obj/item/weapon/storage/lockbox/clusterbang
	name = "lockbox (clusterbang)"
	desc = "You have a bad feeling about opening this."
	req_access = list(access_security)

	New()
		..()
		new /obj/item/weapon/grenade/flashbang/clusterbang(src)


/obj/item/weapon/storage/lockbox/medal
	name = "medal box"
	desc = "A locked box used to store medals of honor."
	icon_state = "medalbox+l"
	item_state = "medalbox"
	req_access = list(access_captain)
	icon_locked = "medalbox+l"
	icon_closed = "medalbox"
	icon_broken = "medalbox+b"

	New()
		..()
		new /obj/item/clothing/tie/medal/silver/valor(src)
		new /obj/item/clothing/tie/medal/bronze_heart(src)
		new /obj/item/clothing/tie/medal/conduct(src)
		new /obj/item/clothing/tie/medal/conduct(src)
		new /obj/item/clothing/tie/medal/conduct(src)
		new	/obj/item/clothing/tie/medal/gold_diamond(src)
		new /obj/item/clothing/tie/medal/silver/security(src)
