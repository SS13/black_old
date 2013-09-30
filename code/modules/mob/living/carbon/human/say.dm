/mob/living/carbon/human/say(var/message, var/meme_say = 0)

	if(silent && !meme_say)
		return

	//Mimes dont speak! Changeling hivemind and emotes are allowed.
	if(miming)
		if(length(message) >= 2)
			if(mind && mind.changeling)
				if(copytext(message, 1, 2) != "*" && department_radio_keys[copytext(message, 1, 3)] != "changeling")
					return
				else
					return ..(message)
			if(stat == DEAD)
				return ..(message)

		if(length(message) >= 1) //In case people forget the '*help' command, this will slow them the message and prevent people from saying one letter at a time
			if (copytext(message, 1, 2) != "*")
				return

	if(stat != DEAD)
		for(var/datum/disease/pierrot_throat/D in viruses)
			var/list/temp_message = text2list(message, " ") //List each word in the message
			var/list/pick_list = list()
			for(var/i = 1, i <= temp_message.len, i++) //Create a second list for excluding words down the line
				pick_list += i
			for(var/i=1, ((i <= D.stage) && (i <= temp_message.len)), i++) //Loop for each stage of the disease or until we run out of words
				if(prob(3 * D.stage)) //Stage 1: 3% Stage 2: 6% Stage 3: 9% Stage 4: 12%
					var/H = pick(pick_list)
					if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":")) continue
					temp_message[H] = "HONK"
					pick_list -= H //Make sure that you dont HONK the same word twice
				message = dd_list2text(temp_message, " ")

	if(wear_mask)
		if(istype(wear_mask, /obj/item/clothing/mask/luchador))
			if(copytext(message, 1, 2) != "*")
				if(prob(25))
					message += " OLE!"

		else if(istype(wear_mask, /obj/item/clothing/mask/horsehead))
			var/obj/item/clothing/mask/horsehead/hoers = wear_mask
			if(hoers.voicechange)
				if(!(copytext(message, 1, 2) == "*" || (mind && mind.changeling && department_radio_keys[copytext(message, 1, 3)] != "changeling")))
					message = pick("NEEIIGGGHHHH!", "NEEEIIIIGHH!", "NEIIIGGHH!", "HAAWWWWW!", "HAAAWWW!")

	if ((HULK in mutations) && health >= 25 && length(message))
		if(copytext(message, 1, 2) != "*")
			message = "[uppertext(message)]!!" //because I don't know how to code properly in getting vars from other files -Bro

	if (src.slurring)
		if(copytext(message, 1, 2) != "*")
			message = slur(message)
	..(message)

/mob/living/carbon/human/say_understands(var/other,var/datum/language/speaking = null)

	if(has_brain_worms()) //Brain worms translate everything. Even mice and alien speak.
		return 1
	if (istype(other, /mob/living/silicon/ai))
		return 1
	if (istype(other, /mob/living/silicon/decoy))
		return 1
	if (istype(other, /mob/living/silicon/pai))
		return 1
	if (istype(other, /mob/living/silicon/robot))
		return 1
	if (istype(other, /mob/living/carbon/brain))
		return 1
	if (istype(other, /mob/living/carbon/slime))
		return 1
	return ..()

/mob/living/carbon/human/GetVoice()
	if(istype(src.wear_mask, /obj/item/clothing/mask/gas/voice))
		var/obj/item/clothing/mask/gas/voice/V = src.wear_mask
		if(V.vchange)
			return V.voice
		else
			return name
	if(mind && mind.changeling && mind.changeling.mimicing)
		return mind.changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/proc/SetSpecialVoice(var/new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

