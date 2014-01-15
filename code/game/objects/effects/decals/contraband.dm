
//########################## CONTRABAND ;3333333333333333333 -Agouri ###################################################

#define NUM_OF_POSTER_DESIGNS 43

/obj/item/weapon/contraband
	name = "contraband item"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = 0


/obj/item/weapon/contraband/poster
	name = "rolled-up poster"
	desc = "The poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface."
	icon_state = "rolled_poster"
	var/serial_number = 0
	var/obj/structure/sign/poster/resulting_poster = null //The poster that will be created is initialised and stored through contraband/poster's constructor


/obj/item/weapon/contraband/poster/New(turf/loc, var/given_serial = 0)
	if(given_serial == 0)
		serial_number = rand(1, NUM_OF_POSTER_DESIGNS)
		resulting_poster = new(serial_number)
	else
		serial_number = given_serial
		//We don't give it a resulting_poster because if we called it with a given_serial it means that we're rerolling an already used poster.
	name += " - No. [serial_number]"
	..(loc)


/*/obj/item/weapon/contraband/poster/attack(mob/M as mob, mob/user as mob)
	src.add_fingerprint(user)
	if(resulting_poster)
		resulting_poster.add_fingerprint(user)
	..()*/

/*/obj/item/weapon/contraband/poster/attack(atom/A, mob/user as mob) //This shit is handled through the wall's attackby()
	if(istype(A, /turf/simulated/wall))
		if(resulting_poster == null)
			return
		else
			var/turf/simulated/wall/W = A
			var/check = 0
			var/stuff_on_wall = 0
			for(var/obj/O in W.contents) //Let's see if it already has a poster on it or too much stuff
				if(istype(O,/obj/structure/sign/poster))
					check = 1
					break
				stuff_on_wall++
				if(stuff_on_wall == 3)
					check = 1
					break

			if(check)
				user << "<span class='notice'>The wall is far too cluttered to place a poster!</span>"
				return

			resulting_poster.loc = W //Looks like it's uncluttered enough. Place the poster
			W.contents += resulting_poster

			del(src)*/



//############################## THE ACTUAL DECALS ###########################

obj/structure/sign/poster
	name = "poster"
	desc = "A large piece of space-resistant printed paper. "
	icon = 'icons/obj/contraband.dmi'
	anchored = 1
	var/serial_number	//Will hold the value of src.loc if nobody initialises it
	var/ruined = 0


