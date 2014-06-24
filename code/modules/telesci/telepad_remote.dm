/obj/item/device/telepadremote
	icon = 'icons/obj/hacktool.dmi'
	name = "telepad remote control"
	icon_state = "hacktool_alt"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 2.0
	m_amt = 50
	g_amt = 20
	origin_tech = "magnets=2;engineering=3;bluespace=2"
	var/obj/machinery/computer/telescience/linked

/obj/item/device/telepadremote/attack_self(mob/user as mob)
	if(!istype(linked))
		user << "\red Connection to telepad failed."
	else
		user.set_machine(linked)
		linked.interact(user)
		return