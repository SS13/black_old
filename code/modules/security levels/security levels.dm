/var/security_level = 0
//Security levels
//GREEN	 0
//YELLOW 1
//ORANGE 2
//BLUE	 3
//RED	 4
//DELTA	 5

//config.alert_desc_blue_downto

/proc/set_security_level(var/level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("yellow")
			level = SEC_LEVEL_YELLOW
		if("orange")
			level = SEC_LEVEL_ORANGE
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != security_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				world << "<font size=4 color='red'>Attention! Security level lowered to green</font>"
				world << "<font color='red'>[config.alert_desc_green]</font>"
				security_level = SEC_LEVEL_GREEN
				for(var/obj/machinery/firealarm/FA in world)
					if(FA.z == 1)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_green")
			if(SEC_LEVEL_YELLOW)
				if(security_level < SEC_LEVEL_YELLOW)
					world << "<font size=4 color='red'>Attention! Security level elevated to yellow</font>"
					world << "<font color='red'>[config.alert_desc_yellow_upto]</font>"
				else
					world << "<font size=4 color='red'>Attention! Security level lowered to yellow</font>"
					world << "<font color='red'>[config.alert_desc_yellow_downto]</font>"
				security_level = SEC_LEVEL_YELLOW
				////
			if(SEC_LEVEL_ORANGE)
				if(security_level < SEC_LEVEL_ORANGE)
					world << "<font size=4 color='red'>Attention! Security level elevated to orange</font>"
					world << "<font color='red'>[config.alert_desc_orange_upto]</font>"
				else
					world << "<font size=4 color='red'>Attention! Security level lowered to orange</font>"
					world << "<font color='red'>[config.alert_desc_orange_downto]</font>"
				security_level = SEC_LEVEL_ORANGE
				////
			if(SEC_LEVEL_BLUE)
				if(security_level < SEC_LEVEL_BLUE)
					world << "<font size=4 color='red'>Attention! Security level elevated to blue</font>"
					world << "<font color='red'>[config.alert_desc_blue_upto]</font>"
				else
					world << "<font size=4 color='red'>Attention! Security level lowered to blue</font>"
					world << "<font color='red'>[config.alert_desc_blue_downto]</font>"
				security_level = SEC_LEVEL_BLUE
				for(var/obj/machinery/firealarm/FA in world)
					if(FA.z == 1)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_blue")
			if(SEC_LEVEL_RED)
				if(security_level < SEC_LEVEL_RED)
					world << "<font size=4 color='red'>Attention! Code red! Code red!</font>"
					world << "<font color='red'>[config.alert_desc_red_upto]</font>"
				else
					world << "<font size=4 color='red'>Attention! Code red! Code red!</font>"
					world << "<font color='red'>[config.alert_desc_red_downto]</font>"
				security_level = SEC_LEVEL_RED

				/*	- At the time of commit, setting status displays didn't work properly
				var/obj/machinery/computer/communications/CC = locate(/obj/machinery/computer/communications,world)
				if(CC)
					CC.post_status("alert", "redalert")*/

				for(var/obj/machinery/firealarm/FA in world)
					if(FA.z == 1)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_red")
			if(SEC_LEVEL_DELTA)
				world << "<font size=4 color='red'>Attention! Delta security level reached!</font>"
				world << "<font color='red'>[config.alert_desc_delta]</font>"
				security_level = SEC_LEVEL_DELTA
				for(var/obj/machinery/firealarm/FA in world)
					if(FA.z == 1)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_delta")
	else
		return

/proc/get_security_level()
	switch(security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_YELLOW)
			return "yellow"
		if(SEC_LEVEL_ORANGE)
			return "orange"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(var/num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_YELLOW)
			return "yellow"
		if(SEC_LEVEL_ORANGE)
			return "orange"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(var/seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("yellow")
			return SEC_LEVEL_YELLOW
		if("orange")
			return SEC_LEVEL_ORANGE
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA


/*DEBUG
/mob/verb/set_thing0()
	set_security_level(0)
/mob/verb/set_thing1()
	set_security_level(1)
/mob/verb/set_thing2()
	set_security_level(2)
/mob/verb/set_thing3()
	set_security_level(3)
*/