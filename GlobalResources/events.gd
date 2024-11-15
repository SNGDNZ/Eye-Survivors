extends Node

@onready var player = get_tree().get_first_node_in_group("player")

#ENEMY
signal enemy_death()
signal hurt(damage, angle, knockback)

#PLAYER
signal player_death()
signal level_up()

func _input(event):
	if event.is_action_pressed("t"):
		emit_signal("player_death")
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