obj/structure/sign/poster/New(var/serial)

	serial_number = serial

	if(serial_number == loc)
		serial_number = rand(1, NUM_OF_POSTER_DESIGNS)	//This is for the mappers that want individual posters without having to use rolled posters.

	icon_state = "poster[serial_number]"

	switch(serial_number)
		if(1)
			name += " - Free Tonto"
			desc += " A framed shred of a much larger flag, colors bled together and faded from age."
		if(2)
			name += " - Atmosia Declaration of Independence"
			desc += " A relic of a failed rebellion"
		if(3)
			name += " - Fun Police"
			desc += " A poster condemning the station's security forces."
		if(4)
			name += " - Lusty Xeno"
			desc += " A heretical poster depicting the titular star of an equally heretical book."
		if(5)
			name += " - Syndicate Recruitment Poster"
			desc += " See the galaxy! Shatter corrupt megacorporations! Join today!"
		if(6)
			name += " - Clown"
			desc += " Honk."
		if(7)
			name += " - Smoke"
			desc += " A poster depicting a carton of cigarettes."
		if(8)
			name += " - Grey Tide"
			desc += " A rebellious poster symbolizing assistant solidarity."
		if(9)
			name += " - Missing Gloves"
			desc += " This poster is about the uproar that followed Nanotrasen's financial cuts towards insulated-glove purchases."
		if(10)
			name += " - Hacking Guide"
			desc += " This poster details the internal workings of the common Nanotrasen airlock."
		if(11)
			name += " - Smoking"
			desc += " A warning poster which reads 'Smoking'."
		if(12)
			name += " - Smoking"
			desc += " A warning poster which reads 'Smoking'."
		if(13)
			name += " - Emperor"
			desc += " Fight for the Emperor, and you may die. Do not fight for the Emperor, and you will die. We like to make your choice easier."
		if(14)
			name += " - NT Effect"
			desc += " This poster details the internal workings of the common Nanotrasen airlock."
		if(15)
			name += " - Pinup Girl Cindy"
			desc += " This particular one is of Nanotrasen's PR girl, Cindy, in a particularly feminine pose."
		if(16)
			name += " - Pinup Girl Amy"
			desc += " This particular one is of Amy, the nymphomaniac Urban Legend of Nanotrasen Space Stations. How this photograph came to be is not known."
		if(17)
			name += " - Underwater Laboratory"
			desc += " This particular one is of the fabled last crew of Nanotrasen's previous project before going big on Asteroid mining, Sealab."
		if(18)
			name += " - Martian Warlord"
			desc += " This particular one depicts the cartoony mug of a certain Martial Warmonger."
		if(19)
			name += " - Technological Singularity"
			desc += " This particular one is of the blood-curdling symbol of a long-since defeated enemy of humanity."
		if(20)
			name += " - Unlucky Space Explorer"
			desc += " This particular one depicts a skeletal form within a space suit."
		if(21)
			name += " - Wasteland"
			desc += " This particular one is of a couple of ragged gunmen, one male and one female, on top of a mound of rubble. The number \"13\" is visible on their blue jumpsuits."
		if(22)
			name += " - Augmented Legend"
			desc += " This particular one is of an obviously augmented individual, gazing towards the sky. The cyber-city in the backround is rather punkish."
		if(23)
			name += " - Dangerous Static"
			desc += " This particular one depicts nothing remarkable other than a rather mesmerising pattern of monitor static. There's a tag on the sides of the poster, urging you to \"tear this poster in half to receive your free sample\"."
		if(24)
			name += " - Paranoia"
			desc += " This particular one warns of the dangers of trusting your co-workers too much."
		if(25)
			name += " - Space Security Guard"
			desc += " This particular one is of a space security guard wearing distinctive Union Aerospace Corporation standart-issue armor. You wish the station security were this cool."
		if(26)
			name += " - The Biting Pear of Salamanca"
			desc += " The surrealist painting of the laughing fruit. Rumored to be a failed genetic experiment of L.L.Wat`s Laboratories, this fearsome creature escaped from the it`s cell to roam space freely and terrorize unsuspecting ship crews."
		if(27)
			name += " - Robot Warrior "
			desc += " This particular one depicts somewhat sentient blue robot that once defeated the infamous bandit duo of Snake Man & Toad Man themselves."
		if(28)
			name += " - Cupcake"
			desc += " This particular one is just a picture of a delicious cupcake. Yum!"
		if(29)
			name += " - Keep Calm"
			desc += " This particular one is of a famous New Earth design, although a bit modified."
		if(30)
			name += " - Levitating Skull"
			desc += " This particular one is the portrait of a certain flying, friendly and somewhat sex-crazed enchanted skull. Its adventures along with its fabled companion are now fading through history..."
		if(31)
			name += " - User of the Arcane Arts"
			desc += " This particular one depicts a wizard, casting a spell. You can't really make out if it's an actial photograph or a computer-generated image."
		if(32)
			name += " - Rogue AI"
			desc += " This particular one depicts the shell of the infamous AI that catastropically comandeered one of Nanotrasen's earliest space stations. Back then, the corporation was just known as TriOptimum."
		if(33)
			name += " - Positronic Logic Conflicts"
			desc += " This particular one depicts the cold, unmoving stare of a particular advanced AI."
		if(34)
			name += " - Don't Panic"
			desc += " This particular one depicts some sort of star in a grimace. The \"Don't Panic\" is written in big, friendly letters."
		if(35)
			name += " - RIP Badger"
			desc += " This poster commemorates the day hundreds of badgers worldwide were sacrificed for the greater good."
		if(36)
			name += " - Security  Recruitment Poster"
			desc += " This poster is a part of NT official internal police recruitment campaign. Join today!"
		if(37)
			name += " - East Interstellar Company"
			desc += " This poster is a large mark of The Royal East Interstellar Trading Company Of New London. Long live the Queen!"
		if(38)
			name += " - Passport"
			desc += " This poster depicts a Soviet colony passport. The text reads 'My comrade'."
		if(39)
			name += " - Okhotsuku-14"
			desc += " A coat of arms of Soviet colony Okhotsk-14. Strangely, the name of the colony is also written in hieroglyphs."
		if(40)
			name += " - KS 13"
			desc += "KS13 insignia. The slogan reads 'Glory to the space station of The New Comintern!"
		if(41)
			name += " - Army Glory"
			desc += " This poster depicts a cheerfull Space Red Army soldier in uniform. The slogan reads 'Glory to The Space Red Army!'"
		if(42)
			name += " - Borg Fancy v2"
			desc += " Borg Fancy, Now only taking the most fancy."
		if(43)
			name += " - Borg Fancy"
			desc += " Being fancy can be for any borg, Just need a suit."
		if(44)
			name += " - Lamarr"
			desc += " This poster depicts Lamarr. Probably made by the research director."
		if(45)
			name += " - Communist state"
			desc += " All hail the Communist party!"
		if(46)
			name += " - Donut Corp."
			desc += " This poster is an advertisement for Donut Corp."
		if(47)
			name += " - EAT"
			desc += " This poster is advising that you eat."
		else
			name = "This shit just bugged. Report it to Agouri - polyxenitopalidou@gmail.com"
			desc = "Why are you still here?"
	..()

