//Blocks an attempt to connect before even creating our client datum thing.
world/IsBanned(key,address,computer_id)
//	if(ckey(key) in admins)
//		return ..()

	//Guest Checking
	if(IsGuestKey(key))
		log_access("Failed Login: [key] - Guests not allowed")
		message_admins("\blue Failed Login: [key] - Guests not allowed")
		return list("reason"="guest", "desc"="\nReason: Guests not allowed.brb")

	//whitelist
	if(!check_bwhitelist(ckey(key)))
		return list("reason"="not in whitelist", "desc"="\nYou are not in whitelist.\nGo to forum: http://forum.ss13.ru/index.php?showforum=48")

	//Ban Checking
	. = CheckBan( ckey(key), computer_id, address )
	if(.)
		log_access("Failed Login: [key] [computer_id] [address] - Banned [.["reason"]]")
		message_admins("\blue Failed Login: [key] id:[computer_id] ip:[address] - Banned [.["reason"]]")
		return .

	return ..()	//default pager ban stuff
