/sound/turntable/test
	file = 'TestLoop1.ogg'
	falloff = 2
	repeat = 1

/mob/var/music = 0

/obj/machinery/party/turntable
	name = "Jukebox"
	desc = "A jukebox is a partially automated music-playing device, usually a coin-operated machine, that will play a patron's selection from self-contained media."
	icon = 'lasers2.dmi'
	icon_state = "Jukeboxalt"
	var/playing = 0
	anchored = 1
	density = 1
	var/list/songs = list ("Jawa Bar",
		"Lonely Assistant Blues",
		"Chinatown",
		"Wade In The Water",
		"Blue Theme",
		"Beyond The Sea",
		"The Assassination of Jesse James",
		"Everyone Has Their Vices",
		"The Way You Look Tonight",
		"They Were All Dead",
		"Onizukas Blues",
		"Ragtime Piano",
		"It Had To Be You",
		"Janitorial Blues",
		"Lujon",
		"Mute Beat",
		"Groovy Times",
		"Under My Skin",
		"That`s All",
		"The Folks On The Hill")


/obj/machinery/party/mixer
	name = "mixer"
	desc = "A mixing board for mixing music"
	icon = 'lasers2.dmi'
	icon_state = "mixer"
	density = 0
	anchored = 1


/obj/machinery/party/turntable/New()
	..()
	sleep(2)
	new /sound/turntable/test(src)
	return

/obj/machinery/party/turntable/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/party/turntable/attack_hand(mob/living/user as mob)
	if (..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/t = "<body background = 'turntable.png' ><br><br><br><div align='center'>"
	t += "<B><font color='maroon' size='6'>J</font><font size='5' color='purple'>uke Box</font> <font size='5' color='green'>Interface</font></B>"
	t += "<br><br><br><br><A href='?src=\ref[src];off=1'><font color='maroon'>T</font><font color='geen'>urn</font> <font color='red'>Off</font></A>"
	t += "<table border='0'><tr>"
	for (var/i = 1, i<=(songs.len), i++)
		var/check = i%3
		t += "<td height='25' weight='70'><A href='?src=\ref[src];on=[i]'><font color='maroon'>[copytext(songs[i],1,2)]</font><font color='[(check==2) ? "green" : "purple"]'>[copytext(songs[i],2)]</font></A></td>"
		if(!check) t += "</tr><tr>"
	t += "</tr></table></div></body>"
	user << browse(t, "window=turntable;size=450x700")
	onclose(user, "urntable")
	return

/obj/machinery/party/turntable/Topic(href, href_list)
	..()
	if( href_list["on"])
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S
			switch (text2num(href_list["on"]))
				if(1) S = sound('Cantina.ogg')
				if(2) S = sound('AGrainOfSandInSandwich.ogg')
				if(3) S = sound('chinatown.ogg')
				if(4) S = sound('WadeInTheWater.ogg')
				if(5) S = sound('BlueTheme.ogg')
				if(6) S = sound('BeyondTheSea.ogg')
				if(7) S = sound('TheAssassinationOfJesseJames.ogg')
				if(8) S = sound('EveryoneHasTheirVices.ogg')
				if(9) S = sound('TheWayYouLookTonight.ogg')
				if(10) S = sound('TheyWereAllDead.ogg')
				if(11) S = sound('OnizukasBlues.ogg')
				if(12) S = sound('TheEntertainer.ogg')
				if(13) S = sound('ItHadToBeYou.ogg')
				if(14) S = sound('KyouWaYuuhiYarou.ogg')
				if(15) S = sound('Lujon.ogg')
				if(16) S = sound('MuteBeat.ogg')
				if(17) S = sound('GroovyTime.ogg')
				if(18) S = sound('IveGotYouUnderMySkin.ogg')
				if(19) S = sound('ThatsAll.ogg')
				if(20) S = sound('TheFolksWhoLiveOnTheHill.ogg')
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0
			//for(var/mob/M in world)
			//	if(M.loc.loc == src.loc.loc && M.music == 0)
			//		world << "Found the song..."
			//		M << S
			//		M.music = 1
			var/area/A = src.loc.loc:master

			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					var/area/location = get_area(M)
					if((location in A.related) && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(!(location in A.related) && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["off"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc:master
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()


/obj/machinery/party/lasermachine
	name = "laser machine"
	desc = "A laser machine that shoots lasers."
	icon = 'lasers2.dmi'
	icon_state = "lasermachine"
	anchored = 1
	var/mirrored = 0

/obj/effects/laser
	name = "laser"
	desc = "A laser..."
	icon = 'lasers2.dmi'
	icon_state = "laserred1"
	anchored = 1
	layer = 4

/obj/item/lasermachine/New()
	..()

/obj/machinery/party/lasermachine/proc/turnon()
	var/wall = 0
	var/cycle = 1
	var/area/A = get_area(src)
	var/X = 1
	var/Y = 0
	if(mirrored == 0)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred1"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred2"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred3"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
	if(mirrored == 1)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred1m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred2m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred3m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++



/obj/machinery/party/lasermachine/proc/turnoff()
	var/area/A = src.loc.loc
	for(var/area/RA in A.related)
		for(var/obj/effects/laser/F in RA)
			del(F)





