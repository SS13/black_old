obj/machinery/atmospherics/trinary
	dir = SOUTH
	initialize_directions = SOUTH|NORTH|WEST
	use_power = 1

	var/datum/gas_mixture/air1
	var/datum/gas_mixture/air2
	var/datum/gas_mixture/air3

	var/obj/machinery/atmospherics/node1
	var/obj/machinery/atmospherics/node2
	var/obj/machinery/atmospherics/node3

	var/datum/pipe_network/network1
	var/datum/pipe_network/network2
	var/datum/pipe_network/network3

	New()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = EAST|NORTH|SOUTH
			if(SOUTH)
				initialize_directions = SOUTH|WEST|NORTH
			if(EAST)
				initialize_directions = EAST|WEST|SOUTH
			if(WEST)
				initialize_directions = WEST|NORTH|EAST
		air1 = new
		air2 = new
		air3 = new

		air1.volume = 200
		air2.volume = 200
		air3.volume = 200

// Housekeeping and pipe network stuff below
	network_expand(datum/pipe_network/new_network, obj/machinery/atmospherics/pipe/reference)
		if(reference == node1)
			network1 = new_network

		else if(reference == node2)
			network2 = new_network

		else if (reference == node3)
			network3 = new_network

		if(new_network.normal_members.Find(src))
			return 0

		new_network.normal_members += src

		return null

	Del()
		loc = null

		if(node1)
			node1.disconnect(src)
			del(network1)
		if(node2)
			node2.disconnect(src)
			del(network2)
		if(node3)
			node3.disconnect(src)
			del(network3)

		node1 = null
		node2 = null
		node3 = null

		..()

	initialize()
		if(node1 && node2 && node3) return

		var/node1_connect = turn(dir, -180)
		var/node2_connect = turn(dir, -90)
		var/node3_connect = dir

		for(var/obj/machinery/atmospherics/target in get_step(src,node1_connect))
			if(target.initialize_directions & get_dir(target,src))
				node1 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node2_connect))
			if(target.initialize_directions & get_dir(target,src))
				node2 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node3_connect))
			if(target.initialize_directions & get_dir(target,src))
				node3 = target
				break

		update_icon()

		
		//add

		//add
	
	build_network()
		if(!network1 && node1)
			network1 = new /datum/pipe_network()
			network1.normal_members += src
			network1.build_network(node1, src)

		if(!network2 && node2)
			network2 = new /datum/pipe_network()
			network2.normal_members += src
			network2.build_network(node2, src)

		if(!network3 && node3)
			network3 = new /datum/pipe_network()
			network3.normal_members += src
			network3.build_network(node3, src)


	return_network(obj/machinery/atmospherics/reference)
		build_network()

		if(reference==node1)
			return network1

		if(reference==node2)
			return network2

		if(reference==node3)
			return network3

		return null

	reassign_network(datum/pipe_network/old_network, datum/pipe_network/new_network)
		if(network1 == old_network)
			network1 = new_network
		if(network2 == old_network)
			network2 = new_network
		if(network3 == old_network)
			network3 = new_network

		return 1

	return_network_air(datum/pipe_network/reference)
		var/list/results = list()

		if(network1 == reference)
			results += air1
		if(network2 == reference)
			results += air2
		if(network3 == reference)
			results += air3

		return results

	disconnect(obj/machinery/atmospherics/reference)
		if(reference==node1)
			del(network1)
			node1 = null

		else if(reference==node2)
			del(network2)
			node2 = null

		else if(reference==node3)
			del(network3)
			node3 = null

		return null

obj/machinery/atmospherics/trinary/mirrored

obj/machinery/atmospherics/trinary/filter
	icon = 'icons/obj/atmospherics/filter.dmi'
	icon_state = "intact_off"
	density = 1

	name = "Gas filter"

	req_access = list(access_atmospherics)

	var/on = 0
	var/temp = null // -- TLE

	var/target_pressure = ONE_ATMOSPHERE

	var/filter_type = 0
