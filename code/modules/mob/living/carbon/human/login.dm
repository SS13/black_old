/mob/living/carbon/human/Login()
	..()

	rebuild_appearance()

	if (!isturf(src.loc))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE

	return