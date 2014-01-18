/obj/structure/sign/double/barsign
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "empty"
	anchored = 1
	New()
		ChangeSign(pick("pinkflamingo", "magmasea", "limbo", "rustyaxe", "armokbar", "brokendrum", "meadbay", "thedamnwall", "thecavern", "cindikate", "theorchard", "thesaucyclown", "theclownshead","whiskeyimplant","carpecarp","robustroadhouse","greytide","theredshirt"))
		return
	proc/ChangeSign(var/Text)
		src.icon_state = "[Text]"
		luminosity = 2
		//on = 0
		//brightness_on = 4 //uncomment these when the lighting fixes get in
		return
