extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var orb_timeout_timer = $OrbTimeoutTimer
@onready var sprite = $Sprite2D

var damage = 4

var hp = 1

var mousetarget = Vector2.ZERO
var pos1 = Vector2.ZERO
var pos2 = Vector2.ZERO
var direction = Vector2.ZERO
var angle:float
var speed = 500
var moving = true

func _ready():
	direction = position.direction_to(mousetarget)
	angle = position.angle_to(mousetarget)

	position.x = player.position.x - 576
	position.y = player.position.y - 324
	var moving = true
	

func _physics_process(delta):
	if moving:
		position += direction*speed*delta - pos1




func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()


func _on_orb_timeout_timer_timeout() -> void:
	queue_free()
