//This is crafting a shotgun

/obj/item/weapon/gunassembly
	name = "gun assembly part"
	desc = "Part for assembling guns"
	icon = 'icons/obj/shotgunassembly.dmi'
	icon_state = "stock"
	item_state = "r_hands"
	opacity = 0
	density = 0
	anchored = 0.0
	force = 1.0
	throwforce = 3.0
	throw_speed = 1
	throw_range = 5
	w_class = 1.0

/obj/item/weapon/gunassembly/stock
	name = "gun stock"
	desc = "Gun stock made of wood, a part of a gun assembly. Has a rectangle notch on the narrow side."
	icon_state = "stock"

/obj/item/weapon/gunassembly/stock/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/device/assembly/igniter))
		var/obj/item/device/assembly/igniter/G = I
		var/obj/item/weapon/gunassembly/trigger/W = new /obj/item/weapon/gunassembly/trigger
		user.visible_message("<span class='notice'>[user] is fiddling with the [src.name]...</span>")
		if (do_after(user, 50))
			user << "<span  class='notice'>You press on the igniter firmly, as it slides into a notch in the stock...</span>"
			user.before_take_item(G)
			user.before_take_item(src)
			user.put_in_hands(W)
			playsound(src.loc, 'sound/weapons/bulletinchamber.ogg', 50, 1)
			user << "<span class='userdanger'>*click*</span>"
			del(I)
			del(src)
			update_icon(user)

/obj/item/weapon/gunassembly/trigger
	name = "gun stock assembly"
	desc = "Gun stock with igniter and trigger assembly, barrel and frame not attached."
	icon_state = "igniter"

/obj/item/weapon/gunassembly/trigger/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/pipe/))
		var/obj/item/pipe/G = I
		var/obj/item/weapon/gunassembly/barrel/W = new /obj/item/weapon/gunassembly/barrel
		user.visible_message("<span class='notice'>[user] is fiddling with the [src.name]...</span>")
		if (do_after(user, 50))
			user << "<span  class='notice'>You push the pipe into reciever channel...</span>"
			user.before_take_item(G)
			user.before_take_item(src)
			user.put_in_hands(W)
			playsound(src.loc, 'sound/weapons/bulletinchamber.ogg', 50, 1)
			user << "<span class='userdanger'>*click*</span>"
			del(I)
			del(src)
			update_icon(user)


/obj/item/weapon/gunassembly/barrel
	name = "gun frame assembly"
	desc = "Gun frame assembly. Has barrel attached, but reciever is not welded and furniture is loose."
	icon_state = "barrel"
	item_state = "l6closednomag"

/obj/item/weapon/gunassembly/barrel/attackby(var/obj/item/S, mob/user as mob)
	if(istype(S, /obj/item/weapon/screwdriver))
		var/obj/item/weapon/gunassembly/furnished/W = new /obj/item/weapon/gunassembly/furnished
		user.visible_message("<span class='notice'>[user] is fiddling with the [src.name]...</span>")
		if (do_after(user, 60))
			user << "<span  class='notice'>You screw furniture to the [src.name]...</span>"
			//user.drop_item(S)
			user.before_take_item(src)
			user.put_in_hands(W)
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
			user << "<span class='userdanger'>*click*</span>"
			del(src)
			update_icon(user)



/obj/item/weapon/gunassembly/furnished
	name = "furnished gun frame assembly"
	desc = "Gun frame assembly. Has barrel attached, but reciever is not welded."
	icon_state = "furnitured"
	item_state = "shotgun"

/obj/item/weapon/gunassembly/furnished/attackby(var/obj/item/S, mob/user as mob)
	if(istype(S,/obj/item/weapon/weldingtool))
		var/obj/item/weapon/gunassembly/screwed/W = new /obj/item/weapon/gunassembly/screwed
		user.visible_message("<span class='notice'>[user] is fiddling with the [src.name]...</span>")
		if (do_after(user, 60))
			user << "<span  class='notice'>You weld the reciever on the [src.name]...</span>"
			user.before_take_item(src)
			user.put_in_hands(W)
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
			user << "<span class='userdanger'>*click*</span>"
			del(src)
			update_icon(user)

/obj/item/weapon/gunassembly/screwed
	name = "gun frame"
	desc = "Gun frame assembly. It is almost finished, only missing a few nuts"
	icon_state = "furnitured"
	item_state = "shotgun"

/obj/item/weapon/gunassembly/screwed/attackby(var/obj/item/weapon/W as obj,  mob/user as mob)
	if(istype(W,/obj/item/weapon/wrench))
		user.visible_message("<span class='notice'>[user] is fiddling with the [src.name]...</span>")
		if (do_after(user, 80))
			user << "<span  class='notice'>You finish tightening the screws on [src.name], making a one-shot shotgun!</span>"
			new/obj/item/weapon/gun/projectile/shotgun/doublebarrel/singlebarrel(user.loc)
			del(src)
			update_icon(user)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
			user << "<span class='userdanger'>*cling*</span>"
			user.visible_message("<span class='notice'>[user] has assembled some kind of firearm!</span>")
