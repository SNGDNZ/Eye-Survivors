extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")

var orb = preload("res://Resources/orb.tscn")

func _process(delta):
	if Input.is_action_just_pressed("click"):
		print ("click")
		orb_attack()

func orb_attack():
	print ("orb_attack")
	if player.isdead:
		return
	#if orb_attack_timer.is_stopped = false:
		#return
	var orb_attack = orb.instantiate()
	orb_attack.target = get_global_mouse_position()
	add_child(orb_attack)
	print (orb_attack.target)
	if orb_attack.position.distance_to(orb_attack.target) <10:
		print("orb target reached")
