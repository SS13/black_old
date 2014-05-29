/mob
	var/bloody_hands = 0
	var/mob/living/carbon/human/bloody_hands_mob
	var/track_blood = 0
	var/list/feet_blood_DNA
	var/track_blood_type

/obj/item/clothing/gloves
	var/transfer_blood = 0
	var/mob/living/carbon/human/bloody_hands_mob

/obj/item/clothing/shoes/
	var/track_blood = 0

/obj/item/weapon/reagent_containers/glass/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = 1
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_state = "lgloves"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 5
	can_be_placed_into = null
	blood_DNA = list()

/obj/item/weapon/reagent_containers/glass/rag/attack_self(mob/user as mob)
	return

/obj/item/weapon/reagent_containers/glass/rag/attack(atom/target as obj|turf|area, mob/user as mob , flag)
	if(ismob(target) && target.reagents && reagents.total_volume)
		user.visible_message("\red \The [target] has been smothered with \the [src] by \the [user]!", "\red You smother \the [target] with \the [src]!", "You hear some struggling and muffled cries of surprise")
		src.reagents.reaction(target, TOUCH)
		spawn(5) src.reagents.clear_reagents()
		return
	else
		..()

/obj/item/weapon/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/user as mob)
	if(istype(A) && src in user)
		user.visible_message("[user] starts to wipe down [A] with [src]!")
		if(do_after(user,30))
			user.visible_message("[user] finishes wiping off the [A]!")
			A.clean_blood()
			del(A.fingerprints)
	if(istype(A, /turf/simulated) || istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay))
		user.visible_message("<span class='warning'>[user] begins to wipe the blood off of \the [get_turf(A)].</span>")
		if (A.blood_DNA)
			blood_DNA |= A.blood_DNA.Copy() //Does this work? Magic!
		if(do_after(user, 40))
			A.clean_blood(get_turf(A))
			user << "<span class='notice'>You have finished wiping!</span>"
			icon_state = "ragbloody"
			desc = "This rag is covered in blood."
			name = "bloody rag"
	return

/obj/item/weapon/reagent_containers/glass/rag/examine()
	if (!usr)
		return
	usr << "That's \a [name]."
	usr << desc
	return

