//This is where crafted hats, suits and unders go.

/obj/item/clothing/head/monkeypelt //Moved form head/misc. Yeah, gib 'em monkeys!
	name = "monkey pelt hat"
	desc = "What kind of minster would wear this?"
	icon_state = "monkeypelt"
	item_state = "monkeypelt"
	flags = FPRINT | TABLEPASS | BLOCKHAIR
	siemens_coefficient = 2.0


/obj/item/clothing/head/sheik
	name = " kufiya"
	icon_state = "sheik"
	desc = "Headwear of choice for arid environments, favored by Tajarans. Protects you head from heat."
	item_state = "sheik"
	flags = FPRINT | TABLEPASS | BLOCKHAIR
	flags_inv = HIDEEARS
	siemens_coefficient = 2.0
	heat_protection = HEAD
	max_heat_protection_temperature = (FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE /3)

/obj/item/clothing/under/sheik
	name = "thawb"
	icon_state = "sheik"
	desc = "Traditional garment of choice for arid environments, favored by Tajarans. Will keep you cool."
	item_state = "sheik"
	item_color = "sheik"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = (FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE /3)

