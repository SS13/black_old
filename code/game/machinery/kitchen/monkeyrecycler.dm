/obj/machinery/monkey_recycler
	name = "Monkey Recycler"
	desc = "A machine used for recycling dead monkeys into monkey cubes."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "monkeytocube_off"
	layer = 2.9
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 5
	active_power_usage = 50
	var/grinded = 0


/obj/machinery/monkey_recycler/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if (src.stat != 0) //NOPOWER etc
		return
	if (istype(O, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = O
		var/grabbed = G.affecting
		if(istype(grabbed, /mob/living/carbon/monkey))
			var/mob/living/carbon/monkey/target = grabbed
			if(target.stat == 0)
				user << "\red The monkey is struggling far too much to put it in the recycler."
			else
				user.drop_item()
				del(target)
				user << "\blue You stuff the monkey in the machine."
				icon_state = "monkeytocube-on"
				playsound(get_turf(src), 'sound/machines/juicer.ogg', 50, 1)
				use_power(500)
				src.grinded++
				user << "\blue The machine now has [grinded] monkeys worth of material stored."
				sleep(5)
				icon_state = "monkeytocube-off"

		else
			user << "\red The machine only accepts monkeys!"
	return

/obj/machinery/monkey_recycler/attack_hand(var/mob/user as mob)
	if (src.stat != 0) //NOPOWER etc
		return
	if(grinded >=4)
		user << "\blue The machine hisses loudly as it condenses the grinded monkey meat. After a moment, it dispenses a brand new monkey cube."
		playsound(get_turf(src), 'sound/machines/hiss.ogg', 50, 1)
		grinded -= 4
		new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(src.loc)
		user << "\blue The machine's display flashes that it has [grinded] monkeys worth of material left."
	else
		user << "\red The machine needs at least 4 monkeys worth of material to produce a monkey cube. It only has [grinded]."
	return
