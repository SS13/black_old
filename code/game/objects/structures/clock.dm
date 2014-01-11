/obj/structure/clock
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "clock"
	name = "Old wooden clock"
	desc = "Mechanical clocks are uncommon in space, because, you know, pendulum problems"
	anchored = 1
	density = 1
	layer = 3
	var/health = 20
	var/broken = 0


	bullet_act(var/obj/item/projectile/Proj)
		if(istype(Proj, /obj/item/projectile/))
			health -= Proj.damage
			..()
			if(health <= 0)
				broken = 1
				src.icon_state = "[initial(icon_state)]-broken"

			return

	attackby(obj/item/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/wrench) && broken == 1)
			if	(anchored)
				playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
				user << "\blue Now unwrtnching the clock..."
				if(do_after(user,40))
					if(!src) return
					user << "\blue You unwrenched the clock."
					src.add_fingerprint(usr)
					src.anchored=0
			else if(!anchored)
				playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
				user << "\blue Now wrenching the clock."
				if(do_after(user,40))
					user << "\blue You wrenched the clock."
					src.anchored=1

/obj/structure/clock/examine()
	set src in view(3)
	..()
	if (!broken)
		usr.show_message("\red Station Time: [worldtime2text()]", 1)
	else
		return


