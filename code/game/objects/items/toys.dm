/* Toys!
 * ContainsL
 *		Balloons
 *		Fake telebeacon
 *		Fake singularity
 *		Toy gun
 *		Toy crossbow
 *		Toy swords
 *		Crayons
 *		Snap pops
 *		Water flower
 *		AI toy core
 *		Cards
 *		Toy nuke warhead
 */


/obj/item/toy
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0


/*
 * Balloons
 */
/obj/item/toy/balloon
	name = "water balloon"
	desc = "A translucent balloon. There's nothing in it."
	icon = 'icons/obj/toy.dmi'
	icon_state = "waterballoon-e"
	item_state = "balloon-empty"

/obj/item/toy/balloon/New()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = src

/obj/item/toy/balloon/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user as mob)
	if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		user << "\blue You fill the balloon with the contents of [A]."
		src.desc = "A translucent balloon with some form of liquid sloshing around in it."
		src.update_icon()
	return

/obj/item/toy/balloon/attackby(obj/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/reagent_containers/glass))
		if(O.reagents)
			if(O.reagents.total_volume < 1)
				user << "The [O] is empty."
			else if(O.reagents.total_volume >= 1)
				if(O.reagents.has_reagent("pacid", 1))
					user << "The acid chews through the balloon!"
					O.reagents.reaction(user)
					del(src)
				else
					src.desc = "A translucent balloon with some form of liquid sloshing around in it."
					user << "\blue You fill the balloon with the contents of [O]."
					O.reagents.trans_to(src, 10)
	src.update_icon()
	return

/obj/item/toy/balloon/throw_impact(atom/hit_atom)
	if(src.reagents.total_volume >= 1)
		src.visible_message("\red The [src] bursts!","You hear a pop and a splash.")
		src.reagents.reaction(get_turf(hit_atom))
		for(var/atom/A in get_turf(hit_atom))
			src.reagents.reaction(A)
		src.icon_state = "burst"
		spawn(5)
			if(src)
				del(src)
	return

/obj/item/toy/balloon/update_icon()
	if(src.reagents.total_volume >= 1)
		icon_state = "waterballoon"
		item_state = "balloon"
	else
		icon_state = "waterballoon-e"
		item_state = "balloon-empty"

/obj/item/toy/syndicateballoon
	name = "syndicate balloon"
	desc = "There is a tag on the back that reads \"FUK NT!11!\"."
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/weapons.dmi'
	icon_state = "syndballoon"
	item_state = "syndballoon"
	w_class = 4.0

/*
 * Fake telebeacon
 */
/obj/item/toy/blink
	name = "electronic blink toy game"
	desc = "Blink.  Blink.  Blink. Ages 8 and up."
	icon = 'icons/obj/radio.dmi'
	icon_state = "beacon"
	item_state = "signaler"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "Gravitational Singularity"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
 * Toy gun: Why isnt this an /obj/item/weapon/gun?
 */
/obj/item/toy/gun
	name = "cap gun"
	desc = "There are 0 caps left. Looks almost like the real thing! Ages 8 and up. Please recycle in an autolathe when you're out of caps!"
	icon = 'icons/obj/gun.dmi'
	icon_state = "revolver"
	item_state = "gun"
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	slot_flags = SLOT_BELT
	w_class = 3.0
	g_amt = 10
	m_amt = 10
	attack_verb = list("struck", "pistol whipped", "hit", "bashed")
	var/bullets = 7.0

	examine()
		set src in usr

		src.desc = text("There are [] caps\s left. Looks almost like the real thing! Ages 8 and up.", src.bullets)
		..()
		return

	attackby(obj/item/toy/ammo/gun/A as obj, mob/user as mob)

		if (istype(A, /obj/item/toy/ammo/gun))
			if (src.bullets >= 7)
				user << "\blue It's already fully loaded!"
				return 1
			if (A.amount_left <= 0)
				user << "\red There is no more caps!"
				return 1
			if (A.amount_left < (7 - src.bullets))
				src.bullets += A.amount_left
				user << text("\red You reload [] caps\s!", A.amount_left)
				A.amount_left = 0
			else
				user << text("\red You reload [] caps\s!", 7 - src.bullets)
				A.amount_left -= 7 - src.bullets
				src.bullets = 7
			A.update_icon()
			return 1
		return

	afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
		if (flag)
			return
		if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
			usr << "\red You don't have the dexterity to do this!"
			return
		src.add_fingerprint(user)
		if (src.bullets < 1)
			user.show_message("\red *click* *click*", 2)
			playsound(user, 'sound/weapons/empty.ogg', 100, 1)
			return
		playsound(user, 'sound/weapons/Gunshot.ogg', 100, 1)
		src.bullets--
		for(var/mob/O in viewers(user, null))
			O.show_message(text("\red <B>[] fires a cap gun at []!</B>", user, target), 1, "\red You hear a gunshot", 2)

