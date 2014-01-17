
//Procedures in this file: Cardiac Surgery
///////////////////////////////////////////////////////////////
//					Cardiac Surgery							//
//////////////////////////////////////////////////////////////



/obj/item/organ/heart
	name = "heart"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-on"
	var/beating = 1

/obj/item/organ/heart/New()
	beating = 1
	spawn (60) beating=0

/obj/item/organ/heart/update_icon()
	if(beating)
		icon_state = "heart-on"
	else
		icon_state = "heart-off"


/datum/surgery_step/heartremoval/
	priority = 2
	can_infect = 1
	blood_level = 1
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (target_zone != "chest")
			return 0
		var/datum/organ/external/chest = target.get_organ("chest")
		if (!chest)
			return 0
		if (chest.open < 2)
			return 0
		return 1

/datum/surgery_step/appendectomy/cut_heart
	allowed_tools = list(
	/obj/item/weapon/scalpel = 100,		\
	/obj/item/weapon/kitchenknife = 100,	\
	/obj/item/weapon/kitchenknife/ritual = 100,\
	/obj/item/weapon/shard = 100
	)

	min_duration = 70
	max_duration = 90

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user] starts to separating [target]'s heart from the aortal vessels with \the [tool].", \
		"You start to separating [target]'s heart from the aortal vessels with \the [tool]." )
		target.custom_pain("The pain in your chest is living hell! ",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/external/chest = target.get_organ("chest")
		user.visible_message("\red [user] has separated [target]'s heart with \the [tool]." , \
		"\blue You have separated [target]'s heart with \the [tool].")
		target.apply_damage(5, BRUTE, "chest", 1)
		chest.createwound(CUT, 20, 1)

	/*fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/external/groin = target.get_organ("groin")
		user.visible_message("\red [user]'s hand slips, slicing an artery inside [target]'s chest with \the [tool]!", \
		"\red Your hand slips, slicing an artery inside [target]'s chest with \the [tool]!")
		groin.createwound(CUT, 50, 1)*/

/datum/surgery_step/appendectomy/remove_heart
	allowed_tools = list(
	/obj/item/weapon/hemostat = 100,	\
	/obj/item/weapon/wirecutters = 100,	\
	/obj/item/weapon/kitchenknife = 100,	\
	/obj/item/weapon/kitchen/utensil/fork = 100
	)

	min_duration = 60
	max_duration = 80

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return target_zone == "chest" && hasorgans(target)

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user] starts removing [target]'s heart with \the [tool].", \
		"You start removing [target]'s heart with \the [tool].")
		target.custom_pain("SOMEONE IS RIPPING YOUR HEART OUT!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user] has removed [target]'s heart with \the [tool].", \
		"\blue You have removed [target]'s heart with \the [tool].")
		user.attack_log += "\[[time_stamp()]\]<font color='red'> Removed heart from [target.name] ([target.ckey]) with [tool.name] (INTENT: [uppertext(user.a_intent)])</font>"
		target.attack_log += "\[[time_stamp()]\]<font color='orange'> Heart removed by [user.name] ([user.ckey]) with [tool.name] (INTENT: [uppertext(user.a_intent)])</font>"
		msg_admin_attack("[user.name] ([user.ckey]) removed heart from [target.name] ([target.ckey]) with [tool.name] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
		new /obj/item/weapon/reagent_containers/food/snacks/heart/(get_turf(target))
		target.death()

