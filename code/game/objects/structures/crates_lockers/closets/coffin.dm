/obj/structure/closet/coffin
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	icon_closed = "coffin"
	icon_opened = "coffin_open"

/obj/structure/closet/coffin/update_icon()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/coffin/fire_act()
	if(prob(40))
		new /obj/effect/decal/cleanable/ash(src.loc)
		visible_message("<span class='notice'>[src] catches fire and burns down!</span>")
		for(var/atom/movable/A as mob|obj in src)
			A.loc = src.
		del(src)
