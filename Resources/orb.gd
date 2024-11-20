extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var hitbox_area = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var orb_emit_snd = $OrbEmitSnd
@onready var orb_float_snd = $OrbFloatSnd
@onready var orb_impact_snd = $OrbImpactSnd
@onready var orb_float_timer = $OrbFloatTimer
@onready var orb_impact_timer = $OrbImpactTimer
@onready var cast_direction = $RayCast2D

var hp = 1 
var damage = 5
var knockback_amount = 600 
var area_size = 200 
var attack_speed = 1.5

var mousetarget := Vector2.ZERO
var targetpos1 := Vector2.ZERO
var targetpos2 := Vector2.ZERO
var angle := Vector2.ZERO
var direction : float

func _ready():
	set_collision_mask_value(3, false)
	set_collision_layer_value(3, false)
	sprite.scale = Vector2(0,0)
	orb_emit_snd.set_pitch_scale(randf_range(0.9,1.1))
	orb_emit_snd.play()
	orb_float_timer.start()


func _on_orb_float_timer_timeout() -> void:
	orb_float_snd.set_pitch_scale(randf_range(0.9,1.1))
	orb_float_snd.play()
	orb_impact_timer.start()

func _on_orb_impact_timer_timeout() -> void:
	orb_impact_snd.set_pitch_scale(randf_range(0.9,1.1))
	orb_impact_snd.play(0.1)
	set_collision_mask_value(3, true)
	set_collision_layer_value(3, true)

func _on_orb_impact_snd_finished() -> void:
	queue_free()

#func enemy_hit(charge = 1):
	#hp -= charge
	#if hp <= 0:
		#queue_free()
