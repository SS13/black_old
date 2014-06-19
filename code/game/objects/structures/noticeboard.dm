/obj/structure/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard00"
	flags = FPRINT
	density = 0
	anchored = 1
	var/notices = 0

/obj/structure/noticeboard/initialize()
	for(var/obj/item/I in loc)
		if(notices > 4) break
		if(istype(I, /obj/item/weapon/paper))
			I.loc = src
			notices++
	icon_state = "nboard0[notices]"

//attaching papers!!
/obj/structure/noticeboard/attackby(var/obj/item/weapon/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/weapon/paper))
		if(notices < 5)
			O.add_fingerprint(user)
			add_fingerprint(user)
			user.drop_item()
			O.loc = src
			notices++
			icon_state = "nboard0[notices]"	//update sprite
			user << "<span class='notice'>You pin the paper to the noticeboard.</span>"
		else
			user << "<span class='notice'>You reach to pin your paper to the board but hesitate. You are certain your paper will not be seen among the many others already attached.</span>"

/obj/structure/noticeboard/attack_hand(user as mob)
	var/dat = "<B>Noticeboard</B><BR>"
	for(var/obj/item/weapon/paper/P in src)
		dat += "<A href='?src=\ref[src];read=\ref[P]'>[P.name]</A> <A href='?src=\ref[src];write=\ref[P]'>Write</A> <A href='?src=\ref[src];remove=\ref[P]'>Remove</A><BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=noticeboard")
	onclose(user, "noticeboard")


