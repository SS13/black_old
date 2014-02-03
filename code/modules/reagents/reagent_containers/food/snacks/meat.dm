/obj/item/weapon/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat"
	icon_state = "meat"
	health = 180
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		src.bitesize = 3


/obj/item/weapon/reagent_containers/food/snacks/meat/syntiflesh
	name = "synthetic meat"
	desc = "A synthetic slab of flesh."

/obj/item/weapon/reagent_containers/food/snacks/meat/human
	name = "-meat"
	var/subjectname = ""
	var/subjectjob = null


/obj/item/weapon/reagent_containers/food/snacks/meat/monkey
	//same as plain meat

/obj/item/weapon/reagent_containers/food/snacks/meat/corgi
	name = "Corgi meat"
	desc = "Tastes like... well you know..."


/obj/item/weapon/reagent_containers/food/snacks/meat/pug
	name = "Pug meat"
	desc = "Tastes like... well you know..."

/obj/item/weapon/reagent_containers/food/snacks/meat/innards
	name = "innards"
	desc = "Sone innards"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "innards"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/heart
	name = "heart"
	desc = "A heart"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-off"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/lung
	name = "lung"
	desc = "A lung"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "lungr"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/kidney
	name = "kidney"
	desc = "A kidney"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "kidneyl"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/pancreas
	name = "pancreas"
	desc = "A pancreas"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "pancreas"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/tongue
	name = "tongue"
	desc = "A tongue"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tongue"

/obj/item/weapon/reagent_containers/food/snacks/meat/innards/eyeball
	name = "eyeball"
	desc = "An eyeball"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "eyeball"