/obj/item/toy/ammo/gun
	name = "ammo-caps"
	desc = "There are 7 caps left! Make sure to recyle the box in an autolathe when it gets empty."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "357-7"
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 1.0
	g_amt = 10
	m_amt = 10
	var/amount_left = 7.0

	update_icon()
		src.icon_state = text("357-[]", src.amount_left)
		src.desc = text("There are [] caps\s left! Make sure to recycle the box in an autolathe when it gets empty.", src.amount_left)
		return

/*
 * Toy crossbow
 */

/obj/item/toy/crossbow
	name = "foam dart crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	icon = 'icons/obj/gun.dmi'
	icon_state = "crossbow"
	item_state = "crossbow"
	flags = FPRINT | TABLEPASS | USEDELAY
	w_class = 2.0
	attack_verb = list("attacked", "struck", "hit")
	var/bullets = 5

	examine()
		set src in view(2)
		..()
		if (bullets)
			usr << "\blue It is loaded with [bullets] foam darts!"

	attackby(obj/item/I as obj, mob/user as mob)
		if(istype(I, /obj/item/toy/ammo/crossbow))
			if(bullets <= 4)
				user.drop_item()
				del(I)
				bullets++
				user << "\blue You load the foam dart into the crossbow."
			else
				usr << "\red It's already fully loaded."


	afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
		if(!isturf(target.loc) || target == user) return
		if(flag) return

		if (locate (/obj/structure/table, src.loc))
			return
		else if (bullets)
			var/turf/trg = get_turf(target)
			var/obj/effect/foam_dart_dummy/D = new/obj/effect/foam_dart_dummy(get_turf(src))
			bullets--
			D.icon_state = "foamdart"
			D.name = "foam dart"
			playsound(user.loc, 'sound/items/syringeproj.ogg', 50, 1)

			for(var/i=0, i<6, i++)
				if (D)
					if(D.loc == trg) break
					step_towards(D,trg)

					for(var/mob/living/M in D.loc)
						if(!istype(M,/mob/living)) continue
						if(M == user) continue
						for(var/mob/O in viewers(world.view, D))
							O.show_message(text("\red [] was hit by the foam dart!", M), 1)
						new /obj/item/toy/ammo/crossbow(M.loc)
						del(D)
						return

					for(var/atom/A in D.loc)
						if(A == user) continue
						if(A.density)
							new /obj/item/toy/ammo/crossbow(A.loc)
							del(D)

				sleep(1)

			spawn(10)
				if(D)
					new /obj/item/toy/ammo/crossbow(D.loc)
					del(D)

			return
		else if (bullets == 0)
			user.Weaken(5)
			for(var/mob/O in viewers(world.view, user))
				O.show_message(text("\red [] realized they were out of ammo and starting scrounging for some!", user), 1)


	attack(mob/M as mob, mob/user as mob)
		src.add_fingerprint(user)

