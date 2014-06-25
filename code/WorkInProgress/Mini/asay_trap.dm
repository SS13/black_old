/obj/effect/admin_log_trap
	name = "Marker" //Changed it slightly so players won't notice it when right-clicking a tile with the trigger in it.
	desc = "Stepping on this is good."
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x3" //Also changed icon so not to confuse mappers
	anchored = 1.0
	unacidable = 1
	invisibility = 101

/obj/effect/admin_log_trap/HasEntered(AM as mob|obj)
	if(istype(AM,/mob))
		message_admins("[AM] ([AM:ckey]) stepped on an alerted tile in [get_area(src)]. <a href=\"byond://?src=%admin_ref%;teleto=\ref[src.loc]\">Jump</a>", admin_ref = 1)
		log_game("[AM] ([AM:ckey]) stepped on an alerted tile in [get_area(src)] ([x],[y],[z])") //We also log it so we can check it out later in the logs