////////////////////////////////////////////////////////////////////////
//////////////////////////////////*MEDICAL*/////////////////////////////
////////////////////////////////////////////////////////////////////////

//Gauze from cloth

/obj/item/stack/medical/bandage
	name = "roll of bandages"
	singular_name = "bandage length"
	desc = "Some crude bandages to wrap around wounds"
	icon_state = "bandages"
	item_state = "paper"
	origin_tech = "biotech=1"

/obj/item/stack/medical/bandage/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(..())
		return 1

	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/datum/organ/external/affecting = H.get_organ(user.zone_sel.selecting)

		if(!affecting.bandage())
			user << "\red The wounds on [M]'s [affecting.display_name] have already been bandaged."
			return 1
		else
			for (var/datum/wound/W in affecting.wounds)
				if (W.internal)
					continue
				if (W.current_stage <= W.max_bleeding_stage)
					user.visible_message( 	"\blue [user] bandages [W.desc] on [M]'s [affecting.display_name].", \
									"\blue You bandage [W.desc] on [M]'s [affecting.display_name]." )
				else if (istype(W,/datum/wound/bruise))
					user.visible_message( 	"\blue [user] places bandage patch over [W.desc] on [M]'s [affecting.display_name].", \
									"\blue You place bandage over [W.desc] on [M]'s [affecting.display_name]." )
			use(1)

/obj/item/clothing/mask/cloth
	name = "cloth mask"
	desc = "A handmade mask from cloth that covers mouth. Could probably protect you from inhaling something. Probably."
	icon_state = "handmade"
	item_state = "handmade"
	w_class = 1
	flags = FPRINT|TABLEPASS|MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.60
	permeability_coefficient = 0.01
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 20, rad = 0)
	can_eat = 0