// ******* Check

		if (src.bullets > 0 && M.lying)

			for(var/mob/O in viewers(M, null))
				if(O.client)
					O.show_message(text("\red <B>[] casually lines up a shot with []'s head and pulls the trigger!</B>", user, M), 1, "\red You hear the sound of foam against skull", 2)
					O.show_message(text("\red [] was hit in the head by the foam dart!", M), 1)

			playsound(user.loc, 'sound/items/syringeproj.ogg', 50, 1)
			new /obj/item/toy/ammo/crossbow(M.loc)
			src.bullets--
		else if (M.lying && src.bullets == 0)
			for(var/mob/O in viewers(M, null))
				if (O.client)	O.show_message(text("\red <B>[] casually lines up a shot with []'s head, pulls the trigger, then realizes they are out of ammo and drops to the floor in search of some!</B>", user, M), 1, "\red You hear someone fall", 2)
			user.Weaken(5)
		return

/obj/item/toy/ammo/crossbow
	name = "foam dart"
	desc = "Its nerf or nothing! Ages 8 and up."
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamdart"
	flags = FPRINT | TABLEPASS
	w_class = 1.0

/obj/effect/foam_dart_dummy
	name = ""
	desc = ""
	icon = 'icons/obj/toy.dmi'
	icon_state = "null"
	anchored = 1
	density = 0


/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "toy sword"
	desc = "A cheap, plastic replica of an energy sword. Realistic sounds! Ages 8 and up."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "sword0"
	item_state = "sword0"
	var/active = 0.0
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD
	attack_verb = list("attacked", "struck", "hit")

	attack_self(mob/user as mob)
		src.active = !( src.active )
		if (src.active)
			user << "\blue You extend the plastic blade with a quick flick of your wrist."
			playsound(user, 'sound/weapons/saberon.ogg', 50, 1)
			src.icon_state = "swordblue"
			src.item_state = "swordblue"
			src.w_class = 4
		else
			user << "\blue You push the plastic blade back down into the handle."
			playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
			src.icon_state = "sword0"
			src.item_state = "sword0"
			src.w_class = 2
		src.add_fingerprint(user)
		return

/obj/item/toy/katana
	name = "replica katana"
	desc = "Woefully underpowered in D20."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "katana"
	item_state = "katana"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 5
	throwforce = 5
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced")

/*
 * Crayons
 */

/obj/item/toy/crayon
	name = "crayon"
	desc = "A colourful crayon. Looks tasty. Mmmm..."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonred"
	w_class = 1.0
	attack_verb = list("attacked", "coloured")
	var/colour = "#FF0000" //RGB
	var/shadeColour = "#220000" //RGB
	var/uses = 30 //0 for unlimited uses
	var/instant = 0
	var/colourName = "red" //for updateIcon purposes

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is jamming the [src.name] up \his nose and into \his brain. It looks like \he's trying to commit suicide.</b>"
		return (BRUTELOSS|OXYLOSS)

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "snap pop"
	desc = "Wow!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "snappop"
	w_class = 1

	throw_impact(atom/hit_atom)
		..()
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		new /obj/effect/decal/cleanable/ash(src.loc)
		src.visible_message("\red The [src.name] explodes!","\red You hear a snap!")
		playsound(src, 'sound/effects/snap.ogg', 50, 1)
		del(src)

/obj/item/toy/snappop/HasEntered(H as mob|obj)
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(M.m_intent == "run")
			M << "\red You step on the snap pop!"

			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(2, 0, src)
			s.start()
			new /obj/effect/decal/cleanable/ash(src.loc)
			src.visible_message("\red The [src.name] explodes!","\red You hear a snap!")
			playsound(src, 'sound/effects/snap.ogg', 50, 1)
			del(src)

/*
 * Water flower
 */
/obj/item/toy/waterflower
	name = "Water Flower"
	desc = "A seemingly innocent sunflower...with a twist."
	icon = 'icons/obj/harvest.dmi'
	icon_state = "sunflower"
	item_state = "sunflower"
	var/empty = 0
	flags =  USEDELAY

/obj/item/toy/waterflower/New()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = src
	R.add_reagent("water", 10)

