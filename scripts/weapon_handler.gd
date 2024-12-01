extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")

var orb = preload("res://scenes/orb.tscn")
@onready var orb_attack_timer = $OrbAttackTimer

var flame = preload("res://scenes/project_flame.tscn")
@onready var flame_attack_timer = $FlameAttackTimer
@onready var flame_detection_area = $FlameDetectionArea

var light = preload("res://scenes/septic_light.tscn")
@onready var light_attack_timer = $LightAttackTimer

func _process(_delta):
	if Input.is_action_pressed("click"):
			#print("clickpos",get_global_mouse_position())
			orb_attack_func()
	flame_detection_area.global_position = player.global_position

#ORB
func orb_attack_func():
	if player.isdead:
		return
	if orb_attack_timer.is_stopped():
		var orb_attack = orb.instantiate()
		orb_attack_timer.wait_time = orb_attack.attack_speed
		print("orbdmg",orb_attack.damage)
		print("orbatkspd",orb_attack.attack_speed)
		print("orbkb",orb_attack.knockback_amount)
		print("playerspd",player.speed)
		orb_attack.global_position = player.global_position
		orb_attack.mousetarget = get_global_mouse_position() #VECTOR
		orb_attack.direction = orb_attack.global_position.angle_to(orb_attack.mousetarget)
		orb_attack.angle = enemy.global_position.direction_to(orb_attack.mousetarget)
		
		var orb_attack_cone = Vector2.from_angle(randf_range(0,2*PI))*100
		orb_attack.targetpos1 = player.global_position + orb_attack_cone
		orb_attack.targetpos2 = orb_attack.mousetarget
		add_child(orb_attack)
		#TWEEN
		var orb_tween = orb_attack.create_tween().set_parallel(true)
		orb_tween.tween_property(orb_attack.sprite, "scale", Vector2(0.5,0.5),0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
		orb_tween.tween_property(orb_attack, "global_position", orb_attack.targetpos1,0.3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
		#orb_tween.chain().tween_property(orb_attack.sprite, "scale", Vector2(1,1),0.1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
		orb_tween.chain().tween_property(orb_attack, "global_position", orb_attack.mousetarget,0.3).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
		orb_tween.play()
		orb_attack_timer.start()
		#DEBUG
		#print("mousetarget",orb_attack.mousetarget)
		#print("playerglobalpos",player.global_position)
		#print("playerpos",player.position)
		#print("pos2",orb_attack.targetpos2)

#FLAME
var enemy_close = []

func flame_attack_func():
	if player.isdead:
		return
	if enemy_close.size() <= 0:
		return
	var flame_attack = flame.instantiate()
	flame_attack_timer.wait_time = flame_attack.attack_speed
	#print("flame atk spd", flame_attack.attack_speed)
	
	flame_attack.position = player.global_position
	flame_attack.target = get_random_target()
	add_child(flame_attack)
	flame_attack_timer.start()

func _on_flame_attack_timer_timeout() -> void:
	flame_attack_func()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position

func _on_flame_detection_area_body_entered(body: Node2D) -> void:
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_flame_detection_area_body_exited(body: Node2D) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)

#SEPTIC LIGHT
func light_attack_func():
	if player.isdead:
		return
	if light_attack_timer.is_stopped():
		var light_attack = light.instantiate()
		light.global_position = player.global_position
