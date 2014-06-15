/obj/item/weapon/melee/chainofcommand
	name = "chain of command"
	desc = "A tool used by great men to placate the frothing masses."
	icon_state = "chain"
	item_state = "chain"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 10
	throwforce = 7
	w_class = 3
	origin_tech = "combat=4"
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is strangling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return (OXYLOSS)

obj/item/weapon/melee/scourge
	name = "scourge"
	desc = "A tool used to inflict severe corporal punishment or self-mortification. Fetishist`s favorite."
	icon_state = "scourge"
	item_state = "scourge"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 1
	throwforce = 1
	w_class = 2
	origin_tech = "combat=1"
	attack_verb = list("flogged", "whipped", "lashed", "disciplined", "punished", "chastised", "penalized")
	hitsound = 'sound/effects/snap.ogg'

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is strangling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return (OXYLOSS)

obj/item/weapon/melee/scourge/whip
	name = "archeological whip"
	desc = "Legend says ancient archeologists never left home without such a thing. Weird, right?"
	icon_state = "indianawhip"
	item_state = "scourge"
	attack_verb = list("flogged", "whipped", "lashed")