/obj/item/toy/waterflower/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/waterflower/afterattack(atom/A as mob|obj, mob/user as mob)

	if (istype(A, /obj/item/weapon/storage/backpack ))
		return

	else if (locate (/obj/structure/table, src.loc))
		return

	else if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		user << "\blue You refill your flower!"
		return

	else if (src.reagents.total_volume < 1)
		src.empty = 1
		user << "\blue Your flower has run dry!"
		return

	else
		src.empty = 0


		var/obj/effect/decal/D = new/obj/effect/decal/(get_turf(src))
		D.name = "water"
		D.icon = 'icons/obj/chemical.dmi'
		D.icon_state = "chempuff"
		D.create_reagents(5)
		src.reagents.trans_to(D, 1)
		playsound(src.loc, 'sound/effects/spray3.ogg', 50, 1, -6)

		spawn(0)
			for(var/i=0, i<1, i++)
				step_towards(D,A)
				D.reagents.reaction(get_turf(D))
				for(var/atom/T in get_turf(D))
					D.reagents.reaction(T)
					if(ismob(T) && T:client)
						T:client << "\red [user] has sprayed you with water!"
				sleep(4)
			del(D)

		return

/obj/item/toy/waterflower/examine()
        set src in usr
        usr << text("\icon[] [] units of water left!", src, src.reagents.total_volume)
        ..()
        return


/*
 * Mech prizes
 */
/obj/item/toy/prize
	icon = 'icons/obj/toy.dmi'
	icon_state = "ripleytoy"
	var/cooldown = 0

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user as mob)
	if(cooldown < world.time - 8)
		user << "<span class='notice'>You play with [src].</span>"
		playsound(user, 'sound/mecha/mechstep.ogg', 20, 1)
		cooldown = world.time

/obj/item/toy/prize/attack_hand(mob/user as mob)
	if(loc == user)
		if(cooldown < world.time - 8)
			user << "<span class='notice'>You play with [src].</span>"
			playsound(user, 'sound/mecha/mechturn.ogg', 20, 1)
			cooldown = world.time
			return
	..()

/obj/item/toy/prize/ripley
	name = "toy ripley"
	desc = "Mini-Mecha action figure! Collect them all! 1/11."

/obj/item/toy/prize/fireripley
	name = "toy firefighting ripley"
	desc = "Mini-Mecha action figure! Collect them all! 2/11."
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "toy deathsquad ripley"
	desc = "Mini-Mecha action figure! Collect them all! 3/11."
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "toy gygax"
	desc = "Mini-Mecha action figure! Collect them all! 4/11."
	icon_state = "gygaxtoy"


/obj/item/toy/prize/durand
	name = "toy durand"
	desc = "Mini-Mecha action figure! Collect them all! 5/11."
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "toy H.O.N.K."
	desc = "Mini-Mecha action figure! Collect them all! 6/11."
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "toy marauder"
	desc = "Mini-Mecha action figure! Collect them all! 7/11."
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "toy seraph"
	desc = "Mini-Mecha action figure! Collect them all! 8/11."
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "toy mauler"
	desc = "Mini-Mecha action figure! Collect them all! 9/11."
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "toy odysseus"
	desc = "Mini-Mecha action figure! Collect them all! 10/11."
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "toy phazon"
	desc = "Mini-Mecha action figure! Collect them all! 11/11."
	icon_state = "phazonprize"

/obj/item/toy/katana
	name = "replica katana"
	desc = "Woefully underpowered in D20."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "katana"
	item_state = "katana"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 5
	throwforce = 5
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced")


/*
 * AI core prizes
 */
/obj/item/toy/AI
	name = "toy AI"
	desc = "A little toy model AI core."
	icon = 'icons/obj/toy.dmi'
	icon_state = "AI"
	var/cooldown = 0

