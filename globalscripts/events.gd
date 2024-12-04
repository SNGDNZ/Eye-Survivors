extends Node

@onready var player = get_tree().get_first_node_in_group("player")

#ENEMY
signal enemy_death()
signal hurt(damage, angle, knockback_amount)
signal xp_spawn()

#PLAYER
signal player_death()
signal player_hurt(damage)
signal update_playerstats()

#XP HANDLER
signal level_up()
signal calculate_xp(gem_xp)

#UPGRADES
signal selected_upgrade()
signal calculate_upgrade(upgrade)

#DEBUG
func _input(event):
	if event.is_action_pressed("t"):
		Events.player_death.emit()
	if event.is_action_pressed("r"):
		return
