extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")

#ORB

@onready var orb_attack_timer = $OrbAttackTimer

var orb = preload("res://scenes/orb.tscn")
var orb_pos2_reached = false

func _process(delta):
	if Input.is_action_pressed("click"):
			print("clickpos",get_global_mouse_position())
			orb_attack_func()

func orb_attack_func():
	if player.isdead:
		return
	if orb_attack_timer.is_stopped():
		var orb_attack = orb.instantiate()
		orb_attack.global_position = player.global_position
		
		orb_attack.mousetarget = get_global_mouse_position() #VECTOR
		orb_attack.direction = orb_attack.global_position.angle_to(orb_attack.mousetarget)
		orb_attack.angle = enemy.global_position.direction_to(orb_attack.mousetarget)
		
		var orb_attack_cone = Vector2.from_angle(randf_range(-0.25*PI+ orb_attack.direction, 0.25*PI+ orb_attack.direction))*100
		orb_attack.targetpos1 = player.global_position + orb_attack_cone
		orb_attack.targetpos2 = orb_attack.mousetarget
		add_child(orb_attack)
		#TWEEN
		var orb_tween = orb_attack.create_tween().set_parallel(true)
		orb_tween.tween_property(orb_attack.sprite, "scale", Vector2(0.5,0.5),0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
		orb_tween.tween_property(orb_attack, "global_position", orb_attack.targetpos1,0.4).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
		#orb_tween.chain().tween_property(orb_attack.sprite, "scale", Vector2(1,1),0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
		orb_tween.chain().tween_property(orb_attack, "global_position", orb_attack.mousetarget,0.3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
		orb_tween.play
		
		#orb_attack_timer.wait_time = orb_attack.attack_speed
		orb_attack_timer.start()
		#DEBUG
		#print("mousetarget",orb_attack.mousetarget)
		#print("playerglobalpos",player.global_position)
		#print("playerpos",player.position)
		#print("pos2",orb_attack.targetpos2)
