extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")

var orb = preload("res://Resources/orb.tscn")

func _process(delta):
	if Input.is_action_just_pressed("click"):
		print(get_global_mouse_position())
		orb_attack()

func orb_attack():
	if player.isdead:
		return
	#if orb_attack_timer.is_stopped = false:
		#return
	var orb_attack = orb.instantiate()
	orb_attack.position = player.global_position
	orb_attack.mousetarget = get_global_mouse_position() #VECTOR
	orb_attack.pos1 = orb_attack.global_position + Vector2.from_angle(orb_attack.angle)*400
	orb_attack.pos2 = orb_attack.global_position + Vector2.from_angle(orb_attack.angle)*300
	add_child(orb_attack)
	
