extends Node

@onready var level_display = get_tree().get_first_node_in_group("level_display")
@onready var xp_bar = get_tree().get_first_node_in_group("xp_bar")

var xp_amt = 0
var xp_level = 1
var xp_collected = 0

func _ready():
	set_xpbar(xp_amt, calculate_xp_cap())
	Events.calculate_xp.connect(_on_calculate_xp)

func _on_calculate_xp(gem_xp):
	xp_collected += gem_xp
	print ("player_xp_recieve")
	var xp_required = calculate_xp_cap()
	if xp_amt + xp_collected >= xp_required: #Level up
		xp_collected -= xp_required-xp_amt
		xp_level += 1
		level_display.text = str("Level ",xp_level)
		xp_amt = 0
		xp_required = calculate_xp_cap()
		Events.level_up.emit()
	else:
		xp_amt += xp_collected
		xp_collected = 0
	set_xpbar(xp_amt, xp_required)

func calculate_xp_cap():
	var xp_cap = xp_level
	if xp_level < 20:
		xp_cap = xp_level*7 + 4
	elif xp_level < 40:
		xp_cap + 95 * (xp_level-19)*11 + 8
	else:
		xp_cap = 255 + (xp_level-39)*13 + 16
	return xp_cap

func set_xpbar(set_value = 1, set_max_value = 100):
	xp_bar.value = set_value
	xp_bar.max_value = set_max_value
