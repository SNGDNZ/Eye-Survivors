extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var hitbox = $CollisionShape2D
@onready var particles = $CPUParticles2D

var hp := 1 + Stats.penetration_mult
var speed := 1200 * Stats.speed_mult
var damage := 10 * Stats.damage_mult
var knockback_amount := 60 * Stats.knockback_mult
var area_size := 1 * Stats.area_mult
var attack_speed := 0.3 * Stats.attack_speed_mult

var target = Vector2.ZERO
var angle = Vector2.ZERO 

signal remove_from_array(object)

func _ready():
	angle = player.global_position.direction_to(target)
	rotation = angle.angle()

func _physics_process(delta):
	position += angle*speed*delta
	if position.distance_to(player.global_position) > 800:
		queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		hitbox.queue_free()
		particles.emitting = false
		sprite.visible = false

func _on_timer_timeout() -> void:
	emit_signal("remove_from_array",self)
	queue_free()
