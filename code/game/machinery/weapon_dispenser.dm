#define GUN_LIMIT 3
#define AMMO_LIMIT 8
#define RECHARGING_TIME 120
//Intercross21's redacted TestUnit's "Weapon Dispenser".
/obj/machinery/weapon_dispenser
	name = "Weapon Dispenser"
	icon = 'icons/obj/robotics.dmi'
	icon_state = "fab-idle"
	anchored = 1
	var/list/personnelused = list()
	var/gun_charge = GUN_LIMIT
	var/ammo_charge = AMMO_LIMIT
	var/charge = 0
	req_access = list(access_security)

	New()
		processing_objects.Add(src)
	Del()
		processing_objects.Remove(src)
	process()
		if(charge >= RECHARGING_TIME)
			if(gun_charge < GUN_LIMIT)
				gun_charge += 1
			if(ammo_charge < AMMO_LIMIT)
				ammo_charge += min(AMMO_LIMIT, ammo_charge + 2)
			charge = 0
		if(charge < RECHARGING_TIME && ((gun_charge < GUN_LIMIT && gun_charge >= 0) || (ammo_charge < AMMO_LIMIT && ammo_charge >= 0)))
			charge++

/obj/machinery/weapon_dispenser/power_change()
	if (powered())
		stat &= ~NOPOWER
	else
		stat |= NOPOWER

/obj/machinery/weapon_dispenser/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/weapon_dispenser/attack_hand(user as mob)
	if (..())
		return
	if(!istype(user,/mob/living/carbon/human))
		return

	var/dat = {"[(allowed(user) && !used(user)) ? "<h2><font color = 'green'>Gun Access Granted</font></h2>" : "<h2><font color = 'red'>Gun Access Denied</font></h2>"]
	<HR>
	Guns:<BR>
	<A href='?src=\ref[src];make_gun=/obj/item/weapon/gun/projectile/pistol/beretta'>Beretta</A><BR>
	<A href='?src=\ref[src];make_gun=/obj/item/weapon/gun/projectile/SW'>ASwetlkwetlk</A><BR>
	<A href='?src=\ref[src];make_gun=/obj/item/weapon/gun/projectile/pistol'>Smith & Wesson</A><BR>
	<HR>
	Ammo:<BR>
	<A href='?src=\ref[src];make_ammo=/obj/item/ammo_magazine/beretta'>Magazine (9x19)</A><BR>
	<A href='?src=\ref[src];make_ammo=/obj/item/ammo_magazine/a357/SW'>Ammo box (.357) Special</A><BR>
	"}

	user << browse("<HEAD><TITLE>Weapon Dispenser Choise Panel</TITLE></HEAD><TT>[dat]</TT>", "window=weapon_dispenser")
	onclose(user, "weapon_dispenser")
	return

/obj/machinery/weapon_dispenser/Topic(href, href_list)
	if (..())
		return

	for (var/mob/M in viewers(1, src))
		if (M.client && M.machine == src)
			src.attack_hand(M)

	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["make_gun"])
		if(!allowed(usr) || used(usr))
			return
		if(!gun_charge)
			usr << "Resource depleted. Wait for recharging"
			return
		flick("fab-active", usr)
		var/gun = href_list["make_gun"]
		usr.put_in_hands(new gun(src))
		src.updateUsrDialog()
		using(usr)
		gun_charge--

	else if(href_list["make_ammo"])
		if(!allowed(usr))
			return
		if(!ammo_charge)
			usr << "Resource depleted. Wait or recharging"
			return
		flick("fab-active", usr)
		var/ammo = href_list["make_ammo"]
		usr.put_in_hands(new ammo(src))
		src.updateUsrDialog()
		ammo_charge--

/obj/machinery/weapon_dispenser/proc/using(mob/living/carbon/human/user as mob)
	var/obj/item/weapon/card/id/I = user.wear_id.GetID()
	if(!I)
		return
	personnelused.Add(I.name)

/obj/machinery/weapon_dispenser/proc/used(mob/living/carbon/human/user as mob)
	var/obj/item/weapon/card/id/I = user.wear_id.GetID()
	if(!I || I.name in personnelused)
		return 1
	return 0

/obj/machinery/weapon_dispenser/allowed(mob/living/carbon/human/user as mob)
	if(!user.wear_id)
		return
	var/obj/item/weapon/card/id/I = user.wear_id.GetID()
	if(!I)
		return 0
	if(check_access(I))
		return 1
	return 0

/obj/machinery/weapon_dispenser/check_access(obj/item/weapon/card/id/I)
	if(!I || !istype(I, /obj/item/weapon/card/id) || !I.access)
		return 0
	for(var/req in src.req_access)
		if(!(req in I.access))
			return 0
	return 1
#undef RECHARGING_TIME
#undef GUN_LIMIT
#undef AMMO_LIMIT