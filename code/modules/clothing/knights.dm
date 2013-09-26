/obj/item/clothing/suit/robe/
	name = "King Artur's robe"
	desc = "Old knigth's robe."
	icon_state = "robea"
	item_state = "robea"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	allowed = list()
	armor = list(melee = 0, bullet = 0, laser = 10,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/robe/lan
	name = "Sir Lancelot's robe"
	icon_state = "robel"
	item_state = "robel"

/obj/item/clothing/suit/robe/bed
	name = "Sir Bedevere's robe"
	icon_state = "robeb"
	item_state = "robeb"

/obj/item/clothing/suit/robe/rob
	name = "Sir Robin's robe"
	icon_state = "rober"
	item_state = "rober"

/obj/item/clothing/suit/robe/gal
	name = "Sir Galahad's robe"
	icon_state = "robeg"
	item_state = "robeg"

/obj/item/clothing/suit/robe/bk
	name = "Sir Black Knight's robe"
	icon_state = "robebk"
	item_state = "robebk"

/obj/item/clothing/under/hauberk
	name = "Knight's hauberk"
	icon_state = "hauberk"
	item_state = "hauberk"
	item_color = "hauberk"
	armor = list(melee = 80, bullet = 5, laser = 20,energy = 0, bomb = 0, bio = 0, rad = 0)
	has_sensor = 0

/obj/item/clothing/head/crown
	name = "The great Crown of the Great King"
	desc = "The great Crown of the Great King son of the Great King's father and brother of the Great King's brother."
	icon_state = "crown"
	flags = FPRINT | TABLEPASS
	item_state = "crown"

/obj/item/clothing/mask/knighthood
	name = "Hood of the knight"
	desc = "Knight's hood"
	icon_state = "knighthood"
	flags = FPRINT | TABLEPASS | BLOCKHAIR
	item_state = "knighthood"
	gas_transfer_coefficient = 1
	can_eat = 1
	can_breath = 0
	var/down = 0

	verb/toggle()
		set category = "Object"
		set name = "Adjust Knight's hud"
		set src in usr

		if(usr.canmove && !usr.stat && !usr.restrained())
			if(!src.down)
				flags_inv &= ~HIDEEARS
				flags &= ~BLOCKHAIR
				src.down = !src.down
				item_state = "[initial(item_state)]"
				usr << "Your hud is now hanging on your neck."

			else
				src.down = !src.down
				flags_inv |= HIDEEARS
				flags |= BLOCKHAIR
				item_state = "[initial(item_state)]down"
				usr << "You pull the hud up to cover your head."
			usr.update_inv_wear_mask()

/obj/item/clothing/head/knighthud
	desc = "Knight's hud"

/obj/item/clothing/head/knighthud/blackknight
	name = "Hud of the Black Knight"
	icon_state = "bknighthud"
	item_state = "bknighthud"

/obj/item/clothing/head/knighthud/bedeverhud
	name =""
	icon_state = "bedeverhud"
	item_state = "bedeverhud"

/obj/item/weapon/storage/belt/knight
	name = "Knight's belt"
	desc = "Knight's belt for swords wearing."
	icon_state = "knightbelt_empty"
	item_state = "knightbelt_empty"
	max_w_class = 3
	storage_slots = 1
	can_hold = list(
		"/obj/item/weapon/claymore")

/obj/item/weapon/shield/riot/knight
	icon = 'icons/obj/weapons.dmi'
	icon_state = "shield"

/obj/item/weapon/shield/riot/knight/lan
	icon = 'icons/obj/weapons.dmi'
	icon_state = "shieldl"

/obj/item/weapon/shield/riot/knight/bed
	icon = 'icons/obj/weapons.dmi'
	icon_state = "shieldb"

/obj/item/weapon/shield/riot/knight/rob
	icon = 'icons/obj/weapons.dmi'
	icon_state = "shieldr"

/obj/item/weapon/shield/riot/knight/gal
	icon = 'icons/obj/weapons.dmi'
	icon_state = "shieldg"