/*
Filter types:
-1: Nothing
 0: Carbon Molecules: Plasma Toxin, Oxygen Agent B
 1: Oxygen: Oxygen ONLY
 2: Nitrogen: Nitrogen ONLY
 3: Carbon Dioxide: Carbon Dioxide ONLY
 4: Sleeping Agent (N2O)
*/


	New()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = EAST|NORTH|SOUTH
			if(SOUTH)
				initialize_directions = SOUTH|WEST|NORTH
			if(EAST)
				initialize_directions = EAST|WEST|SOUTH
			if(WEST)
				initialize_directions = WEST|NORTH|EAST

	initialize()
		if(node1 && node2 && node3) return

		var/node1_connect = turn(dir, -180)
		var/node2_connect = turn(dir, -90)
		var/node3_connect = dir

		for(var/obj/machinery/atmospherics/target in get_step(src,node1_connect))
			if(target.initialize_directions & get_dir(target,src))
				node1 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node2_connect))
			if(target.initialize_directions & get_dir(target,src))
				node2 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node3_connect))
			if(target.initialize_directions & get_dir(target,src))
				node3 = target
				break
				
	var/frequency = 0
	var/datum/radio_frequency/radio_connection

	proc
		set_frequency(new_frequency)
			radio_controller.remove_object(src, frequency)
			frequency = new_frequency
			if(frequency)
				radio_connection = radio_controller.add_object(src, frequency, RADIO_ATMOSIA)

	New()
		if(radio_controller)
			initialize()
		..()

	update_icon()
		if(stat & NOPOWER)
			icon_state = "intact_off"
		else if(node2 && node3 && node1)
			icon_state = "intact_[on?("on"):("off")]"
		else
			icon_state = "intact_off"
			on = 0

		return

	power_change()
		var/old_stat = stat
		..()
		if(old_stat != stat)
			update_icon()

	process()
		..()
		if(!on)
			return 0

		var/output_starting_pressure = air3.return_pressure()

		if(output_starting_pressure >= target_pressure || air2.return_pressure() >= target_pressure )
			//No need to mix if target is already full!
			return 1

		//Calculate necessary moles to transfer using PV=nRT

		var/pressure_delta = target_pressure - output_starting_pressure
		var/transfer_moles

		if(air1.temperature > 0)
			transfer_moles = pressure_delta*air3.volume/(air1.temperature * R_IDEAL_GAS_EQUATION)

		//Actually transfer the gas

		if(transfer_moles > 0)
			var/datum/gas_mixture/removed = air1.remove(transfer_moles)

			if(!removed)
				return
			var/datum/gas_mixture/filtered_out = new
			filtered_out.temperature = removed.temperature

			switch(filter_type)
				if(0) //removing hydrocarbons
					filtered_out.toxins = removed.toxins
					removed.toxins = 0

					if(removed.trace_gases.len>0)
						for(var/datum/gas/trace_gas in removed.trace_gases)
							if(istype(trace_gas, /datum/gas/oxygen_agent_b))
								removed.trace_gases -= trace_gas
								filtered_out.trace_gases += trace_gas

				if(1) //removing O2
					filtered_out.oxygen = removed.oxygen
					removed.oxygen = 0

				if(2) //removing N2
					filtered_out.nitrogen = removed.nitrogen
					removed.nitrogen = 0

				if(3) //removing CO2
					filtered_out.carbon_dioxide = removed.carbon_dioxide
					removed.carbon_dioxide = 0

				if(4)//removing N2O
					if(removed.trace_gases.len>0)
						for(var/datum/gas/trace_gas in removed.trace_gases)
							if(istype(trace_gas, /datum/gas/sleeping_agent))
								removed.trace_gases -= trace_gas
								filtered_out.trace_gases += trace_gas

				else
					filtered_out = null


			air2.merge(filtered_out)
			air3.merge(removed)

		if(network2)
			network2.update = 1

		if(network3)
			network3.update = 1

		if(network1)
			network1.update = 1

		return 1

	initialize()
		set_frequency(frequency)
		..()

	attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
		if (!istype(W, /obj/item/weapon/wrench))
			return ..()
		var/turf/T = src.loc
		if (level==1 && isturf(T) && T.intact)
			user << "\red You must remove the plating first."
			return 1
		var/datum/gas_mixture/int_air = return_air()
		var/datum/gas_mixture/env_air = loc.return_air()
		if ((int_air.return_pressure()-env_air.return_pressure()) > 2*ONE_ATMOSPHERE)
			user << "\red You cannot unwrench this [src], it too exerted due to internal pressure."
			add_fingerprint(user)
			return 1
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		user << "\blue You begin to unfasten \the [src]..."
		if (do_after(user, 40))
			user.visible_message( \
				"[user] unfastens \the [src].", \
				"\blue You have unfastened \the [src].", \
				"You hear ratchet.")
			new /obj/item/pipe(loc, make_from=src)
			del(src)


