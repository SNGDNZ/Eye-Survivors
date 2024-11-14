extends Node2D

@onready var enemy = get_tree().get_first_node_in_group("enemy")
@export var spawns:Resource = XpInfo

signal xp_spawn()

func _on_xp_spawn():
		var xp_spawn = xp_crystal.instantiate()
		xp_spawn.position = self.position
		add_child(xp_spawn)
