extends Control

@onready var player = get_tree().get_first_node_in_group("player")

@onready var label_death_text = $LabelYouDied
@onready var death_text_timer = get_node("LabelYouDied/%DeathTextTimer")

@onready var level_display = get_node("XpBar/%LevelDisplay")
@onready var xp_bar = get_node("XpBar/%LevelDisplay")

@onready var upgrade_options_panel = get_node("LevelUp/%UpgradeOptions")
@onready var level_up_sound = get_node("LevelUp/%LevelUpSound")
@onready var upgrade_options = preload("res://Resources/upgrade_option.tscn")
@onready var level_up_panel = $LevelUp

func _ready():
	Events.level_up.connect(_on_player_level_up)
	Events.selected_upgrade.connect(upgrade_character)

func _on_death_text_timer_timeout() -> void:
	label_death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03

func _on_player_level_up():
	print("levelup")
	level_up_sound.play()
	var tween = level_up_panel.create_tween()
	tween.tween_property(level_up_panel, "position", Vector2(760,240),0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tween.play
	upgrade_options_panel.visible
	level_up_panel.visible
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = upgrade_options.instantiate()
		upgrade_options_panel.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	var option_children = upgrade_options_panel.get_children()
	for i in option_children:
		i.queue_free()
	level_up_panel.visible = false
	level_up_panel.position = Vector2(376,1000)
	get_tree().paused = false
	#Events.calculate_xp.emit(0)
