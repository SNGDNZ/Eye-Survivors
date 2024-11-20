extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")

#ORB
@onready var orb_float_timer = $OrbFloatTimer
@onready var orb_impact_timer = $OrbImpactTimer
var orb = preload("res://Resources/orb.tscn")

func _process(delta):
	if Input.is_action_just_pressed("click"):
		print("clickpos",get_global_mouse_position())
		orb_attack()

func orb_attack():
	if player.isdead:
		return
	#if orb_attack_timer.is_stopped = false:
		#return
	var orb_attack = orb.instantiate()
	#orb_attack.position = player.position
	orb_attack.global_position.x = player.position.x - 576
	orb_attack.global_position.y = player.position.y - 324
	orb_attack.mousetarget = get_global_mouse_position() #VECTOR
	orb_attack.direction = player.global_position.angle_to(orb_attack.mousetarget)
	orb_attack.angle = player.global_position.direction_to(orb_attack.mousetarget*2*PI)
	orb_attack.pos1 = orb_attack.global_position + Vector2.from_angle(orb_attack.direction)*200
	orb_attack.pos2 = player.global_position + Vector2.from_angle(randf_range(0, 2*PI))*100
	#orb_attack.pos2 = player.global_position + Vector2.from_angle(orb_attack.direction)*300
	add_child(orb_attack)
	#TWEEN
	var tween_pos2 = orb_attack.create_tween()
	tween_pos2.tween_property(orb_attack, "global_position", orb_attack.pos2,0.4).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween_pos2.tween_property(orb_attack, "scale", orb_attack.scale,0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween_pos2.play
	orb_float_timer.start()
	#DEBUG
	print("mousetarget",orb_attack.mousetarget)
	print("playerglobalpos",player.global_position)
	print("playerpos",player.position)
	print("pos2",orb_attack.pos2)
