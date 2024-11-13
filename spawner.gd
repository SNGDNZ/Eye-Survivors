extends Node2D

@export var spawns: Array[SpawnInfo] = []
@onready var player = get_tree().get_first_node_in_group("player")
@export var enemy_max:int

var time = 0

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while counter < i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1

func get_random_position() -> Vector2:
	return player.global_position+Vector2.from_angle(randf_range(0, 2*PI))*(get_viewport_rect().size.length()*randf_range(1,1.4))
