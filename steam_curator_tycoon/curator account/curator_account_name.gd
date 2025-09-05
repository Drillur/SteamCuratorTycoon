class_name _CuratorAccountName
extends Object


const GAMING_WORDS: Array[String] = [
	"Game", "Gaming", "Gamer", "Games", "Play", "Player", "Console", "PC", "Steam",
	"Arcade", "Pixel", "Digital", "Virtual", "Interactive", "Electronic", "Video"
]
const REVIEW_WORDS: Array[String] = [
	"Review", "Reviews", "Critic", "Critics", "Analysis", "Verdict", "Opinion",
	"Thoughts", "Take", "Perspective", "Insight", "Coverage", "Report", "Guide"
]
const DESCRIPTORS: Array[String] = [
	"Pro", "Elite", "Ultimate", "Prime", "Supreme", "Master", "Expert", "Top",
	"Best", "Premium", "Quality", "Pure", "True", "Real", "Genuine", "Honest",
	"Independent", "Indie", "Underground", "Core", "Hardcore", "Casual", "Modern",
	"Classic", "Retro", "Next", "Future", "Digital", "Online", "Official"
]
const PERSONAS: Array[String] = [
	"Guru", "Wizard", "Ninja", "Legend", "Hero", "Champion", "King", "Queen",
	"Lord", "Master", "Captain", "Chief", "Boss", "Leader", "Authority", "Expert",
	"Specialist", "Enthusiast", "Fanatic", "Addict", "Junkie", "Geek", "Nerd"
]
const PLACES: Array[String] = [
	"Hub", "Central", "Station", "Zone", "Corner", "Spot", "Place", "World",
	"Universe", "Realm", "Kingdom", "Empire", "Domain", "Territory", "Base",
	"Headquarters", "HQ", "Lab", "Studio", "Workshop", "Garage", "Cave", "Den"
]
const ADJECTIVES: Array[String] = [
	"Epic", "Awesome", "Amazing", "Incredible", "Fantastic", "Outstanding", "Stellar",
	"Legendary", "Mythical", "Ultimate", "Supreme", "Premium", "Elite", "Pro",
	"Advanced", "Superior", "Excellent", "Perfect", "Flawless", "Solid", "Reliable",
	"Trusted", "Verified", "Certified", "Official", "Authentic", "Original"
]
const NUMBERS: Array[String] = [
	"1", "2", "3", "007", "101", "360", "64", "99", "2000", "2024", "X", "XX", "XXX"
]
const CURATOR_PATTERNS: Array[Array] = [
	[DESCRIPTORS, GAMING_WORDS],
	[GAMING_WORDS, REVIEW_WORDS],
	[ADJECTIVES, GAMING_WORDS],
	[GAMING_WORDS, PERSONAS],
	["The", GAMING_WORDS, PERSONAS],
	["The", ADJECTIVES, REVIEW_WORDS],
	["The", DESCRIPTORS, GAMING_WORDS, PLACES],
	[ADJECTIVES, GAMING_WORDS, REVIEW_WORDS],
	[DESCRIPTORS, GAMING_WORDS, PLACES],
	[GAMING_WORDS, REVIEW_WORDS, PLACES],
	[GAMING_WORDS, NUMBERS],
	[DESCRIPTORS, GAMING_WORDS, NUMBERS],
	[ADJECTIVES, REVIEW_WORDS, NUMBERS],
	[PERSONAS, "'s", GAMING_WORDS, REVIEW_WORDS],
	[PERSONAS, "'s", GAMING_WORDS, PLACES],
	[GAMING_WORDS, "&", REVIEW_WORDS],
	[REVIEW_WORDS, "and", GAMING_WORDS],
	["All", "About", GAMING_WORDS],
	[GAMING_WORDS, "First"],
	["Just", GAMING_WORDS],
]


static func get_random_name() -> String:
	var pattern: Array = CURATOR_PATTERNS.pick_random()
	var name_parts: Array[String] = []
	
	for part in pattern:
		if part is Array:
			var word: String = part.pick_random()
			name_parts.append(word)
		else:
			name_parts.append(part)
	
	var name: String = " ".join(name_parts)
	while name.contains(" 's "):
		name = name.replace(" 's ", "'s ")
	
	return name