/obj/structure/noticeboard/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if((usr.stat || usr.restrained()))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["remove"])
		if((P && P.loc == src))
			P.loc = get_turf(src)	//dump paper on the floor because you're a clumsy fuck
			P.add_fingerprint(usr)
			add_fingerprint(usr)
			notices--
			icon_state = "nboard0[notices]"

	if(href_list["write"])
		if((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"])

		if((P && P.loc == src)) //ifthe paper's on the board
			if(istype(usr.r_hand, /obj/item/weapon/pen)) //and you're holding a pen
				add_fingerprint(usr)
				P.attackby(usr.r_hand, usr) //then do ittttt
			else
				if(istype(usr.l_hand, /obj/item/weapon/pen)) //check other hand for pen
					add_fingerprint(usr)
					P.attackby(usr.l_hand, usr)
				else
					usr << "<span class='notice'>You'll need something to write with!</span>"

	if(href_list["read"])
		var/obj/item/weapon/paper/P = locate(href_list["read"])
		if((P && P.loc == src))
			if(!( istype(usr, /mob/living/carbon/human) ))
				usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY><TT>[stars(P.info)]</TT></BODY></HTML>", "window=[P.name]")
				onclose(usr, "[P.name]")
			else
				usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY><TT>[P.info]</TT></BODY></HTML>", "window=[P.name]")
				onclose(usr, "[P.name]")
	return


/obj/structure/noticeboard/cargo/New()
	notices = 3
	icon_state = "nboard03"

	var/obj/item/weapon/paper/P = new()
	P.name = "Memo RE: proper stamping and marking"
	P.info = "Don`t forget to collect the supply manifests and stamp them, then send `em back on the shuttle. Don`t send them in boxes or any containers - the scanners won`t be able to scan anything whatsoever. We`ve been promised some rewards for following the procedures, so keep it neat."
	P.stamped = list(/obj/item/weapon/stamp)
	P.overlays = list("paper_stamped_qm")
	src.contents += P

	P = new()
	P.name = "Regarding the missing booze!"
	P.info = "Guys, that was not funny! I`m sending this note to all stations in this sector, okay, and I hope you see it. I nearly got fired because of the damn crate! Next time you wanna have a party on your station`s account, either call the corporate, or pay up front. -G."
	P.stamped = list(/obj/item/weapon/stamp/centcom)
	P.overlays = list("paper_stamped_cent")
	src.contents += P

	P = new()
	P.name = "RE: 'Special Orders And Inventory' - A friendly reminder from your friends here at Corporate"
	P.info = "On behalf of corporate dept, we once again remind you that any special orders must be validated by your supervisors. If compliance is not sustained, your files will be forwarded to HR dept for further penalization."
	P.stamped = list(/obj/item/weapon/stamp/centcom)
	P.overlays = list("paper_stamped_cent")
	src.contents += P

/obj/structure/noticeboard/brig/New()
	notices = 3
	icon_state = "nboard03"

	var/obj/item/weapon/paper/P = new()
	P.name = "Memo on ranking and command chain"
	P.info = "For now, a ranking system is to be followed. Security staff listed lowest to highest: Security Cadet, Security Officer, Security Corporal,Security Sergeant, Security Master Sergeant, Security Lieutenant, Security Assistant Chief, Head of Security. Heads of Staff have most of HoS' authority if no actual HoS is present. Detective or Forensic Technician reports directly to present HoS, acting commander or any other superior of security."
	P.stamped = list(/obj/item/weapon/stamp/hos/warden)
	P.overlays = list("paper_stamp_hos")
	src.contents += P

	P = new()
	P.name = "A Crash Course in Legal SOP on SS13"
	P.info = "<B>Roles:</B><BR>\nThe Detective is basically the investigator and prosecutor.<BR>\nThe Staff Assistant can perform these functions with written authority from the Detective.<BR>\nThe Captain/HoP/Warden is ct as the judicial authority.<BR>\nThe Security Officers are responsible for executing warrants, security during trial, and prisoner transport.<BR>\n<BR>\n<B>Investigative Phase:</B><BR>\nAfter the crime has been committed the Detective's job is to gather evidence and try to ascertain not only who did it but what happened. He must take special care to catalogue everything and don't leave anything out. Write out all the evidence on paper. Make sure you take an appropriate number of fingerprints. IF he must ask someone questions he has permission to confront them. If the person refuses he can ask a judicial authority to write a subpoena for questioning. If again he fails to respond then that person is to be jailed as insubordinate and obstructing justice. Said person will be released after he cooperates.<BR>\n<BR>\nONCE the FT has a clear idea as to who the criminal is he is to write an arrest warrant on the piece of paper. IT MUST LIST THE CHARGES. The FT is to then go to the judicial authority and explain a small version of his case. If the case is moderately acceptable the authority should sign it. Security must then execute said warrant.<BR>\n<BR>\n<B>Pre-Pre-Trial Phase:</B><BR>\nNow a legal representative must be presented to the defendant if said defendant requests one. That person and the defendant are then to be given time to meet (in the jail IS ACCEPTABLE). The defendant and his lawyer are then to be given a copy of all the evidence that will be presented at trial (rewriting it all on paper is fine). THIS IS CALLED THE DISCOVERY PACK. With a few exceptions, THIS IS THE ONLY EVIDENCE BOTH SIDES MAY USE AT TRIAL. IF the prosecution will be seeking the death penalty it MUST be stated at this time. ALSO if the defense will be seeking not guilty by mental defect it must state this at this time to allow ample time for examination.<BR>\nNow at this time each side is to compile a list of witnesses. By default, the defendant is on both lists regardless of anything else. Also the defense and prosecution can compile more evidence beforehand BUT in order for it to be used the evidence MUST also be given to the other side.\nThe defense has time to compile motions against some evidence here.<BR>\n<B>Possible Motions:</B><BR>\n1. <U>Invalidate Evidence-</U> Something with the evidence is wrong and the evidence is to be thrown out. This includes irrelevance or corrupt security.<BR>\n2. <U>Free Movement-</U> Basically the defendant is to be kept uncuffed before and during the trial.<BR>\n3. <U>Subpoena Witness-</U> If the defense presents god reasons for needing a witness but said person fails to cooperate then a subpoena is issued.<BR>\n4. <U>Drop the Charges-</U> Not enough evidence is there for a trial so the charges are to be dropped. The FT CAN RETRY but the judicial authority must carefully reexamine the new evidence.<BR>\n5. <U>Declare Incompetent-</U> Basically the defendant is insane. Once this is granted a medical official is to examine the patient. If he is indeed insane he is to be placed under care of the medical staff until he is deemed competent to stand trial.<BR>\n<BR>\nALL SIDES MOVE TO A COURTROOM<BR>\n<B>Pre-Trial Hearings:</B><BR>\nA judicial authority and the 2 sides are to meet in the trial room. NO ONE ELSE BESIDES A SECURITY DETAIL IS TO BE PRESENT. The defense submits a plea. If the plea is guilty then proceed directly to sentencing phase. Now the sides each present their motions to the judicial authority. He rules on them. Each side can debate each motion. Then the judicial authority gets a list of crew members. He first gets a chance to look at them all and pick out acceptable and available jurors. Those jurors are then called over. Each side can ask a few questions and dismiss jurors they find too biased. HOWEVER before dismissal the judicial authority MUST agree to the reasoning.<BR>\n<BR>\n<B>The Trial:</B><BR>\nThe trial has three phases.<BR>\n1. <B>Opening Arguments</B>- Each side can give a short speech. They may not present ANY evidence.<BR>\n2. <B>Witness Calling/Evidence Presentation</B>- The prosecution goes first and is able to call the witnesses on his approved list in any order. He can recall them if necessary. During the questioning the lawyer may use the evidence in the questions to help prove a point. After every witness the other side has a chance to cross-examine. After both sides are done questioning a witness the prosecution can present another or recall one (even the EXACT same one again!). After prosecution is done the defense can call witnesses. After the initial cases are presented both sides are free to call witnesses on either list.<BR>\nFINALLY once both sides are done calling witnesses we move onto the next phase.<BR>\n3. <B>Closing Arguments</B>- Same as opening.<BR>\nThe jury then deliberates IN PRIVATE. THEY MUST ALL AGREE on a verdict. REMEMBER: They mix between some charges being guilty and others not guilty (IE if you supposedly killed someone with a gun and you unfortunately picked up a gun without authorization then you CAN be found not guilty of murder BUT guilty of possession of illegal weaponry.). Once they have agreed they present their verdict. If unable to reach a verdict and feel they will never they call a deadlocked jury and we restart at Pre-Trial phase with an entirely new set of jurors.<BR>\n<BR>\n<B>Sentencing Phase:</B><BR>\nIf the death penalty was sought (you MUST have gone through a trial for death penalty) then skip to the second part. <BR>\nI. Each side can present more evidence/witnesses in any order. There is NO ban on emotional aspects or anything. The prosecution is to submit a suggested penalty. After all the sides are done then the judicial authority is to give a sentence.<BR>\nII. The jury stays and does the same thing as I. Their sole job is to determine if the death penalty is applicable. If NOT then the judge selects a sentence.<BR>\n<BR>\nTADA you're done. Security then executes the sentence and adds the applicable convictions to the person's record.<BR>\n"
	P.stamped = list(/obj/item/weapon/stamp/internal)
	P.overlays = list("paper_stamp-intaff")
	src.contents += P
