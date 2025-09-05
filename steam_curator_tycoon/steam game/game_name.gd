class_name GameName


const FULL_TITLES: PackedStringArray = [
	"Shattered Realms",
	"The Crimson Blade",
	"Echoes of Eternity",
	"Shadowmere Chronicles",
	"Dragon's Crown Legacy",
	"The Last Archmage",
	"Ruins of the Ancient Kings",
	"Moonlight Covenant",
	"The Witching Hour",
	"Blade of the Fallen",
	"Neon Horizon",
	"Stellar Outcasts",
	"The Void Runners",
	"Cybernetic Dreams",
	"Quantum Shadows",
	"Mars Protocol",
	"The Digital Frontier",
	"Starfall Rebellion",
	"Neural Network",
	"Galaxy's End",
	"Iron Fist Tournament",
	"Bloodstone Arena",
	"The Fighting Spirit",
	"Warrior's Pride",
	"Clash of Titans",
	"Street Legends",
	"The Final Round",
	"Combat Elite",
	"Victory Road",
	"Battle Royale Supreme",
	"Midnight Terror",
	"The Haunted Manor",
	"Whispers in the Dark",
	"Silent Screams",
	"The Dead Zone",
	"Phantom's Curse",
	"Nightmare Asylum",
	"Blood Moon Rising",
	"The Forgotten Crypt",
	"Shadows of Fear",
	"Velocity Rush",
	"Neon Streets",
	"Turbo Legends",
	"The Speed Demon",
	"Midnight Racers",
	"Chrome Wheels",
	"Highway Heroes",
	"Burnout City",
	"Racing Thunder",
	"The Fast Lane",
	"Empire's Fall",
	"The Art of War",
	"Tactical Supremacy",
	"Kingdom Under Siege",
	"Battle Commander",
	"The Great Campaign",
	"War Machine",
	"Strategic Conquest",
	"The Final Gambit",
	"Victory at All Costs",
	"Lost Expedition",
	"The Hidden Valley",
	"Treasure Seekers",
	"Journey to the Unknown",
	"The Explorer's Guild",
	"Forgotten Lands",
	"Quest for the Golden Idol",
	"The Adventure Begins",
	"Uncharted Waters",
	"The Great Discovery",
	"The Cipher Code",
	"Mind Games",
	"The Puzzle Master",
	"Mystery Manor",
	"Brain Teasers Unlimited",
	"The Logic Trap",
	"Riddle Me This",
	"The Enigma Files",
	"Puzzle Quest",
	"The Thinking Man's Game",
	"Championship Glory",
	"The Ultimate League",
	"Sports Legends",
	"Victory Stadium",
	"The Grand Tournament",
	"Athletic Dreams",
	"Champions United",
	"The Playoff Push",
	"Stadium Heroes",
	"The Winning Formula",
	"The Time Weaver",
	"Pixel Perfect",
	"The Memory Thief",
	"Gravity's Edge",
	"The Color Wars",
	"Sound and Fury",
	"The Dream Walker",
	"Reality Check",
	"The Impossible Game",
	"Beyond Tomorrow",
]
const ADJECTIVES: Array[String] = [
	"Ancient", "Dark", "Lost", "Forgotten", "Sacred", "Mystic", "Epic", "Legendary",
	"Shadow", "Golden", "Crystal", "Frozen", "Burning", "Hidden", "Secret", "Divine",
	"Cursed", "Eternal", "Infinite", "Ultimate", "Final", "Last", "Royal",
	"Imperial", "Arcane", "Crimson", "Steel", "Iron", "Blood", "Storm", "Thunder",
	"Fire", "Ice", "Stone", "Diamond", "Obsidian", "Solar", "Lunar", "Stellar"
]
const PRIMARY_NOUNS: Array[String] = [
	"Kingdom", "Empire", "Realm", "World", "Chronicles", "Saga", "Legacy",
	"Quest", "Adventure", "Journey", "Odyssey", "War", "Battle", "Arena",
	"Tournament", "Order", "Guild", "Brotherhood", "Alliance", "Prophecy",
	"Destiny", "Dawn", "Dusk", "Eclipse", "Awakening", "Ascension", "Return",
	"Revenge", "Redemption", "Revolution", "Genesis", "Origins"
]
const CREATURES: Array[String] = [
	"Dragons", "Warriors", "Knights", "Wizards", "Mages", "Assassins",
	"Rangers", "Guardians", "Champions", "Heroes", "Legends", "Titans",
	"Demons", "Angels", "Spirits", "Shadows", "Phoenixes", "Wolves",
	"Lions", "Eagles", "Panthers", "Ninjas", "Samurai", "Gladiators",
	"Vikings", "Pirates", "Rogues", "Mercenaries", "Soldiers"
]
const COOL_ACTIONS: Array[String] = [
	"Rising", "Fallen", "Reborn", "Unleashed", "Awakened", "Ascended",
	"Siege", "Conquest", "Invasion", "Liberation", "Rebellion", "Uprising",
	"Vengeance", "Wrath", "Glory", "Victory", "Betrayal", "Revolution"
]
const PLACES: Array[String] = [
	"Atlantis", "Avalon", "Valhalla", "Olympus", "Asgard", "Camelot",
	"the Abyss", "the Void", "the North", "the East", "the West", "the South",
	"the Underworld", "the Heavens", "the Wasteland", "the Depths",
	"the Mountains", "the Seas", "the Skies", "Eternity", "Infinity"
]
const TITLE_PATTERNS: Array[Array] = [
	# Simple but effective patterns
	[ADJECTIVES, PRIMARY_NOUNS],                    # "Dark Chronicles"
	[ADJECTIVES, CREATURES],                        # "Shadow Warriors"  
	[CREATURES, "of", PLACES],                      # "Knights of Avalon"
	["The", ADJECTIVES, PRIMARY_NOUNS],             # "The Lost Kingdom"
	["The", CREATURES, "of", PLACES],               # "The Warriors of Valhalla"
	
	# Action-based titles
	[PRIMARY_NOUNS, COOL_ACTIONS],                  # "Kingdom Rising"
	[CREATURES, COOL_ACTIONS],                      # "Dragons Unleashed"
	[ADJECTIVES, COOL_ACTIONS],                     # "Ancient Awakening"
	
	# "Of the" patterns (more natural)
	[ADJECTIVES, CREATURES, "of", PLACES],          # "Dark Knights of Avalon"
	[CREATURES, "of", "the", ADJECTIVES, PRIMARY_NOUNS], # "Warriors of the Lost Kingdom"
	
	# Colon patterns (no space before colon)
	["PRIMARY_NOUNS:", ADJECTIVES, COOL_ACTIONS], # "Chronicles: Shadow Rising"
	[ADJECTIVES, "PRIMARY_NOUNS:", COOL_ACTIONS], # "Dark Empire: Reborn"
	
	# Powerful single-word combinations
	[ADJECTIVES, ADJECTIVES, PRIMARY_NOUNS],        # "Dark Ancient Chronicles"
	[ADJECTIVES, ADJECTIVES, CREATURES],            # "Epic Legendary Warriors"
	
	# "Rise/Fall of" patterns
	["Rise of the", ADJECTIVES, CREATURES],         # "Rise of the Dark Knights"
	["Fall of the", ADJECTIVES, PRIMARY_NOUNS],     # "Fall of the Ancient Empire"
	
	# Simple but cool
	[CREATURES, PRIMARY_NOUNS],                     # "Dragon Quest"
	[ADJECTIVES, "of", PLACES],                     # "Shadows of Atlantis"
]


static func generate_random_title() -> String:
	const FULL_TITLE_CHANCE: float = 1.0 / 100_000
	
	# 100 game titles in this PackedStringArray
	if randf() < FULL_TITLE_CHANCE:
		return FULL_TITLES[randi() % FULL_TITLES.size()]
	
	# ~200,000 possible game titles below
	var pattern: Array = TITLE_PATTERNS.pick_random()
	var title_parts: Array[String] = []
	
	for part in pattern:
		if part is Array:
			title_parts.append(part.pick_random())
		elif part.ends_with(":"):
			# Handle colon case - no space before colon
			var word_array = part.trim_suffix(":")
			var arrays_map = {
				"PRIMARY_NOUNS": PRIMARY_NOUNS,
				"ADJECTIVES": ADJECTIVES
			}
			if arrays_map.has(word_array):
				var word = arrays_map[word_array].pick_random()
				title_parts.append(word + ":")
			else:
				title_parts.append(part)
		else:
			# Use the string as-is (like "of", "the", etc.)
			title_parts.append(part)
	
	return " ".join(title_parts)