obj/machinery/atmospherics/trinary/filter/attack_hand(user as mob) // -- TLE
	if(..())
		return

	if(!src.allowed(user))
		user << "\red Access denied."
		return

	var/dat
	var/current_filter_type
	switch(filter_type)
		if(0)
			current_filter_type = "Carbon Molecules"
		if(1)
			current_filter_type = "Oxygen"
		if(2)
			current_filter_type = "Nitrogen"
		if(3)
			current_filter_type = "Carbon Dioxide"
		if(4)
			current_filter_type = "Nitrous Oxide"
		if(-1)
			current_filter_type = "Nothing"
		else
			current_filter_type = "ERROR - Report this bug to the admin, please!"

	dat += {"
			<b>Power: </b><a href='?src=\ref[src];power=1'>[on?"On":"Off"]</a><br>
			<b>Filtering: </b>[current_filter_type]<br><HR>
			<h4>Set Filter Type:</h4>
			<A href='?src=\ref[src];filterset=0'>Carbon Molecules</A><BR>
			<A href='?src=\ref[src];filterset=1'>Oxygen</A><BR>
			<A href='?src=\ref[src];filterset=2'>Nitrogen</A><BR>
			<A href='?src=\ref[src];filterset=3'>Carbon Dioxide</A><BR>
			<A href='?src=\ref[src];filterset=4'>Nitrous Oxide</A><BR>
			<A href='?src=\ref[src];filterset=-1'>Nothing</A><BR>
			<HR><B>Desirable output pressure:</B>
			[src.target_pressure]kPa | <a href='?src=\ref[src];set_press=1'>Change</a>
			"}
/*
		user << browse("<HEAD><TITLE>[src.name] control</TITLE></HEAD>[dat]","window=atmo_filter")
		onclose(user, "atmo_filter")
		return

	if (src.temp)
		dat = text("<TT>[]</TT><BR><BR><A href='?src=\ref[];temp=1'>Clear Screen</A>", src.temp, src)
	//else
	//	src.on != src.on
*/
	user << browse("<HEAD><TITLE>[src.name] control</TITLE></HEAD><TT>[dat]</TT>", "window=atmo_filter")
	onclose(user, "atmo_filter")
	return

obj/machinery/atmospherics/trinary/filter/Topic(href, href_list) // -- TLE
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["filterset"])
		src.filter_type = text2num(href_list["filterset"])
	if (href_list["temp"])
		src.temp = null
	if(href_list["set_press"])
		var/new_pressure = input(usr,"Enter new output pressure (0-4500kPa)","Pressure control",src.target_pressure) as num
		src.target_pressure = max(0, min(4500, new_pressure))
	if(href_list["power"])
		on=!on
	src.update_icon()
	src.updateUsrDialog()
/*
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
*/
	return

obj/machinery/atmospherics/trinary/filter/mirrored
	icon_state = "intact_m_off"

	New()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = SOUTH|NORTH|WEST
			if(SOUTH)
				initialize_directions = NORTH|SOUTH|EAST
			if(WEST)
				initialize_directions = WEST|EAST|NORTH
			if(EAST)
				initialize_directions = EAST|WEST|SOUTH

	initialize()
		var/node1_dir
		var/node2_dir
		var/node3_dir

		node1_dir = turn(dir, 180)
		node2_dir = turn(dir, 90)
		node3_dir = dir

		for(var/obj/machinery/atmospherics/target in get_step(src,node1_dir))
			if(target.initialize_directions & get_dir(target,src))
				node1 = target
				break
		for(var/obj/machinery/atmospherics/target in get_step(src,node2_dir))
			if(target.initialize_directions & get_dir(target,src))
				node2 = target
				break
		for(var/obj/machinery/atmospherics/target in get_step(src,node3_dir))
			if(target.initialize_directions & get_dir(target,src))
				node3 = target
				break

	update_icon()
		if(stat & NOPOWER)
			icon_state = "intact_m_off"
		else if(node2 && node3 && node1)
			icon_state = "intact_m_[on?("on"):("off")]"
		else
			icon_state = "intact_m_off"
			on = 0

		return

