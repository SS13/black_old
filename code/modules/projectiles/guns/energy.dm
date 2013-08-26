/obj/item/weapon/gun/energy
	icon_state = "energy"
	name = "energy gun"
	desc = "A basic energy-based gun."
	fire_sound = 'sound/weapons/Taser.ogg'

	var/obj/item/weapon/cell/power_supply //What type of power cell this uses
	var/charge_cost = 100 //How much energy is needed to fire.
	var/cell_type = "/obj/item/weapon/cell/cartridge/classic"
	var/projectile_type = "/obj/item/projectile/beam/practice"
	var/modifystate
	var/removable = 1

	emp_act(severity)
		power_supply.use(round(power_supply.maxcharge / severity))
		update_icon()
		..()


	New()
		..()
		if(cell_type)
			power_supply = new cell_type(src)
		else
			power_supply = new(src)
		power_supply.give(power_supply.maxcharge)
		return


	load_into_chamber()
		if(in_chamber)	return 1
		if(!power_supply)	return 0
		if(!power_supply.use(charge_cost))	return 0
		if(!projectile_type)	return 0
		in_chamber = new projectile_type(src)
		return 1


	update_icon()
		var/ratio
		if(power_supply)
			ratio = power_supply.charge / power_supply.maxcharge
			ratio = round(ratio, 0.25) * 100
		else
			ratio = 0
		if(modifystate)
			icon_state = "[modifystate][ratio]"
		else
			icon_state = "[initial(icon_state)][ratio]"

/obj/item/weapon/gun/energy/verb/Take_Cartridge()
	set src in range(1)
	set category = "Object"
	if(!removable || !istype(usr, /mob/living/carbon/human))
		usr << "You can't remove cartridge from [src.name]."
		return
	if(!src.power_supply)
		usr << "[src.name] is empty."
		return
	usr.put_in_hands(power_supply)
	src.power_supply = null
	update_icon()
	src << "You empty [src.name]."

/obj/item/weapon/gun/energy/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/weapon/cell/cartridge))
		if(!src.power_supply)
			user.drop_item()
			W.loc = src
			src.power_supply = W
			src.update_icon()
	else
		..()
	return
