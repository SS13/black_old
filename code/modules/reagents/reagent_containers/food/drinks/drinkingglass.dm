

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass
	name = "glass"
	desc = "Your standard drinking glass."
	icon_state = "glass_empty"
	health = 5.0
	amount_per_transfer_from_this = 10
	volume = 50

	on_reagent_change()
		/*if(reagents.reagent_list.len > 1 )
			icon_state = "glass_brown"
			name = "Glass of Hooch"
			desc = "Two or more drinks, mixed together."*/
		/*else if(reagents.reagent_list.len == 1)
			for(var/datum/reagent/R in reagents.reagent_list)
				switch(R.id)*/
		if (reagents.reagent_list.len > 0)
			//mrid = R.get_master_reagent_id()
			switch(reagents.get_master_reagent_id())
				if("beer")
					icon_state = "beerglass"
					name = "Beer glass"
					desc = "A freezing pint of beer"
				if("beer2")
					icon_state = "beerglass"
					name = "Beer glass"
					desc = "A freezing pint of beer"
				if("ale")
					icon_state = "aleglass"
					name = "Ale glass"
					desc = "A freezing pint of delicious Ale"
				if("milk")
					icon_state = "glass_white"
					name = "Glass of milk"
					desc = "White and nutritious goodness!"
				if("cream")
					icon_state  = "glass_white"
					name = "Glass of cream"
					desc = "Ewwww..."
				if("chocolate")
					icon_state  = "chocolateglass"
					name = "Glass of chocolate"
					desc = "Tasty"
				if("lemonjuice")
					icon_state  = "lemonglass"
					name = "Glass of lemonjuice"
					desc = "Sour..."
				if("cola")
					icon_state  = "glass_brown"
					name = "Glass of Space Cola"
					desc = "A glass of refreshing Space Cola"
				if("nuka_cola")
					icon_state = "nuka_colaglass"
					name = "Nuka Cola"
					desc = "Don't cry, Don't raise your eye, It's only nuclear wasteland"
				if("orangejuice")
					icon_state = "glass_orange"
					name = "Glass of Orange juice"
					desc = "Vitamins! Yay!"
				if("tomatojuice")
					icon_state = "glass_red"
					name = "Glass of Tomato juice"
					desc = "Are you sure this is tomato juice?"
				if("blood")
					icon_state = "glass_red"
					name = "Glass of Tomato juice"
					desc = "Are you sure this is tomato juice?"
				if("limejuice")
					icon_state = "glass_green"
					name = "Glass of Lime juice"
					desc = "A glass of sweet-sour lime juice."
				if("whiskey")
					icon_state = "whiskeyglass"
					name = "Glass of whiskey"
					desc = "The silky, smokey whiskey goodness inside the glass makes the drink look very classy."
				if("bourbon")
					icon_state = "whiskeyglass"
					name = "Glass of bourbon"
					desc = "Smokey, with caramel nose and long lasting sweety finish. No compromises."
				if("gin")
					icon_state = "ginvodkaglass"
					name = "Glass of gin"
					desc = "A crystal clear glass of gin."
				if("vodka")
					icon_state = "ginvodkaglass"
					name = "Glass of vodka"
					desc = "The glass contain wodka. Xynta."
				if("vodkaroyale")
					icon_state = "vodkaroyaleglass"
					name = "Vodka Royale"
					desc = "You really should have chosen vermouth instead of vodka."
				if("tiniroyale")
					icon_state = "tiniroyaleglass"
					name = "Tini Royale"
					desc = "The official drink of Festival du Holofilm de New Cannes. Maybe you should have chosen vodka instead of vermouth?"
				if("sake")
					icon_state = "ginvodkaglass"
					name = "Glass of Sake"
					desc = "A glass of Sake."
				if("goldschlager")
					icon_state = "ginvodkaglass"
					name = "Glass of goldschlager"
					desc = "100 proof that teen girls will drink anything with gold in it."
				if("wine")
					icon_state = "wineglass"
					name = "Glass of wine"
					desc = "A very classy looking drink."
				if("prosecco")
					icon_state = "proseccoglass"
					name = "Glass of prosecco"
					desc = "For when you really need a classy refreshment."
				if("rossini")
					icon_state = "rossiniglass"
					name = "Rossini"
					desc = "For when ordinary bubbles are not festive enough. Whait, what it this red thing?"
				if("wardenswife")
					icon_state = "wardenswifeglass"
					name = "Warden`s Wife"
					desc = "Is it whiskey? Is it wine? Is that thing sparkling?! You can`t even tell anymore!"
				if("kir_petillant")
					icon_state = "kirpetillantglass"
					name = "Kir Petillant"
					desc = "For those who are not classy enough to sip rossini. A girly drink."
				if("cognac")
					icon_state = "cognacglass"
					name = "Glass of cognac"
					desc = "Damn, you feel like some kind of French aristocrat just by holding this."
				if ("kahlua")
					icon_state = "kahluaglass"
					name = "Glass of RR coffee Liquor"
					desc = "DAMN, THIS THING LOOKS ROBUST"
				if("vermouth")
					icon_state = "vermouthglass"
					name = "Glass of Vermouth"
					desc = "You wonder why you're even drinking this straight."
				if("tequilla")
					icon_state = "tequillaglass"
					name = "Glass of Tequilla"
					desc = "Now all that's missing is the weird colored shades!"
				if("patron")
					icon_state = "patronglass"
					name = "Glass of Patron"
					desc = "Drinking patron in the bar, with all the subpar ladies."
				if("rum")
					icon_state = "rumglass"
					name = "Glass of Rum"
					desc = "Now you want to Pray for a pirate suit, don't you?"
				if("gintonic")
					icon_state = "gintonicglass"
					name = "Gin and Tonic"
					desc = "A mild but still great cocktail. Drink up, like a true Englishman."
				if("kingsmen")
					icon_state = "kingsmenglass"
					name = "All The King`s Men"
					desc = "And all the king`s men got wasted on this monstrosity."
				if("whiskeycola")
					icon_state = "whiskeycolaglass"
					name = "Whiskey Cola"
					desc = "An innocent-looking mixture of cola and Whiskey. Delicious."
				if("bourboncola")
					icon_state = "whiskeycolaglass"
					name = "Bourbon Cola"
					desc = "An innocent-looking mixture of cola and Bourbon. Delicious."
				if("whiterussian")
					icon_state = "whiterussianglass"
					name = "White Russian"
					desc = "A very nice looking drink. But that's just, like, your opinion, man."
				if("greenstar")
					icon_state = "greenstarglass"
					name = "Green Star"
					desc = "Sweet somewhat plain tropical taste. Not a great one, actually."
				if("icecoffee")
					icon_state = "icecoffeeglass"
					name = "Rhode Island Ice Coffee"
					desc = "Neither it has coffee in it, nor it has anything to do with Rhode Island, it is pretty strong. Your White Russian on steroids."
				if("screwdrivercocktail")
					icon_state = "screwdriverglass"
					name = "Screwdriver"
					desc = "A simple, yet superb mixture of Vodka and orange juice. Just the thing for the tired engineer."
				if("bloodymary")
					icon_state = "bloodymaryglass"
					name = "Bloody Mary"
					desc = "Tomato juice, mixed with Vodka and a lil' bit of lime. Tastes like liquid murder."
				if("martini")
					icon_state = "martiniglass"
					name = "Classic Martini"
					desc = "Damn, the bartender even stirred it, not shook it."
				if("vodkamartini")
					icon_state = "martiniglass"
					name = "Vodka martini"
					desc ="A bastardisation of the classic martini. Still great."
				if("limoncellomartini")
					icon_state = "limoncellomartiniglass"
					name = "Limoncello Martini"
					desc ="An Italian twist on classic cocktail."
				if("gargleblaster")
					icon_state = "gargleblasterglass"
					name = "Pan-Galactic Gargle Blaster"
					desc = "Does... does this mean that Arthur and Ford are on the station? Oh joy."
				if("bravebull")
					icon_state = "bravebullglass"
					name = "Brave Bull"
					desc = "Tequilla and Coffee liquor, brought together in a mouthwatering mixture. Drink up."
				if("tequillasunrise")
					icon_state = "tequillasunriseglass"
					name = "Tequilla Sunrise"
					desc = "Oh great, now you feel nostalgic about sunrises back on Terra..."
				if("toxinsspecial")
					icon_state = "toxinsspecialglass"
					name = "Toxins Special"
					desc = "Whoah, this thing is on FIRE"
				if("beepskysmash")
					icon_state = "beepskysmashglass"
					name = "Beepsky Smash"
					desc = "Heavy, hot and strong. Just like the Iron fist of the LAW."
				if("doctorsdelight")
					icon_state = "doctorsdelightglass"
					name = "Doctor's Delight"
					desc = "A healthy mixture of juices, guaranteed to keep you healthy until the next toolboxing takes place."
				if("manlydorf")
					icon_state = "manlydorfglass"
					name = "The Manly Dorf"
					desc = "A manly concotion made from Ale and Beer. Intended for true men only."
				if("assistantshighball")
					icon_state = "assistantshighballglass"
					name = "Assistant`s Highball"
					desc = "What looks to be a pint of ale is not ale actually, but ale and bouron! Wow! Takes an assistant to drink."
				if("irishcream")
					icon_state = "irishcreamglass"
					name = "Irish Cream"
					desc = "It's cream, mixed with whiskey. What else would you expect from the Irish?"
				if("cubalibre")
					icon_state = "cubalibreglass"
					name = "Cuba Libre"
					desc = "A classic mix of rum and cola."
				if("b52")
					icon_state = "b52glass"
					name = "B-52"
					desc = "Kahlua, Irish Cream, and congac. You will get bombed."
				if("b53")
					icon_state = "b53glass"
					name = "B-53"
					desc = "Kahlua, Irish Cream, and absinthe. You better hold tight."
				if("evelynwhite")
					icon_state = "evelynwhiteglass"
					name = "evelynwhite"
					desc = "They say this drink was invented in a shower cabin by two girls doing stuff. Kinky!."
				if("schlagerloko")
					icon_state = "schlagerlokoglass"
					name = "Schlagerloko"
					desc = "Surprisingly tasty but potent mixture of Goldschlager and Thirteen Loko. Gives a pleasant tongue tingle."
				if("vodkaredwing")
					icon_state = "schlagerlokoglass"
					name = "Vodka Red Wing"
					desc = "Classic mix for those who need a boost."
				if("spacemonkey")
					icon_state = "spacemonkeyglass"
					name = "Space Monkey"
					desc = "May or may not contain monkeys. Best garnished with banana."
				if("atomicbomb")
					icon_state = "atomicbombglass"
					name = "Atomic Bomb"
					desc = "Nanotrasen cannot take legal responsibility for your actions after imbibing."
				if("longislandicedtea")
					icon_state = "longislandicedteaglass"
					name = "Long Island Iced Tea"
					desc = "The liquor cabinet, brought together in a delicious mix. Intended for middle-aged alcoholic women only."
				if("blueislandicedtea")
					icon_state = "blueislandicedteaglass"
					name = "Blue Island Iced Tea"
					desc = "'It had to ne you/Could make me be true, could make me be blue'"
				if("threemileisland")
					icon_state = "threemileislandglass"
					name = "Three Mile Island Ice Tea"
					desc = "A glass of this is sure to prevent a meltdown."
				if("margarita")
					icon_state = "margaritaglass"
					name = "Margarita"
					desc = "On the rocks with salt on the rim. Arriba~!"
				if("bluemargarita")
					icon_state = "bluemargaritaglass"
					name = "Blue Margarita"
					desc = "On the rocks with salt on the rim. Wait, why is it blue, again?"
				if("sidecar")
					icon_state = "sidecarglass"
					name = "Sidecar"
					desc = "Named after the shuttle sidecar in which the good captain with drinking problem was driven to and from the station where the drink was born and christened."
				if("blackrussian")
					icon_state = "blackrussianglass"
					name = "Black Russian"
					desc = "For the lactose-intolerant. Still as classy as a White Russian."
				if("vodkatonic")
					icon_state = "vodkatonicglass"
					name = "Vodka and Tonic"
					desc = "For when a gin and tonic isn't russian enough."
				if("manhattan")
					icon_state = "manhattanglass"
					name = "Manhattan"
					desc = "The Detective's undercover drink of choice. He never could stomach gin..."
				if("manhattan_proj")
					icon_state = "proj_manhattanglass"
					name = "Manhattan Project"
					desc = "A scienitst drink of choice, for thinking how to blow up the station."
				if("ginfizz")
					icon_state = "ginfizzglass"
					name = "Gin Fizz"
					desc = "Refreshingly lemony, deliciously dry."
				if("planterspunch")
					icon_state = "planterspunchglass"
					name = "Planter`s Punch"
					desc = "‘This recipe I give to thee. Dear brother in the heat…`"
				if("mojito")
					icon_state = "mojitoglass"
					name = "Mojito"
					desc = "With approval from both pillaging space pirates and a Space Nobel Prize winner, The Mojito has become a classic loved the galaxy over."
				if("daiquiri")
					icon_state = "daiquiriglass"
					name = "daiquiri"
					desc = "'There's no whiskey or gin around here... time to doctor up the local rum.'"
				if("melondaiquiri")
					icon_state = "melondaiquiriglass"
					name = "melondaiquiri"
					desc = "'There's no whiskey or gin around here... time to doctor up the local rum.' With a melon twist, yeah."
				if("irishcoffee")
					icon_state = "irishcoffeeglass"
					name = "Irish Coffee"
					desc = "Coffee and alcohol. More fun than a Mimosa to drink in the morning."
				if("hooch")
					icon_state = "glass_brown2"
					name = "Hooch"
					desc = "You've really hit rock bottom now... your liver packed its bags and left last night."
				if("whiskeysoda")
					icon_state = "whiskeysodaglass2"
					name = "Whiskey Soda"
					desc = "Ultimate refreshment."
				if("bourbonsoda")
					icon_state = "whiskeysodaglass2"
					name = "Bourbon Soda"
					desc = "Ultimate refreshment."
				if("oldfashioned")
					icon_state = "oldfashionedglass"
					name = "Old Fashioned"
					desc = "The Old Fahioned. If the name doesn`t ring a bell, you probably shouldn`t be in a bar."
				if("tonic")
					icon_state = "glass_clear"
					name = "Glass of Tonic Water"
					desc = "Quinine tastes funny, but at least it'll keep that Space Malaria away."
				if("sodawater")
					icon_state = "glass_clear"
					name = "Glass of Soda Water"
					desc = "Soda water. Why not make a scotch and soda?"
				if("water")
					icon_state = "glass_clear"
					name = "Glass of Water"
					desc = "The father of all refreshments."
				if("spacemountainwind")
					icon_state = "Space_mountain_wind_glass"
					name = "Glass of Space Mountain Wind"
					desc = "Space Mountain Wind. As you know, there are no mountains in space, only wind."
				if("thirteenloko")
					icon_state = "thirteen_loko_glass"
					name = "Glass of Thirteen Loko"
					desc = "This is a glass of Thirteen Loko, it appears to be of the highest quality. The drink, not the glass"
				if("redwing")
					icon_state = "thirteen_loko_glass"
					name = "Glass of Red Wing"
					desc = "A glass of Red Wing. Caution: may give you wings!"
				if("dr_gibb")
					icon_state = "dr_gibb_glass"
					name = "Glass of Dr. Gibb"
					desc = "Dr. Gibb. Not as dangerous as the name might imply."
				if("space_up")
					icon_state = "space-up_glass"
					name = "Glass of Space-up"
					desc = "Space-up. It helps keep your cool."
				if("moonshine")
					icon_state = "glass_clear"
					name = "Moonshine"
					desc = "You've really hit rock bottom now... your liver packed its bags and left last night."
				if("soymilk")
					icon_state = "glass_white"
					name = "Glass of soy milk"
					desc = "White and nutritious soy goodness!"
				if("berryjuice")
					icon_state = "berryjuice"
					name = "Glass of berry juice"
					desc = "Berry juice. Or maybe its jam. Who cares?"
				if("poisonberryjuice")
					icon_state = "poisonberryjuice"
					name = "Glass of poison berry juice"
					desc = "A glass of deadly juice."
				if("carrotjuice")
					icon_state = "carrotjuice"
					name = "Glass of  carrot juice"
					desc = "It is just like a carrot but without crunching."
				if("banana")
					icon_state = "banana"
					name = "Glass of banana juice"
					desc = "The raw essence of a banana. HONK"
				if("bahama_mama")
					icon_state = "bahama_mama"
					name = "Bahama Mama"
					desc = "Tropic cocktail"
				if("bluelagoon")
					icon_state = "bluelagoon"
					name = "Blue Lagoon"
					desc = "The Blue Lagoon will take you to times spent on the golden sand of holodeck with bright blue holowaves lapping around your feet."
				if("singulo")
					icon_state = "singulo"
					name = "Singulo"
					desc = "A blue-space beverage."
				if("alliescocktail")
					icon_state = "alliescocktail"
					name = "Allies cocktail"
					desc = "A drink made from your allies."
				if("antifreeze")
					icon_state = "antifreeze"
					name = "Anti-freeze"
					desc = "The ultimate refreshment."
				if("barefoot")
					icon_state = "b&p"
					name = "Barefoot"
					desc = "Barefoot and pregnant"
				if("demonsblood")
					icon_state = "demonsblood"
					name = "Demons Blood"
					desc = "Just looking at this thing makes the hair at the back of your neck stand up."
				if("booger")
					icon_state = "booger"
					name = "Booger"
					desc = "Ewww..."
				if("snowwhite")
					icon_state = "snowwhite"
					name = "Snow White"
					desc = "A cold refreshment."
				if("aloe")
					icon_state = "aloe"
					name = "Aloe"
					desc = "Very, very, very good."
				if("andalusia")
					icon_state = "andalusia"
					name = "Andalusia"
					desc = "A nice, strange named drink."
				if("sbiten")
					icon_state = "sbitenglass"
					name = "Sbiten"
					desc = "A spicy mix of Vodka and Spice. Very hot."
				if("red_mead")
					icon_state = "red_meadglass"
					name = "Red Mead"
					desc = "A True Vikings Beverage, though its color is strange."
				if("mead")
					icon_state = "meadglass"
					name = "Mead"
					desc = "A Vikings Beverage, though a cheap one."
				if("iced_beer")
					icon_state = "iced_beerglass"
					name = "Iced Beer"
					desc = "A beer so frosty, the air around it freezes."
				if("grog")
					icon_state = "grogglass"
					name = "Grog"
					desc = "A fine and cepa drink for Space."
				if("soy_latte")
					icon_state = "soy_latte"
					name = "Soy Latte"
					desc = "A nice and refrshing beverage while you are reading."
				if("cafe_latte")
					icon_state = "cafe_latte"
					name = "Cafe Latte"
					desc = "A nice, strong and refreshing beverage while you are reading."
				if("acidspit")
					icon_state = "acidspitglass"
					name = "Acid Spit"
					desc = "A drink from Nanotrasen. Made from live aliens."
				if("amasec")
					icon_state = "amasecglass"
					name = "Amasec"
					desc = "Always handy before COMBAT!!!"
				if("neurotoxin")
					icon_state = "neurotoxinglass"
					name = "Neurotoxin"
					desc = "A drink that is guaranteed to knock you silly."
				if("hippiesdelight")
					icon_state = "hippiesdelightglass"
					name = "Hippie's Delight"
					desc = "A drink enjoyed by people during the 1960's."
				if("bananahonk")
					icon_state = "bananahonkglass"
					name = "Banana Honk"
					desc = "A drink from Banana Heaven."
				if("silencer")
					icon_state = "silencerglass"
					name = "Silencer"
					desc = "A drink from mime Heaven."
				if("nothing")
					icon_state = "nothing"
					name = "Nothing"
					desc = "Absolutely nothing."
				if("devilskiss")
					icon_state = "devilskiss"
					name = "Devils Kiss"
					desc = "Creepy time!"
				if("changelingsting")
					icon_state = "changelingsting"
					name = "Changeling Sting"
					desc = "A stingy drink."
				if("irishcarbomb")
					icon_state = "irishcarbomb"
					name = "Irish Car Bomb"
					desc = "An irish car bomb."
				if("syndicatebomb")
					icon_state = "syndicatebomb"
					name = "Syndicate Bomb"
					desc = "A syndicate bomb."
				if("erikasurprise")
					icon_state = "erikasurprise"
					name = "Erika Surprise"
					desc = "The surprise is, it's green!"
				if("driestmartini")
					icon_state = "driestmartiniglass"
					name = "Driest Martini"
					desc = "Only for the experienced. You think you see sand floating in the glass."
				if("elpresidente")
					icon_state = "elpresidenteglass"
					name = "El Presidente"
					desc = "So, El Presidente walks into a bar..."
				if("ice")
					icon_state = "iceglass"
					name = "Glass of ice"
					desc = "Generally, you're supposed to put something else in there too..."
				if("icecoffee")
					icon_state = "icedcoffeeglass"
					name = "Iced Coffee"
					desc = "A drink to perk you up and refresh you!"
				if("coffee")
					icon_state = "glass_brown"
					name = "Glass of coffee"
					desc = "Don't drop it, or you'll send scalding liquid and glass shards everywhere."
				if("bilk")
					icon_state = "glass_brown"
					name = "Glass of bilk"
					desc = "A brew of milk and beer. For those alcoholics who fear osteoporosis."
				if("fuel")
					icon_state = "dr_gibb_glass"
					name = "Glass of welder fuel"
					desc = "Unless you are an industrial tool, this is probably not safe for consumption."
				if("brownstar")
					icon_state = "brownstar"
					name = "Brown Star"
					desc = "Its not what it sounds like..."
				if("grapejuice")
					icon_state = "grapejuice"
					name = "Glass of grape juice"
					desc = "It's grrrrrape!"
				if("grapesoda")
					icon_state = "grapesodaglass"
					name = "Grape Soda"
					desc = "It's grrrrrape and fizzy!"
				if("icetea")
					icon_state = "icetea"
					name = "Iced Tea"
					desc = "No relation to a certain rap artist/ actor."
				if("grenadine")
					icon_state = "grenadineglass"
					name = "Glass of grenadine syrup"
					desc = "Sweet and tangy, a bar syrup used to add color or flavor to drinks."
				if("milkshake")
					icon_state = "milkshake"
					name = "Milkshake"
					desc = "Glorious brainfreezing mixture."
				if("milkshake_banana")
					icon_state = "milkshakebananaglass"
					name = "Banana Milkshake"
					desc = "Clowns and kids all-time favorite."
				if("milkshake_coffee")
					icon_state = "milkshakecoffeeglass"
					name = "Coffee Milkshake"
					desc = "Better than coffee and cream anyway"
				if("milkshake_tomato")
					icon_state = "milkshaketomatoglass"
					name = "Bloody Mary Jr."
					desc = "Just like father drinks, almost real Bloody Mary! For children who like to develop alcoholism before they are middle-aged."
				if("lemonade")
					icon_state = "lemonade"
					name = "Lemonade"
					desc = "Oh the nostalgia..."
				if("lynchburg")
					icon_state = "lynchburg"
					name = "Lynchburg Lemonade"
					desc = "Nobody knows what Lynchburg is anymore, but the recipe is well-known around this sector."
				if("kiraspecial")
					icon_state = "kiraspecial"
					name = "Kira Special"
					desc = "Long live the guy who everyone had mistaken for a girl. Baka!"
				if("rewriter")
					icon_state = "rewriter"
					name = "Rewriter"
					desc = "The secert of the sanctuary of the Libarian..."
				if("suidream")
					icon_state = "sdreamglass"
					name = "Sui Dream"
					desc = "A froofy, fruity, and sweet mixed drink. Understanding the name only brings shame."
				if("melonliquor")
					icon_state = "emeraldglass"
					name = "Glass of Melon Liquor"
					desc = "A relatively sweet and fruity 46 proof liquor."
				if("limoncello")
					icon_state = "limoncelloglass"
					name = "Glass of Limoncello"
					desc = "Natural lemons used, no artificial colors added."
				if("panache")
					icon_state = "panacheglass"
					name = "Italianissmo Limoncello Panache"
					desc = "Capitano e` un bel ragazzo, amico. Mamma mia!"
				if("bluecuracao")
					icon_state = "curacaoglass"
					name = "Glass of Blue Curacao"
					desc = "Exotically blue, fruity drink, distilled from oranges."
				if("absinthe")
					icon_state = "absintheglass"
					name = "Glass of Absinthe"
					desc = "Wormwood, anise, oh my."
				if("pwine")
					icon_state = "pwineglass"
					name = "Glass of ???"
					desc = "A black ichor with an oily purple sheer on top. Are you sure you should drink this?"
				else
					icon_state ="glass_brown"
					name = "Glass of ..what?"
					desc = "You can't really tell what this is."
		else
			icon_state = "glass_empty"
			name = "Drinking glass"
			desc = "Your standard drinking glass"
			return

// for /obj/machinery/vending/sovietsoda
/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/soda
	New()
		..()
		reagents.add_reagent("sodawater", 50)
		on_reagent_change()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/cola
	New()
		..()
		reagents.add_reagent("cola", 50)
		on_reagent_change()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/throw_impact(atom/hit_atom)
	if (health > 0)
		health = max(0,health - 3)
		if (health < 1)
			die()
			return
		if (reagents.reagent_list.len > 0)
			src.visible_message("\red [src] slams into [hit_atom] spilling its contents!")
			new/obj/effect/effect/water(src.loc)
			reagents.reagent_list.len = 0
			on_reagent_change()
	return ..()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/proc/die()
	src.visible_message("\red [src] shatters spilling its contents!")
	playsound(src, "shatter", 40, 1)
	new/obj/item/weapon/shard(src.loc)
	if (reagents.reagent_list.len > 0)
		new/obj/effect/effect/water(src.loc)
	del(src)

