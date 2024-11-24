extends Control

@onready var player = get_tree().get_first_node_in_group("player")

@onready var health_bar = get_tree().get_first_node_in_group("player_health_bar")
@onready var health_bar_number = get_tree().get_first_node_in_group("player_health_bar_number")

@onready var label_death_text = $LabelYouDied
@onready var death_text_timer = get_node("LabelYouDied/%DeathTextTimer")

@onready var level_display = get_node("XpBar/%LevelDisplay")
@onready var xp_bar = get_node("XpBar/%LevelDisplay")

@onready var upgrade_options_panel = get_node("LevelUp/%UpgradeOptions")
@onready var level_up_sound = get_node("LevelUp/%LevelUpSound")
@onready var upgrade_options = preload("res://scenes/upgrade_option.tscn")
@onready var level_up_panel = $LevelUp

func _ready():
	health_bar.value = player.hp
	health_bar_number.text = str(health_bar.value / health_bar.max_value*player.hp)
	Events.level_up.connect(_on_player_level_up)
	Events.selected_upgrade.connect(upgrade_character)
	Events.player_hurt.connect(_on_player_hurt)
	Events.player_death.connect(_on_player_death)

func _on_player_hurt(_damage):
	print("player hurt")
	health_bar.value = player.hp
	health_bar_number.text = str(health_bar.value / health_bar.max_value*player.hp)

func _on_player_death():
	health_bar.value = player.hp
	health_bar_number.text = str(abs(health_bar.value) / abs(health_bar.max_value*player.hp) )
	label_death_text.visible = true
	health_bar.value = 0
	if label_death_text.visible_characters < 12:
		death_text_timer.start()

func _on_death_text_timer_timeout() -> void:
	label_death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03
	var death_text_tween = label_death_text.create_tween()
	death_text_tween.tween_property(label_death_text, "position", Vector2.from_angle(randf_range(0,2*PI))*5,0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
	death_text_tween.play()

func _on_player_level_up():
	print("levelup")
	level_up_sound.play()
	var tween = level_up_panel.create_tween()
	tween.tween_property(level_up_panel, "position", Vector2(760,240),0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tween.play()
	upgrade_options_panel.visible = true
	level_up_panel.visible = true
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = upgrade_options.instantiate()
		upgrade_options_panel.add_child(option_choice)
		options += 1
	#get_tree().paused = true

func upgrade_character(upgrade):
	var option_children = upgrade_options_panel.get_children()
	for i in option_children:
		i.queue_free()
	level_up_panel.visible = false
	level_up_panel.position = Vector2(376,1000)
	#get_tree().paused = false
	#Events.calculate_xp.emit(0)
