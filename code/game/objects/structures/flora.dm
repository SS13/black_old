//trees
/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1
	pixel_x = -16
	layer = 9

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"

/obj/structure/flora/tree/pine/New()
	..()
	icon_state = "pine_[rand(1, 3)]"

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/dead/New()
	..()
	icon_state = "tree_[rand(1, 6)]"


//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]bb"


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]gb"

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	..()
	icon_state = "snowgrassall[rand(1, 3)]"


//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1

/obj/structure/flora/bush/New()
	..()
	icon_state = "snowbush[rand(1, 6)]"

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1

/obj/structure/flora/ausbushes/New()
	..()
	icon_state = "firstbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	..()
	icon_state = "reedbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	..()
	icon_state = "leafybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	..()
	icon_state = "palebush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	..()
	icon_state = "stalkybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	..()
	icon_state = "grassybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	..()
	icon_state = "fernybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	..()
	icon_state = "sunnybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	..()
	icon_state = "genericbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	..()
	icon_state = "pointybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	..()
	icon_state = "lavendergrass_[rand(1, 4)]"

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	..()
	icon_state = "ywflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	..()
	icon_state = "brflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	..()
	icon_state = "ppflowers_[rand(1, 4)]"

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	..()
	icon_state = "sparsegrass_[rand(1, 3)]"

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	..()
	icon_state = "fullgrass_[rand(1, 3)]"


//potted plants

/obj/structure/flora/pottedplant
	name = "Potted plant"
	icon = 'icons/obj/plants.dmi'
	desc = "A potted plant."
	anchored = 1
	density = 1

/obj/structure/flora/pottedplant/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		if (anchored)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
			user << "\blue You begin to unfasten \the [src] from the floor..."
			if (do_after(user, 40))
				user.visible_message( \
					"[user] unfastens \the [src].", \
					"\blue You have unfastened \the [src]. Now it can be pulled somewhere else.", \
					"You hear ratchet.")
				src.anchored = 0
				src.add_fingerprint(usr)
		else
			playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
			user << "\blue You begin to fasten \the [src] to the floor..."
			if (do_after(user, 20))
				user.visible_message( \
					"[user] fastens \the [src].", \
					"\blue You have fastened \the [src].", \
					"You hear ratchet.")
				src.anchored = 1
				src.add_fingerprint(usr)


/obj/structure/flora/pottedplant/plant1
	icon_state = "plant-01"

/obj/structure/flora/pottedplant/plant2
	icon_state = "plant-02"

/obj/structure/flora/pottedplant/plant3
	icon_state = "plant-03"

/obj/structure/flora/pottedplant/plant4
	icon_state = "plant-04"

/obj/structure/flora/pottedplant/plant5
	icon_state = "plant-05"

/obj/structure/flora/pottedplant/plant6
	icon_state = "plant-06"

/obj/structure/flora/pottedplant/plant7

	icon_state = "plant-07"

/obj/structure/flora/pottedplant/plant8
	icon_state = "plant-08"

/obj/structure/flora/pottedplant/plant9
	icon_state = "plant-09"

/obj/structure/flora/pottedplant/plant10
	icon_state = "plant-10"

/obj/structure/flora/pottedplant/plant11
	icon_state = "plant-11"

/obj/structure/flora/pottedplant/plant12
	icon_state = "plant-12"

/obj/structure/flora/pottedplant/plant13
	icon_state = "plant-13"

/obj/structure/flora/pottedplant/plant14
	icon_state = "plant-14"

/obj/structure/flora/pottedplant/plant15
	icon_state = "plant-15"

/obj/structure/flora/pottedplant/plant16
	icon_state = "plant-16"


/obj/structure/flora/pottedplant/plant17
	icon_state = "plant-17"

/obj/structure/flora/pottedplant/plant18
	icon_state = "plant-18"

/obj/structure/flora/pottedplant/plant19
	icon_state = "plant-19"

/obj/structure/flora/pottedplant/plant20
	icon_state = "plant-20"

/obj/structure/flora/pottedplant/plant21
	icon_state = "plant-21"

/obj/structure/flora/pottedplant/plant22
	icon_state = "plant-22"

/obj/structure/flora/pottedplant/plant23
	icon_state = "plant-23"

/obj/structure/flora/pottedplant/plant24
	icon_state = "plant-24"


/obj/structure/flora/pottedplant/plant25
	icon_state = "plant-25"
	desc = "A potted plant. This one appears to be long dead."

/obj/structure/flora/pottedplant/plant26
	icon_state = "applebush"
	desc = "A potted plant trimmed to resemble an apple."