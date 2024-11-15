extends Control

@onready var player = get_tree().get_first_node_in_group("player")

@onready var label_death_text = $LabelYouDied
@onready var death_text_timer = get_node("LabelYouDied/%DeathTextTimer")

@onready var level_display = get_node("XpBar/%LevelDisplay")
@onready var xp_bar = get_node("XpBar/%LevelDisplay")

@onready var upgrade_options = get_node("LevelUp/%UpgradeOptions")
@onready var level_up_sound = get_node("LevelUp/%LevelUpSound")

func _ready():
	Events.level_up.connect(_on_player_level_up)

func _on_death_text_timer_timeout() -> void:
	label_death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03

func _on_player_level_up():
	level_up_sound.play()
	upgrade_options.visible
