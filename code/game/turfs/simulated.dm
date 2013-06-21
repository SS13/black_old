/turf/simulated
	name = "station"
	var/wet = 0
	var/image/wet_overlay = null

	var/thermite = 0
	oxygen = MOLES_O2STANDARD
	nitrogen = MOLES_N2STANDARD
	var/to_be_destroyed = 0 //Used for fire, if a melting temperature was reached, it will be destroyed
	var/max_fire_temperature_sustained = 0 //The max temperature of the fire which it was subjected to

/turf/simulated/New()
	..()
	levelupdate()

/turf/simulated/Entered(atom/A, atom/OL)
	if(movement_disabled && usr.ckey != movement_disabled_exception)
		usr << "\red Movement is admin-disabled." //This is to identify lag problems
		return

	if (istype(A,/mob/living/carbon))
		var/mob/living/carbon/M = A
		if(M.lying)	return
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(istype(H.shoes, /obj/item/clothing/shoes/clown_shoes))
				var/obj/item/clothing/shoes/clown_shoes/O = H.shoes
				if(H.m_intent == "run")
					if(O.footstep >= 2)
						O.footstep = 0
						playsound(src, "clownstep", 50, 1) // this will get annoying very fast.
					else
						O.footstep++
				else
					playsound(src, "clownstep", 20, 1)

			if(istype(H.shoes, /obj/item/clothing/shoes/))
				var/obj/item/clothing/shoes/C = H.shoes
				if(H.m_intent == "run" && istype(src.loc,/turf/simulated/floor))
					if(C.footstep >= 2)
						C.footstep = 0
						playsound(src, "stepshoes", 20, 1) // this will get annoying very fast.
					else
						C.footstep++
				else
					playsound(src, "stepshoes", 10, 1)
/*
				if(H.m_intent == "run" && istype(src.loc,/turf/simulated/floor/carpet))
					if(C.footstep >= 2)
						C.footstep = 0
						playsound(src, "stepshoescarpet", 30, 1) // this will get annoying very fast.
					else
						C.footstep++
				else
					playsound(src, "stepshoescarpet", 15, 1)

				if(H.m_intent == "run" && istype(src.loc,/turf/simulated/floor/wood))
					if(C.footstep >= 2)
						C.footstep = 0
						playsound(src, "stepshoeswood", 30, 1) // this will get annoying very fast.
					else
						C.footstep++
				else
					playsound(src, "stepshoeswood", 15, 1)

				if(H.m_intent == "run" && istype(src.loc,/turf/simulated/floor/plating/airless/asteroid))
					if(C.footstep >= 2)
						C.footstep = 0
						playsound(src, "stepshoesand", 30, 1) // this will get annoying very fast.
					else
						C.footstep++
				else
					playsound(src, "stepshoesand", 15, 1)
*/
		switch (src.wet)
			if(1)
				if(istype(M, /mob/living/carbon/human)) // Added check since monkeys don't have shoes
					if ((M.m_intent == "run") && !(istype(M:shoes, /obj/item/clothing/shoes) && M:shoes.flags&NOSLIP))
						M.stop_pulling()
						step(M, M.dir)
						M << "\blue You slipped on the wet floor!"
						playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
						M.Stun(8)
						M.Weaken(5)
					else
						M.inertia_dir = 0
						return
				else if(!istype(M, /mob/living/carbon/slime))
					if (M.m_intent == "run")
						M.stop_pulling()
						step(M, M.dir)
						M << "\blue You slipped on the wet floor!"
						playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
						M.Stun(8)
						M.Weaken(5)
					else
						M.inertia_dir = 0
						return

			if(2) //lube		//can cause infinite loops - needs work
				if(!istype(M, /mob/living/carbon/slime))
					M.stop_pulling()
					step(M, M.dir)
					spawn(1) step(M, M.dir)
					spawn(2) step(M, M.dir)
					spawn(3) step(M, M.dir)
					spawn(4) step(M, M.dir)
					M.take_organ_damage(2) // Was 5 -- TLE
					M << "\blue You slipped on the floor!"
					playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
					M.Weaken(10)

	..()