extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var float_timer = $FloatTimer
@onready var explosion_timer = $ExplosionTimer

var orb_level = 1
var orb_amount = 1
var orb_damage = 10
var orb_knockback_amount = 200
var orb_attack_size = 1.0
var orb_attack_speed


var target = Vector2.ZERO
var angle = Vector2.ZERO 
var orb_float_target = Vector2.ZERO

func _ready():
	target = Vector2(0,0)
	orb_float_target = Vector2.ZERO
	angle = player.global_position.direction_to(target)

func orb_attack():
	if player.isdead:
		return
	if attack_timer.is_stopped == false:
		return
	if Input.is_action_just_pressed("click"):
		target = get_global_mouse_position()
		attack_timer.wait_time = orb_attack_speed
		float_timer.start()
		attack_timer.start()
		orb_float_target.position = target.distance_to(player.position)/3 
		#orb floats a bit to the position then stops briefly before moving to target position
		


func enemy_hit(charge = 1):
	queue_free()
