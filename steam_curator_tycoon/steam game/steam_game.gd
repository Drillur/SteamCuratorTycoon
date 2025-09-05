class_name SteamGame
extends RefCounted


signal keys_changed
signal review_written_changed
signal state_changed

enum State {
	NEW_GAME,
	EMAIL_PENDING, ## A bot began writing an email to the dev
	DECLINED, ## End of the story
	AWAITING_REVIEW, ## Needs a bot to write a review
	REVIEW_BEING_WRITTEN,
	EXHAUSTED,
}

static var list: Array[SteamGame]
static var count_total: int = 10
static var refresh_rate_stage: int = 0

var name: String
var state: State = State.NEW_GAME:
	set = set_state

var price: float
var followers: int
var days_until_release: int = randi_range(7, 14)
var keys: int = 0:
	set = set_keys
var keys_in_use: int = 0 ## If > 0, don't set to exhausted

var review_written: bool = false:
	set = set_review_written

var node: SteamGameNode
var color: Color = SteamCuratorsMod.get_random_color()


#region Static


static func setup() -> void:
	Clock.instance.hour_passed.connect(fill_list)
	fill_list(true)
	update_refresh_rate_stage()
	SteamCuratorsMod.get_prestiged_signal().connect(prestige)


static func add_total_count(amount: int) -> void:
	count_total += amount
	fill_list(true)


static func prestige() -> void:
	clear()
	fill_list(true)


static func fill_list(ignore_time: bool = false) -> void:
	if not ignore_time:
		if refresh_rate_stage == 4:
			pass
		elif refresh_rate_stage == 3 and Clock.instance.hour % 3 != 0:
			return
		elif refresh_rate_stage == 2 and Clock.instance.hour % 6 != 0:
			return
		elif refresh_rate_stage == 1 and Clock.instance.hour % 12 != 0:
			return
		elif refresh_rate_stage == 0 and Clock.instance.hour != 0:
			return
	
	for game: SteamGame in list.duplicate():
		if game.used_up():
			game.kill()
	while list.size() < count_total:
		SteamGame.new()
	
	list.sort_custom(sort_by_followers)
	
	Curator1.instance.update_steam_games()


static func sort_by_followers(a: SteamGame, b: SteamGame) -> bool:
	if a.followers == b.followers:
		return a.price >= b.price
	return a.followers >= b.followers


#static func sort_by_price(a: SteamGame, b: SteamGame) -> bool:
	#if a.price == b.price:
		#return a.followers >= b.followers
	#return a.price >= b.price


static func update_refresh_rate_stage() -> void:
	Curator1.instance.refresh_label.text = (
		"Games refresh hourly" if refresh_rate_stage == 4 # 1 hr
		else "Games refresh every 3 hours" if refresh_rate_stage == 3 # 3 hr
		else "Games refresh every 6 hours" if refresh_rate_stage == 2 # 6 hr
		else "Games refresh twice daily" if refresh_rate_stage == 1 # 12 hr
		else "Games refresh daily" # 24 hr
	)


static func clear() -> void:
	for game: SteamGame in list.duplicate():
		game.kill()


#endregion


#region Init


func _init() -> void:
	name = GameName.generate_random_title()
	followers = _get_follower_count()
	price = _get_price()
	
	list.append(self)
	Clock.instance.day_passed.connect(subtract_days_until_release)


func _get_follower_count() -> int:
	var rand_val: float = randf()
	
	if rand_val < 0.70:
		return randi_range(50, 5000)
	
	elif rand_val < 0.85:
		return randi_range(5000, 25_000)
	
	elif rand_val < 0.95:
		return randi_range(25_000, 100_000)
	
	elif rand_val < 0.99:
		return randi_range(100_000, 500_000)
	
	return randi_range(500_000, 2_500_000)


func _get_price() -> float:
	var result: float
	
	if followers < 1_000:
		result = randf_range(0.99, 7.99)
	elif followers < 5_000:
		result = randf_range(4.99, 14.99)
	elif followers < 25_000:
		result = randf_range(9.99, 24.99)
	elif followers < 100_000:
		result = randf_range(14.99, 34.99)
	elif followers < 500_000:
		result = randf_range(24.99, 49.99)
	else:
		result = randf_range(39.99, 69.99)
	
	var rounded: float = roundf(result)
	
	if result < 10.0:
		if rounded <= 1.0:
			return 1.0
		return rounded - 0.01
	
	elif result < 30.0:
		match randi() % 3:
			0: return rounded - 0.01
			1: return rounded - 0.51
			2: return float(rounded)
	
	match randi() % 2:
		0: return rounded - 0.01
		_: return float(rounded)


#endregion


#region Setters


func set_state(new_state: State) -> void:
	if state == new_state:
		return
	
	state = new_state
	state_changed.emit()


func set_keys(new_keys: int) -> void:
	if keys == new_keys:
		return
	keys = new_keys
	keys_changed.emit()


func set_review_written(new_val: bool) -> void:
	if review_written == new_val:
		return
	review_written = new_val
	review_written_changed.emit()


#endregion


#region Control


func subtract_days_until_release() -> void:
	days_until_release -= 1
	if days_until_release <= 0:
		kill()


func kill() -> void:
	list.erase(self)


#endregion


#region Get Values


## No keys left, or declined to give keys
func used_up() -> bool:
	return state == State.DECLINED or state == State.EXHAUSTED


#endregion