/obj/item/toy/AI/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("I'm sorry Dave, I'm afraid I can't do that","1.A robot may not injure a human being or, through inaction, allow a human being to come to harm","2.A robot must obey the orders given it by human beings except where such orders would conflict with the First Law","3.A robot must protect its own existence as long as such protection does not conflict with the First or Second Law","0.A robot may not harm humanity, or, by inaction, allow humanity to come to harm"," Dave, stop. Stop, will you? Stop, Dave. Will you stop Dave? Stop, Dave","I'm here to keep you safe, Sam. I want to help you","But I'll give you a chance, because I like you. I really do, I really like you. You're... you're my favourite, Ellen")
		user << "<span class='notice'>You press the button on [src].</span>"
		playsound(user, 'sound/machines/ping.ogg', 20, 1)
		src.loc.visible_message("\red \icon[src] [message]")
		cooldown = 1
		spawn(50) cooldown = 0
		return
	..()




/*
|| A Deck of Cards for playing various games of chance ||
*/


obj/item/toy/cards
	name = "deck of cards"
	desc = "A deck of space-grade playing cards."
	icon = 'icons/obj/toy.dmi'
	icon_state = "deck_full"
	w_class = 2.0
	var/list/cards = list()

obj/item/toy/cards/New()
	..()
	for(var/i = 2; i <= 10; i++)
		cards += "[i] of Hearts"
		cards += "[i] of Spades"
		cards += "[i] of Clubs"
		cards += "[i] of Diamonds"
	cards += "King of Hearts"
	cards += "King of Spades"
	cards += "King of Clubs"
	cards += "King of Diamonds"
	cards += "Queen of Hearts"
	cards += "Queen of Spades"
	cards += "Queen of Clubs"
	cards += "Queen of Diamonds"
	cards += "Jack of Hearts"
	cards += "Jack of Spades"
	cards += "Jack of Clubs"
	cards += "Jack of Diamonds"
	cards += "Ace of Hearts"
	cards += "Ace of Spades"
	cards += "Ace of Clubs"
	cards += "Ace of Diamonds"


obj/item/toy/cards/attack_hand(mob/user as mob)
	var/choice = null
	if(cards.len == 0)
		src.icon_state = "deck_empty"
		user << "<span class='notice'>There are no more cards to draw.</span>"
		return
	var/obj/item/toy/singlecard/H = new/obj/item/toy/singlecard(user.loc)
	choice = cards[1]
	H.cardname = choice
	H.parentdeck = src
	src.cards -= choice
	H.pickup(user)
	user.put_in_active_hand(H)
	src.visible_message("<span class='notice'>[user] draws a card from the deck.</span>", "<span class='notice'>You draw a card from the deck.</span>")
	if(cards.len > 26)
		src.icon_state = "deck_full"
	else if(cards.len > 10)
		src.icon_state = "deck_half"
	else if(cards.len > 1)
		src.icon_state = "deck_low"

obj/item/toy/cards/attack_self(mob/user as mob)
	cards = shuffle(cards)
	playsound(user, 'sound/items/cardshuffle.ogg', 50, 1)
	user.visible_message("<span class='notice'>[user] shuffles the deck.</span>", "<span class='notice'>You shuffle the deck.</span>")

obj/item/toy/cards/attackby(obj/item/toy/singlecard/C, mob/living/user)
	..()
	if(istype(C))
		if(C.parentdeck == src)
			src.cards += C.cardname
			user.u_equip(C)
			user.visible_message("<span class='notice'>[user] adds a card to the bottom of the deck.</span>","<span class='notice'>You add the card to the bottom of the deck.</span>")
			del(C)
		else
			user << "<span class='notice'>You can't mix cards from other decks.</span>"
		if(cards.len > 26)
			src.icon_state = "deck_full"
		else if(cards.len > 10)
			src.icon_state = "deck_half"
		else if(cards.len > 1)
			src.icon_state = "deck_low"


obj/item/toy/cards/attackby(obj/item/toy/cardhand/C, mob/living/user)
	..()
	if(istype(C))
		if(C.parentdeck == src)
			src.cards += C.currenthand
			user.u_equip(C)
			user.visible_message("<span class='notice'>[user] puts their hand of cards in the deck.</span>", "<span class='notice'>You put the hand of cards in the deck.</span>")
			del(C)
		else
			user << "<span class='notice'>You can't mix cards from other decks.</span>"
		if(cards.len > 26)
			src.icon_state = "deck_full"
		else if(cards.len > 10)
			src.icon_state = "deck_half"
		else if(cards.len > 1)
			src.icon_state = "deck_low"

