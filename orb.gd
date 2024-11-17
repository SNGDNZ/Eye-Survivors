extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D

var level = 1
var orb_amount = 1
var damage = 10
var knockback_amount = 200
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO 

signal remove_from_array(object)

func _on_attack():
	var input_location = Input.("left", "right", "up", "down")

func _physics_process(delta):


func enemy_hit(charge = 1):
	queue_free()
