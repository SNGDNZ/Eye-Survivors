extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D

var damage = 4
var knockback_amount = 100
var hp = 1

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 500

func _ready():
	angle = player.position.direction_to(target)
	position.x = player.position.x - 576
	position.y = player.position.y - 324

func _physics_process(delta):
	position += angle*speed*delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()
