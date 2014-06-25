/* Contains:
 *		Slot machine
 *		Roulette
 *		Chips
 */
//SLOTS//
/obj/machinery/casino/slot_machine
	name = "Slot Machine"
	desc = "Gambling for the antisocial."
	icon = 'icons/obj/casino.dmi'
	icon_state = "slots-off"
	anchored = 1
	density = 1
//	mats = 10
	var/money = 25000
	var/plays = 0
	var/working = 0
	var/balance=0

	attack_hand(var/mob/user as mob)
		if(user.mind)
			if(user.mind.initial_account)
				balance = user.mind.initial_account.money
		user.machine = src
		if (src.working)
			var/dat = {"<B>Slot Machine</B><BR>
			<HR><BR>
			<B>Please wait!</B><BR>"}
			user << browse(dat, "window=slotmachine;size=450x500")
			onclose(user, "slotmachine")
		else
			var/dat = {"<B>Slot Machine</B><BR>
			<HR><BR>
			Five credits to play!<BR>
			<B>Prize Money Available:</B> [src.money]<BR>
			<B>Credits Remaining:</B> [balance]<BR>
			[src.plays] players have tried their luck today!<BR>
			<HR><BR>
			<A href='?src=\ref[src];ops=1'>Play!<BR>"}
			user << browse(dat, "window=slotmachine;size=400x500")
			onclose(user, "slotmachine")

	Topic(href, href_list)
		if(href_list["ops"])
			var/operation = text2num(href_list["ops"])
			if(operation == 1) // Play
				if (src.working == 1)
					usr << "\red You need to wait until the machine stops spinning!"
					return
				if (balance < 5)
					usr << "\red Insufficient money to play!"
					return
				usr.mind.initial_account.money -= 5
				src.money += 5
				src.plays += 1
				src.working = 1
				src.icon_state = "slots-on"
				usr << "Let's roll!"
				var/roll = rand(1,10000)
				spawn(100)
					if (roll == 1)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'JACKPOT! You win [src.money]!'", src), 1)
						command_alert("Congratulations [usr.name] on winning the Jackpot on one of our approved slot machines!", "Jackpot Winner")
						usr.mind.initial_account.money += src.money
						src.money = 0
						playsound(src.loc, 'sound/machines/ping.ogg', 100, 1)
					else if (roll > 1 && roll <= 10)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Big Winner! You win five thousand credits!'", src), 1)
						usr.mind.initial_account.money += 5000
						src.money -= 5000
						playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
					else if (roll > 10 && roll <= 100)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Winner! You win five hundred credits!'", src), 1)
						usr.mind.initial_account.money += 500
						src.money -= 500
						playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
					else if (roll > 100 && roll <= 1000)
						usr << "\blue You win a free game!"
						usr.mind.initial_account.money += 5
						src.money -= 5
					else
						usr << "\red No luck!"
					src.working = 0
					src.icon_state = "slots-off"
		src.add_fingerprint(usr)
		src.updateUsrDialog()
		return


/obj/machinery/casino/slot_machine/New()
	money = rand(10000,20000)
	..()

//ROULETTE//
/obj/machinery/casino/casino_roulette
	name = "Gaming Roulette"
	desc = "Gambling for the cream of society."
	icon = 'barsigns.dmi' //Well, I guess that's the first one they came across that houses 64*32 sprites
	icon_state = "rouletteoff"
	anchored = 1
	density = 1
	var/working = 0

	attack_hand(var/mob/user as mob)
		user.machine = src
		switch(alert(user, "You are using the Gaming Roulette right now! Will you place your bets on Black, Red or Zero?",,"Black","Red","Zero"))
			if("Red")
				user << "\red You have placed your bet on Red!"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, '[user] has placed their bet on Red!'", src), 1)
				src.working = 1
				src.icon_state = "rouletteon"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, 'Let's roll!'", src), 1)
				var/roll = rand(1,10000)
				spawn(100)
					if (roll >= 1 && roll <= 100)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Wonderfull! Zero occured!'", src), 1)
					else if (roll > 100 && roll <= 5000)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Red occured!'", src), 1)
					else
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Black occured!'", src), 1)
					src.working = 0
					src.icon_state = "rouletteoff"
				return
			if("Black")
				user << "\red You have placed your bet on Black!"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, '[user] has placed their bet on Black!'", src), 1)
				src.working = 1
				src.icon_state = "rouletteon"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, 'Let's roll!'", src), 1)
				var/roll = rand(1,10000)
				spawn(100)
					if (roll >= 1 && roll <= 100)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Wonderfull! Zero occured!'", src), 1)
					else if (roll > 100 && roll <= 5000)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Red occured!'", src), 1)
					else
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Black occured!'", src), 1)
					src.working = 0
					src.icon_state = "rouletteoff"
				return
			if("Zero")
				user << "\red You have placed your bet on Zero!"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, '[user] has placed their bet on Zero!'", src), 1)
				src.working = 1
				src.icon_state = "rouletteon"
				for(var/mob/O in hearers(src, null))
					O.show_message(text("<b>[]</b> says, 'Let's roll!'", src), 1)
				var/roll = rand(1,10000)
				spawn(100)
					if (roll >= 1 && roll <= 100)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Wonderfull! Zero occured!'", src), 1)
					else if (roll > 100 && roll <= 5000)
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Red occured!'", src), 1)
					else
						for(var/mob/O in hearers(src, null))
							O.show_message(text("<b>[]</b> says, 'Black occured!'", src), 1)
					src.working = 0
					src.icon_state = "rouletteoff"
				return

//CHIPS//
//Basically a copypasta of spacecash, so inherits all interactions - you can cash it in in ATMs, put in wallet, etc.

/obj/item/weapon/spacecash/chip
	name = "1 chip"
	desc = "It's worth 1 credit."
	gender = PLURAL
	icon = 'icons/obj/casino.dmi'
	icon_state = "redchip"

/obj/item/weapon/spacecash/chip/proc/update_cash()
	name = "[src.worth] chip"
	desc = "It's worth [src.worth] credits."
	if (src.worth < 1) del(src)
	else if (src.worth<20) src.icon_state = "redchipstack"
	else if (src.worth<50) src.icon_state = "yellowchipstack"
	else if (src.worth<100) src.icon_state = "greenchipstack"
	else if (src.worth<200) src.icon_state = "bluechipstack"
	else if (src.worth<500) src.icon_state = "chipstack"
	else src.icon_state = "chipstack"

/obj/item/weapon/spacecash/chip/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/spacecash/chip))
		src.worth+=W:worth
		user.drop_item()
		del(W)
		src.update_cash()

/obj/item/weapon/spacecash/chip/attack_self(mob/user as mob)
	var/cash = round(input(usr,"How many chips we gonna take?","Take some of chips",100) as num|null)
	if (cash > src.worth || cash < 1)
		return
	src.worth -= cash
	src.update_cash()
	var/obj/item/weapon/spacecash/chip/S = new
	S.worth = cash
	S.update_cash()
	if((user.hand && !user.r_hand)||(!user.hand && !user.l_hand))
		return user.put_in_inactive_hand(S)
	else
		S.loc = user.loc

/obj/item/weapon/spacecash/chip/c10
	name = "10 chip"
	icon_state = "whitechip"
	desc = "It's worth 10 credits."
	worth = 10

/obj/item/weapon/spacecash/chip/c20
	name = "20 chip"
	icon_state = "yellowchip"
	desc = "It's worth 20 credits."
	worth = 20

/obj/item/weapon/spacecash/c50
	name = "50 chip"
	icon_state = "greenchip"
	desc = "It's worth 50 credits."
	worth = 50

/obj/item/weapon/spacecash/c100
	name = "100 chip"
	icon_state = "bluechip"
	desc = "It's worth 100 credits."
	worth = 100
