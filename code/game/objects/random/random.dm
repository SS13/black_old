/obj/random
	name = "Random Object"
	desc = "This item type is used to spawn random objects at round-start"
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything


// creates a new object and deletes itself
/obj/random/New()
	..()
	if (!prob(spawn_nothing_percentage))
		spawn_item()
	del src


// this function should return a specific item to spawn
/obj/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/random/proc/spawn_item()
	var/build_path = item_to_spawn()
	return (new build_path(src.loc))


/obj/random/tool
	name = "Random Tool"
	desc = "This is a random tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/item/weapon/screwdriver,\
					/obj/item/weapon/wirecutters,\
					/obj/item/weapon/weldingtool,\
					/obj/item/weapon/crowbar,\
					/obj/item/weapon/wrench,\
					/obj/item/device/flashlight)


/obj/random/technology_scanner
	name = "Random Scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/device/t_scanner,\
					prob(2);/obj/item/device/radio/intercom,\
					prob(5);/obj/item/device/analyzer)


/obj/random/powercell
	name = "Random Powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/weapon/cell/crap,\
					prob(40);/obj/item/weapon/cell,\
					prob(40);/obj/item/weapon/cell/high,\
					prob(9);/obj/item/weapon/cell/super,\
					prob(1);/obj/item/weapon/cell/hyper)


/obj/random/bomb_supply
	name = "Bomb Supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	item_to_spawn()
		return pick(/obj/item/device/assembly/igniter,\
					/obj/item/device/assembly/prox_sensor,\
					/obj/item/device/assembly/signaler)


/obj/random/toolbox
	name = "Random Toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_to_spawn()
		return pick(prob(3);/obj/item/weapon/storage/toolbox/mechanical,\
					prob(2);/obj/item/weapon/storage/toolbox/electrical,\
					prob(1);/obj/item/weapon/storage/toolbox/emergency)


/obj/random/tech_supply
	name = "Random Tech Supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/random/powercell,\
					prob(2);/obj/random/technology_scanner,\
					prob(1);/obj/item/weapon/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/clothing/gloves/fyellow,\
					prob(3);/obj/item/weapon/cable_coil,\
					prob(2);/obj/random/toolbox,\
					prob(2);/obj/item/weapon/storage/belt/utility,\
					prob(5);/obj/random/tool)

//Following are some random spawnables to make the map seem more alive.

/obj/random/dirt
	name = "Random Dirt Decal"
	desc = "This is a random mess to sparkle janitor`s life."
	icon = 'icons/effects/blood.dmi'
	icon_state = "vomit_2"
	spawn_nothing_percentage = 80
	item_to_spawn()
		return pick(prob(2);/obj/effect/decal/cleanable/vomit,\
					prob(1);/obj/effect/decal/cleanable/oil,\
					prob(1);/obj/effect/decal/cleanable/oil/streak,\
					prob(15);/obj/effect/decal/cleanable/dirt,\
					prob(3);/obj/effect/decal/cleanable/generic)


/obj/random/dice
	name = "Random Dice"
	desc = "This is a random dice. "
	icon = 'icons/obj/dice.dmi'
	icon_state = "d2014"
	spawn_nothing_percentage = 10
	item_to_spawn()
		return pick(prob(1);/obj/item/weapon/dice/d20,\
					prob(1);/obj/item/weapon/dice)


/obj/random/bureaucracy
	name = "Random Desk Clutter For Bureaucrats"
	desc = "This is a random desk clutter."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = 'folder_yellow'
		item_to_spawn()
		return pick(prob(4);/obj/item/weapon/folder/blue,\
					prob(4);/obj/item/weapon/folder/red,\
					prob(4);/obj/item/weapon/folder/yellow,\
					prob(1);/obj/item/weapon/folder/white,\
					prob(2);/obj/item/weapon/pen/blue,\
					prob(1);/obj/item/weapon/pen/red,\
					prob(3);/obj/item/weapon/pen,\
					prob(3);/obj/item/weapon/paper)

/obj/random/ashtray
	name = "Random Ashtray"
	desc = "This is a random ashtray."
	icon = 'icons/ashtray.dmi'
	icon_state = 'ashtray_gl'
		item_to_spawn()
		return pick(prob(1);/obj/item/ashtray/bronze,\
					prob(4);/obj/item/ashtray/glass,\
					prob(4);/obj/item/ashtray/plastic)


/obj/random/trash
	name = "Random Trash"
	desc = "This is a random piece of trash. Only includes station-available items!"
	icon = 'icons/obj/trash.dmi'
	icon_state = "chips"
		item_to_spawn()
		return pick(prob(5);/obj/item/trash/chips,\
					prob(5);/obj/item/trash/sosjerky,\
					prob(5);/obj/item/trash/candy,\
					prob(5);/obj/item/trash/cheesie,\
					prob(5);/obj/item/trash/raisins,\
					prob(1);/obj/item/trash/popcorn,\
					prob(1);/obj/item/trash/syndi_cakes)


