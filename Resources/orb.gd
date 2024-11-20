extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var orb_timeout_timer = $OrbTimeoutTimer
@onready var orb_float_timer = $OrbFloatTimer
@onready var sprite = $Sprite2D

var damage = 4
var hp = 1

var mousetarget := Vector2.ZERO
var pos1 := Vector2.ZERO
var pos2 := Vector2.ZERO
var angle := Vector2.ZERO
var direction : float
#var speed = 500
#var moving = true
#var orb_pos2_reached = false

#func _ready():


#func _process(delta):
	#position += direction*speed*delta

#func _on_orb_float_timer_timeout() -> void:
	#moving

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()

func _on_orb_timeout_timer_timeout() -> void:
	queue_free()
