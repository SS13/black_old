//Cloth salvaged from clothes

/obj/item/weapon/shard/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		if (prob(70))
			new /obj/item/stack/sheet/cloth( get_turf(usr.loc), 2 )
			usr << "\blue You cut some cloth from this clothes with the shard..."
			user.visible_message("\red [user] cuts some clothes into several pieces!")
			del(O)
			return
		else
			usr << "\blue You tried to cut out some cloth, but failed, the clothes is pretty useless now."
			user.visible_message("\red [user] cuts some clothes into several pieces, shredding it!")
			new /obj/item/weapon/reagent_containers/glass/rag( get_turf(usr.loc), 2 )
			del(O)
			return
	..()

/obj/item/weapon/scalpel/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		if (prob(95))
			new /obj/item/stack/sheet/cloth( get_turf(usr.loc), 2 )
			new /obj/item/stack/sheet/cloth( get_turf(usr.loc), 2 )
			usr << "\blue You cut some cloth from this clothes with the scalpel..."
			user.visible_message("\red [user] cuts some clothes into several pieces!")
			del(O)
			return
		else
			usr << "\blue You tried to cut out some cloth, but failed, the clothes is pretty useless now."
			user.visible_message("\red [user] cuts some clothes into several pieces, shredding it!")
			new /obj/item/weapon/reagent_containers/glass/rag( get_turf(usr.loc), 2 )
			del(O)
			return
	..()

/obj/item/weapon/kitchenknife/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/clothing/under))
		if (prob(80))
			new /obj/item/stack/sheet/cloth( get_turf(usr.loc), 2 )
			usr << "\blue You cut some cloth from this clothes with the knife..."
			user.visible_message("\red [user] cuts some clothes into several pieces!")
			del(O)
			return
		else
			usr << "\blue You tried to cut out some cloth, but failed, the clothes is pretty useless now."
			user.visible_message("\red [user] cuts some clothes into several pieces, shredding it!")
			new /obj/item/weapon/reagent_containers/glass/rag( get_turf(usr.loc), 2 )
			del(O)
			return
		return
	..()
