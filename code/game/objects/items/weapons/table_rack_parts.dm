/* Table parts and rack parts
 * Contains:
 *		Table Parts
 *		Reinforced Table Parts
 *		Wooden Table Parts
 *		Rack Parts
 */



/*
 * Table Parts
 */
/obj/item/weapon/table_parts/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/metal( user.loc )
		//SN src = null
		del(src)
	if (istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = W
		if (R.amount >= 4)
			new /obj/item/weapon/table_parts/reinforced( user.loc )
			user << "\blue You reinforce the [name]."
			R.use(4)
			del(src)
		else if (R.amount < 4)
			user << "\red You need at least four rods to do this."

/obj/item/weapon/table_parts/attack_self(mob/user as mob)
	user << "\blue You begin to assemble a table..."
	sleep(40)
	playsound(src.loc, 'sound/items/Screwdriver2.ogg', 50, 1)
	new /obj/structure/table( user.loc )
	user.drop_item()
	del(src)
	return

/*
 * Reinforced Table Parts
 */
/obj/item/weapon/table_parts/reinforced/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/metal( user.loc )
		new /obj/item/stack/rods( user.loc )
		del(src)

/obj/item/weapon/table_parts/reinforced/attack_self(mob/user as mob)
	user << "\blue You begin to assemble a reinforced table..."
	sleep(50)
	playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
	new /obj/structure/table/reinforced( user.loc )
	user.drop_item()
	del(src)
	return

/*
 * Wooden Table Parts
 */
/obj/item/weapon/table_parts/wood/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/mineral/wood( user.loc )
		del(src)

	if (istype(W, /obj/item/stack/tile/grass))
		var/obj/item/stack/tile/grass/Grass = W
		if(Grass.amount > 1)
			Grass.amount -= 1
		else
			del(Grass)
		new /obj/item/weapon/table_parts/poker( src.loc )
		visible_message("<span class='notice'>[user] adds grass to the wooden table parts</span>") //Grass, huh? Gotta come up with something better.
		del(src)

/obj/item/weapon/table_parts/wood/attack_self(mob/user as mob)
	user << "\blue You begin to assemble a wooden table..."
	sleep(40)
	playsound(src.loc, 'sound/items/Screwdriver2.ogg', 50, 1)
	new /obj/structure/table/woodentable( user.loc )
	user.drop_item()
	del(src)
	return

/*
 * Poker Table Parts
 */

/obj/item/weapon/table_parts/poker
	icon_state = "poker_tableparts"

/obj/item/weapon/table_parts/poker/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/mineral/wood( user.loc )
		new /obj/item/stack/tile/grass( user.loc )
		del(src)

/obj/item/weapon/table_parts/poker/attack_self(mob/user as mob)
	user << "\blue You begin to assemble a gambling table..."
	sleep(40)
	playsound(src.loc, 'sound/items/Screwdriver2.ogg', 50, 1)
	new /obj/structure/table/poker( user.loc )
	user.drop_item()
	del(src)
	return

/*
 * Rack Parts
 */
/obj/item/weapon/rack_parts/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/stack/sheet/metal( user.loc )
		del(src)
		return
	return

/obj/item/weapon/rack_parts/attack_self(mob/user as mob)
	user << "\blue You begin to assemble a rack..."
	sleep(40)
	playsound(src.loc, 'sound/items/Screwdriver2.ogg', 50, 1)
	var/obj/structure/rack/R = new /obj/structure/rack( user.loc )
	R.add_fingerprint(user)
	user.drop_item()
	del(src)
	return
