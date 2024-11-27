extends Control

@onready var player = get_tree().get_first_node_in_group("player")

@onready var health_bar = $PlayerHealthBar
@onready var health_bar_number = $PlayerHealthBar/PlayerHealthBarNumber
@onready var stamina_bar = $PlayerStaminaBar

@onready var label_death_text = $LabelYouDied
@onready var death_text_timer = get_node("%DeathTextTimer")

@onready var level_display = get_tree().get_first_node_in_group("level_display")
@onready var xp_bar = get_tree().get_first_node_in_group("xp_bar")

@onready var upgrade_options_panel = get_node("%UpgradeOptions")
@onready var level_up_panel = get_node("%LevelUp")
@onready var level_up_sound = get_node("LevelUp/%LevelUpSound")
@onready var upgrade_select = preload("res://scenes/upgrade_option.tscn")

func _ready():
	health_bar.value = player.hp
	health_bar.max_value = player.hp_max
	health_bar_number.text = str(health_bar.value / health_bar.max_value*player.hp)
	stamina_bar.value = player.stamina
	stamina_bar.max_value = player.stamina_max
	Events.level_up.connect(_on_player_level_up)
	Events.selected_upgrade.connect(upgrade_character)
	Events.player_hurt.connect(_on_player_hurt)
	Events.player_death.connect(_on_player_death)

func _process(float) -> void:
	#if player.sprinting
	health_bar.value = player.hp
	health_bar.max_value = player.hp_max
	health_bar_number.text = str(health_bar.value / health_bar.max_value*player.hp)
	stamina_bar.value = player.stamina
	stamina_bar.max_value = player.stamina_max

func _on_player_hurt(_damage):
	print("player hurt")
	

func _on_player_death():
	label_death_text.visible = true
	health_bar.value = 0
	if label_death_text.visible_characters < 12:
		death_text_timer.start()

func _on_death_text_timer_timeout() -> void:
	label_death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03
	#var death_text_tween = label_death_text.create_tween()
	#death_text_tween.tween_property(label_death_text, "position", Vector2.from_angle(randf_range(0,2*PI))*5,0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
	#death_text_tween.play()

func _on_player_level_up():
	print("levelup")
	level_up_sound.play()
	var tween = level_up_panel.create_tween()
	level_up_panel.visible = true
	var options = 0
	var options_max = 4
	while options < options_max:
		var option_choice = upgrade_select.instantiate()
		upgrade_options_panel.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	var option_children = upgrade_options_panel.get_children()
	for i in option_children:
		i.queue_free()
	level_up_panel.visible = false
	get_tree().paused = false
	Events.calculate_xp.emit(0)