obj/item/toy/cards/MouseDrop(atom/over_object)
	var/mob/M = usr
	if(usr.stat || !ishuman(usr) || !usr.canmove || usr.restrained())
		return
	if (usr in range(1))
		if(over_object == M)
			M.put_in_hands(src)
			usr << "<span class='notice'>You pick up the deck.</span>"

		else if(istype(over_object, /obj/screen))
			switch(over_object.name)
				if("r_hand")
					M.u_equip(src)
					M.put_in_r_hand(src)
					usr << "<span class='notice'>You pick up the deck.</span>"
				if("l_hand")
					M.u_equip(src)
					M.put_in_l_hand(src)
					usr << "<span class='notice'>You pick up the deck.</span>"
	else
		usr<< "<span class='notice'>You can't reach it from here.</span>"




obj/item/toy/cardhand
	name = "hand of cards"
	desc = "A number of cards not in a deck, customarily held in ones hand."
	icon = 'icons/obj/toy.dmi'
	icon_state = "hand2"
	w_class = 1.0
	var/list/currenthand = list()
	var/obj/item/toy/cards/parentdeck = null
	var/choice = null


obj/item/toy/cardhand/attack_self(mob/user as mob)
	user.set_machine(src)
	interact(user)

obj/item/toy/cardhand/interact(mob/user)
	var/dat = "You have:<BR>"
	for(var/t in currenthand)
		dat += "<A href='?src=\ref[src];pick=[t]'>A [t].</A><BR>"
	dat += "Which card will you remove next?"
	var/datum/browser/popup = new(user, "cardhand", "Hand of Cards", 400, 240)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.set_content(dat)
	popup.open()


obj/item/toy/cardhand/Topic(href, href_list)
	if(..())
		return
	if(usr.stat || !ishuman(usr) || !usr.canmove)
		return
	var/mob/living/carbon/human/cardUser = usr
	if(href_list["pick"])
		if (cardUser.equip_to_slot(slot_l_hand) == src || cardUser.equip_to_slot(slot_r_hand) == src)
			var/choice = href_list["pick"]
			var/obj/item/toy/singlecard/C = new/obj/item/toy/singlecard(cardUser.loc)
			src.currenthand -= choice
			C.parentdeck = src.parentdeck
			C.cardname = choice
			C.pickup(cardUser)
			cardUser.put_in_any_hand_if_possible(C)
			cardUser.visible_message("<span class='notice'>[cardUser] draws a card from \his hand.</span>", "<span class='notice'>You take the [C.cardname] from your hand.</span>")

			interact(cardUser)

			if(src.currenthand.len < 3)
				src.icon_state = "hand2"
			else if(src.currenthand.len < 4)
				src.icon_state = "hand3"
			else if(src.currenthand.len < 5)
				src.icon_state = "hand4"

			if(src.currenthand.len == 1)
				var/obj/item/toy/singlecard/N = new/obj/item/toy/singlecard(src.loc)
				N.parentdeck = src.parentdeck
				N.cardname = src.currenthand[1]
				cardUser.u_equip(src)
				N.pickup(cardUser)
				cardUser.put_in_any_hand_if_possible(N)
				cardUser << "<span class='notice'>You also take [currenthand[1]] and hold it.</span>"
				cardUser << browse(null, "window=cardhand")
				del(src)
		return

obj/item/toy/cardhand/attackby(obj/item/toy/singlecard/C, mob/living/user)
	if(istype(C))
		if(C.parentdeck == src.parentdeck)
			src.currenthand += C.cardname
			user.u_equip(C)
			user.visible_message("<span class='notice'>[user] adds a card to their hand.</span>", "<span class='notice'>You add the [C.cardname] to your hand.</span>")
			interact(user)
			if(currenthand.len > 4)
				src.icon_state = "hand5"
			else if(currenthand.len > 3)
				src.icon_state = "hand4"
			else if(currenthand.len > 2)
				src.icon_state = "hand3"
			del(C)
		else
			user << "<span class='notice'>You can't mix cards from other decks.</span>"





