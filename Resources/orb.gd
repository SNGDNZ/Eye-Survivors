extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var orb_float_timer = get_tree().get_first_node_in_group("orb_float_timer")
@onready var sprite = $Sprite2D

var level = 1
#Stats.orb_amount
var damage = 4
var knockback_amount = 100
var attack_size = 1.0
#Stats.orb_attack_speed 
var orb_tick_amount = 0

var target = Vector2.ZERO
var speed = 300
var angle = Vector2.ZERO

func _ready():
	position = player.position
	Events.orb_tick.connect(_on_orb_tick)
	angle = player.global_position.direction_to(target)
	match level:
		1:
			#Stats.orb_duration = 3
			damage = 4
			knockback_amount = 100
			attack_size = 1.0

func _physics_process(delta):
	position += angle*speed*delta

func _on_orb_tick():
	orb_tick_amount += 1
	if orb_tick_amount == Stats.orb_duration:
		queue_free()