obj/machinery/atmospherics/trinary/mixer
	icon = 'icons/obj/atmospherics/mixer.dmi'
	icon_state = "intact_off"
	density = 1

	name = "Gas mixer"

	req_access = list(access_atmospherics)

	var/on = 0

	var/target_pressure = ONE_ATMOSPHERE
	var/node1_concentration = 0.5
	var/node2_concentration = 0.5

	//node 3 is the outlet, nodes 1 & 2 are intakes
	
	New()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = EAST|NORTH|SOUTH
			if(SOUTH)
				initialize_directions = SOUTH|WEST|NORTH
			if(EAST)
				initialize_directions = EAST|WEST|SOUTH
			if(WEST)
				initialize_directions = WEST|NORTH|EAST

	initialize()
		if(node1 && node2 && node3) return

		var/node1_connect = turn(dir, -180)
		var/node2_connect = turn(dir, -90)
		var/node3_connect = dir

		for(var/obj/machinery/atmospherics/target in get_step(src,node1_connect))
			if(target.initialize_directions & get_dir(target,src))
				node1 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node2_connect))
			if(target.initialize_directions & get_dir(target,src))
				node2 = target
				break

		for(var/obj/machinery/atmospherics/target in get_step(src,node3_connect))
			if(target.initialize_directions & get_dir(target,src))
				node3 = target
				break

	update_icon()
		if(stat & NOPOWER)
			icon_state = "intact_off"
		else if(node2 && node3 && node1)
			icon_state = "intact_[on?("on"):("off")]"
		else
			icon_state = "intact_off"
			on = 0

		return

	power_change()
		var/old_stat = stat
		..()
		if(old_stat != stat)
			update_icon()

	New()
		..()
		air3.volume = 300

	process()
		..()
		if(!on)
			return 0

		var/output_starting_pressure = air3.return_pressure()

		if(output_starting_pressure >= target_pressure)
			//No need to mix if target is already full!
			return 1

		//Calculate necessary moles to transfer using PV=nRT

		var/pressure_delta = target_pressure - output_starting_pressure
		var/transfer_moles1 = 0
		var/transfer_moles2 = 0

		if(air1.temperature > 0)
			transfer_moles1 = (node1_concentration*pressure_delta)*air3.volume/(air1.temperature * R_IDEAL_GAS_EQUATION)

		if(air2.temperature > 0)
			transfer_moles2 = (node2_concentration*pressure_delta)*air3.volume/(air2.temperature * R_IDEAL_GAS_EQUATION)

		var/air1_moles = air1.total_moles()
		var/air2_moles = air2.total_moles()

		if((air1_moles < transfer_moles1) || (air2_moles < transfer_moles2))
			if(!transfer_moles1 || !transfer_moles2) return
			var/ratio = min(air1_moles/transfer_moles1, air2_moles/transfer_moles2)

			transfer_moles1 *= ratio
			transfer_moles2 *= ratio

		//Actually transfer the gas

		if(transfer_moles1 > 0)
			var/datum/gas_mixture/removed1 = air1.remove(transfer_moles1)
			air3.merge(removed1)

		if(transfer_moles2 > 0)
			var/datum/gas_mixture/removed2 = air2.remove(transfer_moles2)
			air3.merge(removed2)

		if(network1 && transfer_moles1)
			network1.update = 1

		if(network2 && transfer_moles2)
			network2.update = 1

		if(network3)
			network3.update = 1

		return 1

	attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
		if (!istype(W, /obj/item/weapon/wrench))
			return ..()
		var/turf/T = src.loc
		if (level==1 && isturf(T) && T.intact)
			user << "\red You must remove the plating first."
			return 1
		var/datum/gas_mixture/int_air = return_air()
		var/datum/gas_mixture/env_air = loc.return_air()
		if ((int_air.return_pressure()-env_air.return_pressure()) > 2*ONE_ATMOSPHERE)
			user << "\red You cannot unwrench this [src], it too exerted due to internal pressure."
			add_fingerprint(user)
			return 1
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		user << "\blue You begin to unfasten \the [src]..."
		if (do_after(user, 40))
			user.visible_message( \
				"[user] unfastens \the [src].", \
				"\blue You have unfastened \the [src].", \
				"You hear ratchet.")
			new /obj/item/pipe(loc, make_from=src)
			del(src)

	attack_hand(user as mob)
		if(..())
			return
		src.add_fingerprint(usr)
		if(!src.allowed(user))
			user << "\red Access denied."
			return
		usr.set_machine(src)
		var/dat = {"<b>Power: </b><a href='?src=\ref[src];power=1'>[on?"On":"Off"]</a><br>
					<b>Desirable output pressure: </b>
					[target_pressure]kPa | <a href='?src=\ref[src];set_press=1'>Change</a>
					<br>
					<b>Node 1 Concentration:</b>
					<a href='?src=\ref[src];node1_c=-0.1'><b>-</b></a>
					<a href='?src=\ref[src];node1_c=-0.01'>-</a>
					[node1_concentration]([node1_concentration*100]%)
					<a href='?src=\ref[src];node1_c=0.01'><b>+</b></a>
					<a href='?src=\ref[src];node1_c=0.1'>+</a>
					<br>
					<b>Node 2 Concentration:</b>
					<a href='?src=\ref[src];node2_c=-0.1'><b>-</b></a>
					<a href='?src=\ref[src];node2_c=-0.01'>-</a>
					[node2_concentration]([node2_concentration*100]%)
					<a href='?src=\ref[src];node2_c=0.01'><b>+</b></a>
					<a href='?src=\ref[src];node2_c=0.1'>+</a>
					"}

		user << browse("<HEAD><TITLE>[src.name] control</TITLE></HEAD><TT>[dat]</TT>", "window=atmo_mixer")
		onclose(user, "atmo_mixer")
		return

	Topic(href,href_list)
		if(..()) return
		if(href_list["power"])
			on = !on
		if(href_list["set_press"])
			var/new_pressure = input(usr,"Enter new output pressure (0-4500kPa)","Pressure control",src.target_pressure) as num
			src.target_pressure = max(0, min(4500, new_pressure))
		if(href_list["node1_c"])
			var/value = text2num(href_list["node1_c"])
			src.node1_concentration = max(0, min(1, src.node1_concentration + value))
			src.node2_concentration = max(0, min(1, src.node2_concentration - value))
		if(href_list["node2_c"])
			var/value = text2num(href_list["node2_c"])
			src.node2_concentration = max(0, min(1, src.node2_concentration + value))
			src.node1_concentration = max(0, min(1, src.node1_concentration - value))
		src.update_icon()
		src.updateUsrDialog()
		return

		
obj/machinery/atmospherics/trinary/mixer/mirrored
	icon_state = "intact_m_off"

	New()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = SOUTH|NORTH|WEST
			if(SOUTH)
				initialize_directions = NORTH|SOUTH|EAST
			if(WEST)
				initialize_directions = WEST|EAST|NORTH
			if(EAST)
				initialize_directions = EAST|WEST|SOUTH

	initialize()
		var/node1_dir
		var/node2_dir
		var/node3_dir

		for(var/obj/machinery/atmospherics/target in get_step(src,node1_dir))
			if(target.initialize_directions & get_dir(target,src))
				node1 = target
				break
		for(var/obj/machinery/atmospherics/target in get_step(src,node2_dir))
			if(target.initialize_directions & get_dir(target,src))
				node2 = target
				break
		for(var/obj/machinery/atmospherics/target in get_step(src,node3_dir))
			if(target.initialize_directions & get_dir(target,src))
				node3 = target
				break

	update_icon()
		if(stat & NOPOWER)
			icon_state = "intact_m_off"
		else if(node2 && node3 && node1)
			icon_state = "intact_m_[on?("on"):("off")]"
		else
			icon_state = "intact_m_off"
			on = 0

		return
		
