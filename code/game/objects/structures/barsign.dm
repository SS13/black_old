/obj/structure/sign/double/barsign
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "empty"
	anchored = 1
	New()
		ChangeSign(pick("pinkflamingo", "magmasea", "limbo", "rustyaxe", "armokbar", "brokendrum", "meadbay", "thedamnwall", "thecavern", "cindikate", "theorchard", "thesaucyclown", "theclownshead","whiskeyimplant","carpecarp","robustroadhouse","greytide","theredshirt","maltese","pony","vault","solaris","hive","cantina","spess","asshole","dwarf","426", "jesus"))
		return
	proc/ChangeSign(var/Text)
		src.icon_state = "[Text]"
		luminosity = 2
		//on = 0
		//brightness_on = 4 //uncomment these when the lighting fixes get in
		return


/obj/structure/sign/barsign/neon
	icon = 'icons/obj/decals.dmi'
	icon_state = "neoncola"
	anchored = 1
	luminosity = 0
	var/on = 0
	New()
		ChangeSign(pick("neonbeer", "neoncola", "neondrinks", "neonloko"))
		return
	proc/ChangeSign(var/Text)
		src.icon_state = "[Text]"
		return


/obj/structure/sign/barsign/neon/attack_hand(mob/user as mob)
	visible_message("<span class='rose'>[user] flips neon sign power switch.</span>")
	playsound(src, 'sound/machines/click.ogg', 50, 0)
	add_fingerprint(user)
	on = !on

	if (on)
		luminosity = 1
		src.icon_state = "[icon_state-1]"
	else
		luminosity = 0
		src.icon_state = "[icon_state]"


/obj/structure/sign/barsign/neon/attack_paw(mob/user as mob)
	return attack_hand(user)