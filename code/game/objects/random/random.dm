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

/obj/random/broken_weapon
	name = "Random Broken Gun"
	desc = "This is a random broken gun"
	icon = 'icons/obj/gun.dmi'
	icon_state = "egun-broken"
	item_to_spawn()
		return pick(/obj/item/weapon/brokenlaser,\
					/obj/item/weapon/brokenegun,\
					/obj/item/weapon/brokentaser,\
					/obj/item/weapon/blownshotgun)


/obj/random/coin
	name = "Random Coin"
	desc = "This is a random coin"
	icon = 'icons/obj/items.dmi'
	icon_state = "coin_gold"
	item_to_spawn()
		return pick(prob(4);/obj/item/weapon/coin/gold,\
					prob(6);/obj/item/weapon/coin/silver,\
					prob(1);/obj/item/weapon/coin/diamond,\
					prob(1);/obj/item/weapon/coin/plasma,\
					prob(1);/obj/item/weapon/coin/uranium,\
					/*prob(4);/obj/item/weapon/coin/clown,\
					prob(2);/obj/item/weapon/coin/adamantine,\
					prob(1);/obj/item/weapon/coin/mythril,\*/
					prob(12);/obj/item/weapon/coin/iron)


/obj/random/technology_scanner
	name = "Random Scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/device/t_scanner,\
					//prob(2);/obj/item/device/radio/intercom,\//
					prob(5);/obj/item/device/analyzer)


/obj/random/powercell
	name = "Random Powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/weapon/cell/crap,\
					prob(40);/obj/item/weapon/cell,\
					prob(20);/obj/item/weapon/cell/high)
					//prob(9);/obj/item/weapon/cell/super,\
					//prob(1);/obj/item/weapon/cell/hyper)


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
		return pick(prob(1);/obj/random/powercell,\
					prob(3);/obj/random/technology_scanner,\
					prob(1);/obj/item/weapon/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/clothing/gloves/fyellow,\
					prob(4);/obj/item/weapon/cable_coil,\
					prob(2);/obj/random/toolbox,\
					prob(1);/obj/item/weapon/storage/belt/utility,\
					prob(7);/obj/random/tool)


/obj/random/bureaucracy
	name = "Random Folders Or Pens"
	desc = "This is a random desc clutter."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "folder_yellow"
	item_to_spawn()
		return pick(prob(4);/obj/item/weapon/folder/blue,\
					prob(4);/obj/item/weapon/folder/red,\
					prob(4);/obj/item/weapon/folder,\
					prob(5);/obj/item/weapon/folder/yellow,\
					prob(1);/obj/item/weapon/folder/white,\
					prob(1);/obj/item/weapon/folder/green,\
					prob(3);/obj/item/weapon/pen/blue,\
					prob(1);/obj/item/weapon/pen/red,\
					prob(3);/obj/item/weapon/pen,\
					prob(3);/obj/item/weapon/paper)



/obj/random/ashtray
	name = "Random Ashtray"
	desc = "This is a random ashtray."
	icon = 'icons/ashtray.dmi'
	icon_state = "ashtray_gl"
	item_to_spawn()
		return pick(prob(1);/obj/item/ashtray/bronze,\
					prob(3);/obj/item/ashtray/glass,\
					prob(4);/obj/item/ashtray/plastic)



/obj/random/dice
	name = "Random Dice"
	desc = "This is a random dice. "
	icon = 'icons/obj/dice.dmi'
	icon_state = "d61"
	spawn_nothing_percentage = 10
	item_to_spawn()
		return pick(prob(6);/obj/item/weapon/dice/d20,\
					prob(8);/obj/item/weapon/dice,\
					prob(2);/obj/item/weapon/dice/d4,\
					prob(4);/obj/item/weapon/dice/d10,\
					prob(4);/obj/item/weapon/dice/d8,\
					prob(4);/obj/item/weapon/dice/d00,\
					prob(5);/obj/item/weapon/dice/d12)
