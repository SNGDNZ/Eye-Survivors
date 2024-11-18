extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var orb_float_timer = get_tree().get_first_node_in_group("orb_float_timer")
@onready var sprite = $Sprite2D

var level = 1
var damage = 4
var knockback_amount = 100

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 300

func _ready():
	angle = player.position.direction_to(target)
	match level:
		1:
			#Stats.orb_duration = 3
			damage = 4
			knockback_amount = 100

func _physics_process(delta):
	position += angle*speed*delta
