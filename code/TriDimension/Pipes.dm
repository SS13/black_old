obj/machinery/atmospherics/pipe
	simple/multiz
		icon = 'multiz_pipe.dmi'
		var/dir2 = 0

		get_connect_directions()
			return dir | dir2

		up
			dir2 = UP
			icon_state = "up"

			hide()
				update_icon()

		down
			dir2 = DOWN
			icon_state = "down"
		New()
			..()
			initialize_directions = dir | dir2

		update_icon()
			if(node1&&node2)

				if(node1dir > node2dir)
					var/t = node1dir
					node1dir = node2dir
					node2dir = t

				icon_state = "[dir2 == UP ? "up" : "down"][invisibility ? "-f" : "" ]"

				dir = (node1dir|node2dir) & (NORTH|EAST|SOUTH|WEST)