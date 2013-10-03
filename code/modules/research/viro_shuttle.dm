/**********************Shuttle Computer**************************/

//copy paste from the mining shuttle

var/viro_shuttle_tickstomove = 10
var/viro_shuttle_moving = 0
var/viro_shuttle_location = 0 // 0 = station 13, 1 = viro station

proc/move_viro_shuttle()
	if(viro_shuttle_moving)	return
	viro_shuttle_moving = 1
	spawn(viro_shuttle_tickstomove*10)
		var/area/fromArea
		var/area/toArea
		if (viro_shuttle_location == 1)
			fromArea = locate(/area/shuttle/viro/outpost)
			toArea = locate(/area/shuttle/viro/station)
		else
			fromArea = locate(/area/shuttle/viro/station)
			toArea = locate(/area/shuttle/viro/outpost)


		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		for(var/mob/living/simple_animal/pest in toArea) // And for the other kind of bug...
			pest.gib()

		fromArea.move_contents_to(toArea)
		if (viro_shuttle_location)
			viro_shuttle_location = 0
		else
			viro_shuttle_location = 1
		viro_shuttle_moving = 0
	return

/obj/machinery/computer/viro_shuttle
	name = "Virology Shuttle Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	req_access = list(access_medical)
	circuit = "/obj/item/weapon/circuitboard/viro_shuttle"
	var/hacked = 0
	var/location = 0 //0 = station, 1 = viro base

/obj/machinery/computer/viro_shuttle/attack_hand(user as mob)
	src.add_fingerprint(usr)
	var/dat = "<center>Virology shuttle: <b><A href='?src=\ref[src];move=1'>Send</A></b></center><br>"

	user << browse("[dat]", "window=viroshuttle;size=200x100")

/obj/machinery/computer/viro_shuttle/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if(href_list["move"])
		//if(ticker.mode.name == "blob")
		//	if(ticker.mode:declared)
		//		usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
		//		return

		if (!viro_shuttle_moving)
			usr << "\blue Shuttle recieved message and will be sent shortly."
			move_viro_shuttle()
		else
			usr << "\blue Shuttle is already moving."

/obj/machinery/computer/viro_shuttle/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/card/emag))
		var/obj/item/weapon/card/emag/E = W
		if(E.uses)
			E.uses--
		else
			return
		src.req_access = list()
		hacked = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"

	else if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
			var/obj/item/weapon/circuitboard/viro_shuttle/M = new /obj/item/weapon/circuitboard/viro_shuttle( A )
			for (var/obj/C in src)
				C.loc = src.loc
			A.circuit = M
			A.anchored = 1

			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				new /obj/item/weapon/shard( src.loc )
				A.state = 3
				A.icon_state = "3"
			else
				user << "\blue You disconnect the monitor."
				A.state = 4
				A.icon_state = "4"

			del(src)