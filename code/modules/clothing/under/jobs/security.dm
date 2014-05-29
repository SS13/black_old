/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpsuit"
	icon_state = "warden"
	item_state = "r_suit"
	item_color = "warden"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security
	name = "security officer's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "security"
	item_state = "r_suit"
	item_color = "secred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security/navy
	name = "security officer's navy jumpsuit"
	icon_state = "officerdnavyclothes"
	item_state = "suit-command"
	item_color = "officerdnavyclothes"

/obj/item/clothing/under/rank/security/navy/verb/rollup()
	set name = "Roll jumpsuit sleeves"
	set category = "Object"
	set src in usr
	item_color = item_color == "officerdnavyclothes" ? "officerdnavyclothes_rolled" : "officerdnavyclothes"
	if (ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_w_uniform(1)
		playsound(loc, 'sound/effects/rustle1.ogg', 30, 1)

/obj/item/clothing/under/rank/warden/navy
	name = "warden's navy jumpsuit"
	icon_state = "wardendnavyclothes"
	item_state = "suit-command"
	item_color = "wardendnavyclothes"


/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	item_state = "lawyer_blue"
	item_color = "dispatch"
	armor = list(melee = 5, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security/security2
	name = "security officer's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "officertanclothes"
	item_state = "det"
	item_color = "officertanclothes"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state = "sec_corporate"
	item_color = "sec_corporate"

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state = "warden_corporate"
	item_color = "warden_corporate"

/obj/item/clothing/under/rank/warden/warden2
	icon_state = "wardentanclothes"
	item_state = "det"
	item_color = "wardentanclothes"


/*
 * Detective
 */
/obj/item/clothing/under/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	item_color = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9


/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "detective"
	allowed = list(/obj/item/weapon/reagent_containers/food/snacks/candy_corn, /obj/item/weapon/pen)
	armor = list(melee = 50, bullet = 5, laser = 25,energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/head/det_hat/black
	name = "black hat"
	icon_state = "detectiveblack"

/obj/item/clothing/under/det/slob
	icon_state = "polsuit"
	item_color = "polsuit"

/obj/item/clothing/under/det/slob/verb/rollup()
	set name = "Roll suit sleeves"
	set category = "Object"
	set src in usr
	item_color = item_color == "polsuit" ? "polsuit_rolled" : "polsuit"
	if (ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_w_uniform(1)
		playsound(loc, 'sound/effects/rustle1.ogg', 30, 1)

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpsuit"
	icon_state = "hos"
	item_state = "r_suit"
	item_color = "hosred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/head_of_security/navy
	name = "head of security's navy jumpsuit"
	icon_state = "hosdnavyclothes"
	item_state = "suit-command"
	item_color = "hosdnavyclothes"

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state = "hos_corporate"
	item_color = "hos_corporate"

/obj/item/clothing/under/rank/head_of_security/head_of_security2
	icon_state = "hostanclothes"
	item_state = "det"
	item_color = "hostanclothes"

/obj/item/clothing/head/helmet/HoS
	name = "Head of Security Hat"
	desc = "The hat of the Head of Security. For showing the officers who's in charge."
	icon_state = "hoscap"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	flags_inv = 0
	flags_inv = HIDEEARS
	siemens_coefficient = 0.8

/obj/item/clothing/suit/armor/hos
	name = "armored coat"
	desc = "A greatcoat enhanced with a special alloy for some protection and style."
	icon_state = "hos"
	item_state = "hos"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = 65, bullet = 30, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0.6


/obj/item/clothing/head/helmet/HoS/dermal
	name = "Dermal Armour Patch"
	desc = "You're not quite sure how you manage to take it on and off, but it implants nicely in your head."
	icon_state = "dermal"
	item_state = "dermal"
	siemens_coefficient = 0.6

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"
	item_state = "jensen"
	item_color = "jensen"
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/hos/jensen
	name = "armored trenchcoat"
	desc = "A trenchcoat augmented with a special alloy for some protection and style."
	icon_state = "jensencoat"
	item_state = "jensencoat"
	flags_inv = 0
	siemens_coefficient = 0.6