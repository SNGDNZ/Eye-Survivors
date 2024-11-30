extends Control

@onready var player = get_tree().get_first_node_in_group("player")

@onready var health_bar = $PlayerHealthBar
@onready var health_bar_number = $PlayerHealthBar/PlayerHealthBarNumber
@onready var stamina_bar = $PlayerStaminaBar

@onready var label_death_text = $LabelYouDied
@onready var death_text_timer = get_node("%DeathTextTimer")

@onready var level_display = get_tree().get_first_node_in_group("level_display")
@onready var xp_bar = get_tree().get_first_node_in_group("xp_bar")
@onready var level_delay_timer = $LevelUpDelayTimer
@onready var upgrade_options_panel = $LevelUp/UpgradeOptions
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

func _process(_float) -> void:
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
	level_delay_timer.start()
	print("levelup")
	level_up_sound.play()
	get_tree().paused = true

func _on_level_up_delay_timer_timeout() -> void:
	level_up_panel.visible = true
	var options = 0
	var options_max = 4
	while options < options_max:
		var option_choice = upgrade_select.instantiate()
		option_choice.upgrade = get_random_upgrade()
		upgrade_options_panel.add_child(option_choice)
		options += 1

func upgrade_character(upgrade):
	var option_children = upgrade_options_panel.get_children()
	for i in option_children:
		i.queue_free()
	Stats.upgrade_options.clear()
	Stats.collected_upgrades.append(upgrade)
	level_up_panel.visible = false
	get_tree().paused = false
	Events.calculate_xp.emit(0)
	print(Stats.collected_upgrades)

func get_random_upgrade():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in Stats.collected_upgrades: #find already collected upgrades
			pass
		elif i in Stats.upgrade_options: #if upgrade is already an option
			pass
		#elif UpgradeDb.UPGRADES[i]["type"] == ["item"]: #dont pick placeholder upgrade
			#pass
		elif UpgradeDb.UPGRADES[i]["prerequisites"].size() > 0: #check for prerequisites
			for n in UpgradeDb.UPGRADES[i]["prerequisites"]:
				if not n in Stats.collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var random_upgrade = dblist.pick_random()
		Stats.upgrade_options.append(random_upgrade)
		return random_upgrade
	else:
		return null
