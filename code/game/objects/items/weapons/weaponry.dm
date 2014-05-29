/obj/item/weapon/banhammer
	desc = "A banhammer"
	name = "banhammer"
	icon = 'icons/obj/items.dmi'
	icon_state = "toyhammer"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15
	attack_verb = list("banned")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is hitting \himself with the [src.name]! It looks like \he's trying to ban \himself from life.</b>"
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)

/obj/item/weapon/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of paranormal phenomenae."
	icon_state = "nullrod"
	item_state = "nullrod"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 15
	throw_speed = 1
	throw_range = 4
	throwforce = 10
	w_class = 1

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/nullrod/attack(mob/M as mob, mob/living/user as mob) //Paste from old-code to decult with a null rod.

	M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [M.name] ([M.ckey])</font>")

	msg_admin_attack("[user.name] ([user.ckey]) attacked [M.name] ([M.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "\red You don't have the dexterity to do this!"
		return

	if ((CLUMSY in user.mutations) && prob(50))
		user << "\red The rod slips out of your hand and hits your head."
		user.take_organ_damage(10)
		user.Paralyse(20)
		return

	if (M.stat !=2)
		if((M.mind in ticker.mode.cult) && prob(33))
			M << "\red The power of [src] clears your mind of the cult's influence!"
			user << "\red You wave [src] over [M]'s head and see their eyes become clear, their mind returning to normal."
			ticker.mode.remove_cultist(M.mind)
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red [] waves [] over []'s head.", user, src, M), 1)
		else if(prob(10))
			user << "\red The rod slips in your hand."
			..()
		else
			user << "\red The rod appears to do nothing."
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red [] waves [] over []'s head.", user, src, M), 1)
			return

/obj/item/weapon/nullrod/afterattack(atom/A, mob/user as mob)
	if (istype(A, /turf/simulated/floor))
		user << "\blue You hit the floor with the [src]."
		call(/obj/effect/rune/proc/revealrunes)(src)

/obj/item/weapon/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 2
	throwforce = 1
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return(BRUTELOSS)

/obj/item/weapon/sord/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	IsShield()
		return 1

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return(BRUTELOSS)

/obj/item/weapon/claymore/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/shuriken
	name = "shuriken"
	desc = "Throwing weapon of choice of all the ninjas lurking in the maintenance"
	icon_state = "shuriken"
	item_state = "shuriken"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 5
	throwforce = 25
	w_class = 1
	throw_speed = 5
	throw_range = 15

/obj/item/weapon/katana
	name = "katana"
	desc = "Woefully underpowered in D20"
	icon_state = "katana"
	item_state = "katana"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 20
	throwforce = 10
	w_class = 3
	m_amt = 20000
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</b>"
		return(BRUTELOSS)

/obj/item/weapon/katana/IsShield()
		return 1

/obj/item/weapon/katana/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/katana/wakizashi
	name = "wakizashi"
	desc = "Blademaster`s choice"
	icon_state = "wakizashi"
	item_state = "wakizashi"

/obj/item/weapon/katana/tachi
	name = "tachi"
	desc = "Truly, a monster of a blade. Let the heads roll!"
	icon_state = "tachi"
	item_state = "tachi"

/obj/item/weapon/naginata
	name = "naginata"
	desc = "Porearms are for rearu menu!"
	icon_state = "naginata"
	item_state = "naginata"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BACK
	force = 25
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is going to pierce \his stomach with the [src.name]! It looks like \he's not going do die dishonored.</b>"
		return(BRUTELOSS)

/obj/item/weapon/naginata/IsShield()
		return 1

/obj/item/weapon/naginata/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/naginata/yari
	name = "yari"
	desc = "No time to explain, stab `em all!"
	icon_state = "yari"
	item_state = "yari"

/obj/item/weapon/harpoon
	name = "harpoon"
	sharp = 1
	desc = "Tharr she blows!"
	icon_state = "harpoon"
	item_state = "harpoon"
	force = 20
	throwforce = 15
	w_class = 3
	attack_verb = list("jabbed","stabbed","ripped")

/obj/item/weapon/hatajirushi
	name = "hatajirushi"
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is Security"
	icon_state = "hatajirushisecurity"
	item_state = "hatajirushisecurity"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BACK
	force = 5
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "poked", "hit", "whacked")

/obj/item/weapon/hatajirushi/med
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is Medbay"
	icon_state = "hatajirushimedbay"
	item_state = "hatajirushimedbay"


/obj/item/weapon/hatajirushi/cargo
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is Cargobay"
	icon_state = "hatajirushicargo"
	item_state = "hatajirushicargo"

/obj/item/weapon/hatajirushi/rnd
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is RnD"
	icon_state = "hatajirushirnd"
	item_state = "hatajirushirnd"


/obj/item/weapon/hatajirushi/engie
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is Engieneering"
	icon_state = "hatajirushiengineering"
	item_state = "hatajirushiengineering"


/obj/item/weapon/hatajirushi/greytide
	desc = "This is a banner with your mon. Let your enemies know who defeated them. This one is Grey Ronins"
	icon_state = "hatajirushigreytide"
	item_state = "hatajirushigreytide"


obj/item/weapon/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "quarrel"
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 3
	throwforce = 5
	w_class = 3
	m_amt = 1000
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")
	var/wirecutters = 0

obj/item/weapon/wirerod/attackby(var/obj/item/I, mob/user as mob)
	..()
	if(istype(I, /obj/item/weapon/shard))
		if(wirecutters)
			user << "<span class='notice'>There are wirecutters on the pole already!</span>"
			return

		var/obj/item/weapon/twohanded/spear/S = new /obj/item/weapon/twohanded/spear
		user.before_take_item(I)
		user.before_take_item(src)
		user.put_in_hands(S)
		user << "<span class='notice'>You fasten the glass shard to the top of the rod with the cable.</span>"
		user.visible_message("<span class='notice'>[user] fastens a glass shard on top of the rod, making a spear.</span>")
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		del(I)
		del(src)

	if(istype(I, /obj/item/weapon/wirecutters))
		if(wirecutters)
			user << "<span class='notice'>There are wirecutters on the pole already!</span>"
			return

		else
			icon_state = "stunprod_nocell"
			user << "<span class='notice'>You fasten the wirecutters to the top of the rod with the cable, prongs outward.</span>"
			desc = "A rod with some wire wrapped around the top. Has cable attached, and wirecutters at the top. If only there was a power source...."
			playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
			wirecutters = 1
			del(I)

	if(istype(I, /obj/item/weapon/cell))
		if(wirecutters)
			var/obj/item/weapon/melee/baton/cattleprod/P = new /obj/item/weapon/melee/baton/cattleprod
			user.put_in_hands(P)
			user << "<span class='notice'>You fasten power cell to the top of the rod with cable and wirecutters.</span>"
			user.visible_message("<span class='notice'>[user] fastens a power cell to the rod wit a cable and wirecutters on it...</span>")
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
			del(I)
			del(src)
		else
			user << "<span class='notice'>You need to add sonething to the end of the pole to conduct charge, before you can add cell.</span>"
		return