obj/structure/sign/poster/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wirecutters))
		playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
		if(ruined)
			user << "<span class='notice'>You remove the remnants of the poster.</span>"
			del(src)
		else
			user << "<span class='notice'>You carefully remove the poster from the wall.</span>"
			roll_and_drop(user.loc)
			del(src)
		return


/obj/structure/sign/poster/attack_hand(mob/user as mob)
	if(ruined)
		return
	var/temp_loc = user.loc
	switch(alert("Do I want to rip the poster from the wall?","You think...","Yes","No"))
		if("Yes")
			if(user.loc != temp_loc)
				return
			visible_message("<span class='warning'>[user] rips [src] in a single, decisive motion!</span>" )
			playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, 1)
			ruined = 1
			icon_state = "poster_ripped"
			name = "ripped poster"
			desc = "You can't make out anything from the poster's original print. It's ruined."
			add_fingerprint(user)
		if("No")
			return

/obj/structure/sign/poster/proc/roll_and_drop(turf/loc)
	var/obj/item/weapon/contraband/poster/P = new(src, serial_number)
	P.resulting_poster = src
	P.loc = loc
	loc = P


//seperated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/simulated/wall/proc/place_poster(var/obj/item/weapon/contraband/poster/P, var/mob/user)
	if(!P.resulting_poster)	return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O,/obj/structure/sign/poster))
			user << "<span class='notice'>The wall is far too cluttered to place a poster!</span>"
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			user << "<span class='notice'>The wall is far too cluttered to place a poster!</span>"
			return

	user << "<span class='notice'>You start placing the poster on the wall...</span>" //Looks like it's uncluttered enough. Place the poster.

	//declaring D because otherwise if P gets 'deconstructed' we lose our reference to P.resulting_poster
	var/obj/structure/sign/poster/D = P.resulting_poster

	var/temp_loc = user.loc
	flick("poster_being_set",D)
	D.loc = src
	del(P)	//delete it now to cut down on sanity checks afterwards. Agouri's code supports rerolling it anyway
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, 1)

	sleep(17)
	if(!D)	return

	if(istype(src,/turf/simulated/wall) && user && user.loc == temp_loc)//Let's check if everything is still there
		user << "<span class='notice'>You place the poster!</span>"
	else
		D.roll_and_drop(temp_loc)
	return
