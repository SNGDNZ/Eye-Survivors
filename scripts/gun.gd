extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")


var hp := 1
var speed := 1200
var damage := 10
var knockback_amount := 200
var area_size := 1
var attack_speed := 0.3

var target = Vector2.ZERO
var angle = Vector2.ZERO 

signal remove_from_array(object)

func _ready():
	angle = player.global_position.direction_to(target)
	rotation = angle.angle()

func _physics_process(delta):
	position += angle*speed*delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()

func _on_timer_timeout() -> void:
	emit_signal("remove_from_array",self)
	queue_free()
