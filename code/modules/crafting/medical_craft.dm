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
