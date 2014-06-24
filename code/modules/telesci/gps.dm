var/list/GPS_list = list()
var/list/GPS_tags_amt = list()

/obj/item/device/gps
	name = "relay positioning system"
	desc = "Triangulates the approximate co-ordinates using a nearby satellite network. Helping lost spacemen find their way through the planets since 2016."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "gps-c"
	w_class = 2.0
	slot_flags = SLOT_BELT
	origin_tech = "programming=2;engineering=2"
	var/gpstag = "COM"
	var/emped = 0

/obj/item/device/gps/New()
	..()

	if(GPS_tags_amt[gpstag])
		GPS_tags_amt[gpstag] = GPS_tags_amt[gpstag] + 1
	else
		GPS_tags_amt[gpstag] = 1
	GPS_list.Add(src)
	set_tag(gpstag + "[GPS_tags_amt[gpstag]]")
	overlays += "working"

/obj/item/device/gps/Del()
	GPS_list.Remove(src)
	..()

/obj/item/device/gps/proc/set_tag(var/tag)
	gpstag = tag
	name = "relay positioning system ([tag])"

/obj/item/device/gps/proc/can_see(var/obj/item/device/gps/G)
	return 1

/obj/item/device/gps/emp_act(severity)
	emped = 1
	overlays -= "working"
	overlays += "emp"
	spawn(300)
		emped = 0
		overlays -= "emp"
		overlays += "working"

/obj/item/device/gps/attack_ai(mob/user as mob)
	return attack_self(user) // AI can into GPS

/obj/item/device/gps/attack_self(mob/user as mob)
	var/obj/item/device/gps/t = ""
	if(emped)
		t += "ERROR"
	else
		t += "<BR><A href='?src=\ref[src];tag=1'>Set Tag</A> "
		t += "<BR>Tag: [gpstag]"

		for(var/obj/item/device/gps/G in GPS_list)
			if(!G.can_see(src))
				continue
			var/turf/pos = get_turf(G)
			if(pos.z == 2)
				continue // No GPS in Centcom

			var/area/gps_area = get_area(G)
			var/tracked_gpstag = G.gpstag
			if(G.emped == 1)
				t += "<BR>[tracked_gpstag]: ERROR"
			else
				t += "<BR>[tracked_gpstag]: [format_text(gps_area.name)] ([pos.x], [pos.y], [pos.z])"

		t += "<BR><A href='?src=\ref[src];refresh=1'>Refresh</A> "

	user << browse("<TITLE>RPS</TITLE><HR>[t]", "window=GPS;size=400x550")
	onclose(user, "GPS")

/obj/item/device/gps/Topic(href, href_list)
	..()
	if(href_list["tag"] )
		var/a = input("Please enter desired tag.", name, gpstag) as text
		a = uppertext(copytext(sanitize(a), 1, 5))
		if(src.loc == usr)
			set_tag(a)

	attack_self(usr)




/obj/item/device/gps/science
	icon_state = "gps-s"
	gpstag = "SCI"

/obj/item/device/gps/engineering
	icon_state = "gps-e"
	gpstag = "ENG"

/obj/item/device/gps/archeology
	icon_state = "gps-a"
	gpstag = "ARC"

/obj/item/device/gps/mech
	name = "exosuit tracking beacon"
	gpstag = "MECH"

/obj/item/device/gps/mech/set_tag(var/tag)
	gpstag = tag
	name = "exosuit tracking beacon ([tag])"

/obj/item/device/gps/mech/can_see()
	var/obj/item/mecha_parts/mecha_tracking/B = src.loc
	if(!istype(B)) return 0
	if(!B.in_mecha()) return 0

	var/obj/mecha/M = B.loc
	set_tag(M.name)
	return 1