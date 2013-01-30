/sound/turntable/test
	file = 'TestLoop1.ogg'
	falloff = 2
	repeat = 1

/mob/var/music = 0

/obj/machinery/party/turntable
	name = "Turntable"
	desc = "A turntable used for parties and shit."
	icon = 'lasers2.dmi'
	icon_state = "Jukebox7"
	var/playing = 0
	anchored = 1

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

/obj/machinery/party/turntable/attack_hand(mob/user as mob)

	var/t = "<body background='http://pics.kz/i1/1e/ca/1eca739222cecbc8dac809d8897471f4.jpg'><br><br><br><div align='center'><table border='0'><B><font color='maroon' size='6'>J</font><font size='5' color='purple'>uke Box</font> <font size='5' color='green'>Interface</font></B><br><br><br><br>"
//	t += "<A href='?src=\ref[src];on=1'>On</A><br>"
	t += "<tr><td height='50' weight='50'></td><td height='50' weight='50'><A href='?src=\ref[src];off=1'><font color='maroon'>T</font><font color='geen'>urn</font> <font color='red'>Off</font></A></td><td height='50' weight='50'></td></tr>"
	t += "<tr><td height='50' weight='50'><A href='?src=\ref[src];on1=Track 1'><font color='maroon'>J</font><font color='purple'>awa Bar</font></A></td>"
	t += "<td height='50' weight='50'><A href='?src=\ref[src];on2=Track 2'><font color='maroon'>C</font><font color='green'>lassic 1</font></A></td>"
	t += "<td height='50' weight='50'><A href='?src=\ref[src];on6=Track 6'><font color='maroon'>C</font><font color='purple'>lassic 2</font></A></td></tr>"
	t += "<tr height='50' weight='50'><td><A href='?src=\ref[src];on5=Track 5'><font color='maroon'>I</font><font color='green'>n The Mood</font></A></td>"
	t += "<td height='50' weight='50'><A href='?src=\ref[src];on3=Track 3'><font color='maroon'>S</font><font color='purple'>oviet Theme</font></A></td>"
	t += "<td height='50' weight='50'><A href='?src=\ref[src];on7=Track 7'><font color='maroon'>T</font><font color='green'>he Assassination of Jesse James</font></A></td></tr>"
	t += "<tr><td height='50' weight='50'><A href='?src=\ref[src];on4=Track 4'><font color='maroon'>W</font><font color='purple'>ade In The Water</font></A><td height='50' weight='50'></td>"
	t += "<td height='50' weight='50'><A href='?src=\ref[src];on8=Track 8'><font color='maroon'>C</font><font color='purple'>ant Hardly Stand It</font></A></td><td height='50' weight='50'></td></tr>"
	t += "</table></div></body>"
	user << browse(t, "window=turntable;size=450x700")

/obj/machinery/party/turntable/Topic(href, href_list)
	..()

	if( href_list["on1"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('Cantina_Band_Jawa_Bar_Tatooine_Mos_Eisly.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on2"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('down_with_the_sickness.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on3"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('soviet_anthem.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on4"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('WadeInTheWater.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on5"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('GlennMiller-InTheMood.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on6"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('L.A.NoireSoundtrack.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on7"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('TheAssassinationofJesseJames.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	if( href_list["on8"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()

		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S = sound('CantHardlyStandIt.ogg')
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
			var/area/A = src.loc.loc
			for(var/obj/machinery/party/lasermachine/L in A)
				L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if(M.loc.loc == src.loc.loc && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(M.loc.loc != src.loc.loc && M.music == 1)
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
			var/area/A = src.loc.loc
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