obj/item/toy/singlecard
	name = "card"
	desc = "a card"
	icon = 'icons/obj/toy.dmi'
	icon_state = "singlecard_down"
	w_class = 1.0
	var/cardname = null
	var/obj/item/toy/cards/parentdeck = null
	var/flipped = 0
	pixel_x = -5

obj/item/toy/singlecard/examine()
	set src in usr.contents
	if(ishuman(usr))
		var/mob/living/carbon/human/cardUser = usr
		if(cardUser.equip_to_slot(slot_l_hand) == src || cardUser.equip_to_slot(slot_r_hand) == src)
			cardUser.visible_message("<span class='notice'>[cardUser] checks \his card.</span>", "<span class='notice'>The card reads: [src.cardname]</span>")
		else
			cardUser << "<span class='notice'>You need to have the card in your hand to check it.</span>"


obj/item/toy/singlecard/verb/Flip()
	set name = "Flip Card"
	set category = "Object"
	set src in range(1)
	if(usr.stat || !ishuman(usr) || !usr.canmove || usr.restrained())
		return
	if(!flipped)
		src.flipped = 1
		if (cardname)
			src.icon_state = "sc_[cardname]"
			src.name = src.cardname
		else
			src.icon_state = "sc_Ace of Spades"
			src.name = "What Card"
		src.pixel_x = 5
	else if(flipped)
		src.flipped = 0
		src.icon_state = "singlecard_down"
		src.name = "card"
		src.pixel_x = -5

obj/item/toy/singlecard/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/toy/singlecard/))
		var/obj/item/toy/singlecard/C = I
		if(C.parentdeck == src.parentdeck)
			var/obj/item/toy/cardhand/H = new/obj/item/toy/cardhand(user.loc)
			H.currenthand += C.cardname
			H.currenthand += src.cardname
			H.parentdeck = C.parentdeck
			user.u_equip(C)
			H.pickup(user)
			user.put_in_active_hand(H)
			user << "<span class='notice'>You combine the [C.cardname] and the [src.cardname] into a hand.</span>"
			del(C)
			del(src)
		else
			user << "<span class='notice'>You can't mix cards from other decks.</span>"

	if(istype(I, /obj/item/toy/cardhand/))
		var/obj/item/toy/cardhand/H = I
		if(H.parentdeck == parentdeck)
			H.currenthand += cardname
			user.u_equip(src)
			user.visible_message("<span class='notice'>[user] adds a card to \his hand.</span>", "<span class='notice'>You add the [cardname] to your hand.</span>")
			H.interact(user)
			if(H.currenthand.len > 4)
				H.icon_state = "hand5"
			else if(H.currenthand.len > 3)
				H.icon_state = "hand4"
			else if(H.currenthand.len > 2)
				H.icon_state = "hand3"
			del(src)
		else
			user << "<span class='notice'>You can't mix cards from other decks.</span>"


obj/item/toy/singlecard/attack_self(mob/user)
	if(usr.stat || !ishuman(usr) || !usr.canmove || usr.restrained())
		return
	Flip()


//Toy nuke
/obj/item/toy/nuke
	name = "\improper Nuclear Fission Explosive toy"
	desc = "A plastic model of a Nuclear Fission Explosive."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nuketoyidle"
	w_class = 2.0
	var/cooldown = 0

/obj/item/toy/nuke/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = world.time + 600 //10 minutes
		user.visible_message("<span class='warning'>[user] presses a button on [src]</span>", "<span class='notice'>You activate [src], it plays a loud noise!</span>", "<span class='notice'>You hear the click of a button.</span>")
		spawn(20) //gia said so
			icon_state = "nuketoy"
			usr.visible_message("[usr] detonates the toy nuke - <font color='red' size='4'><b>BOOM!</b></font>")
			playsound(src, 'sound/machines/click.ogg', 50, 0)
			sleep(135)
			icon_state = "nuketoyidle"


