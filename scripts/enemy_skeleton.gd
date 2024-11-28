extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var hurtbox = $Hurtbox/CollisionShape2D
@onready var sprite = $Sprite
@onready var dmg_anim = $Sprite/AnimationPlayer
@onready var hurt_sound1 = $EnemyHurtSnd1
@onready var hurt_sound2 = $EnemyHurtSnd2
@onready var hurt_timer = $EnemyHurtTimer
@onready var death_timer = $EnemyDeathTimer
@onready var animation_timer = $AnimationTimer
@export var speed = 70
@export var hp = 20
@export var knockback_recovery = 3.5
@export var experience = 1

var isdead = false
var knockback_enemy = Vector2.ZERO
var xp_gem = preload("res://scenes/xp_crystal.tscn")

signal enemy_death()
signal xp_spawn(_on_xp_spawn)
signal enemy_hurt()
signal remove_from_array(object)

func _onready():
	sprite.speed_scale = speed / 30

#HEALTH
func _on_hurtbox_hurt(damage, angle, knockback):
	hp -= damage
	knockback_enemy = angle * knockback
	emit_signal("enemy_hurt")

func _on_enemy_hurt():
	hurt_timer.start()
	if randf_range(0,1) > 0.5:
		hurt_sound1.set_pitch_scale(randf_range(0.4, 0.6))
		hurt_sound1.play()
	else:
		hurt_sound2.set_pitch_scale(randf_range(0.4, 0.6))
		hurt_sound2.play()

func _on_enemy_hurt_timer_timeout() -> void:
	sprite.play("walk_e")
	if hp <=0 and not isdead:
		emit_signal("enemy_death")
		isdead = true

func _on_enemy_death() -> void:
	death_timer.start()
	sprite.play("death")
	hurtbox.queue_free()
	emit_signal("remove_from_array",self)

func _on_enemy_death_timer_timeout() -> void:
	emit_signal("xp_spawn")

func _on_xp_spawn():
	var new_gem = xp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.xp_worth = experience
	loot_base.call_deferred("add_child",new_gem)
	queue_free()

#MOVEMENT
func _physics_process(delta: float):
	if isdead:
		return
	knockback_enemy = knockback_enemy.move_toward(Vector2.ZERO, knockback_recovery)
	if global_position.distance_to(player.global_position) < 10:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	velocity += knockback_enemy
	move_and_slide()

func _on_animation_timer_timeout() -> void:
	var atp = global_position.angle_to_point(player.global_position) #angle to player
	if atp > -PI/8 and atp < PI/8:
		sprite.play("walk_e")
	elif atp > PI/8 and atp < PI*3/8:
		sprite.play("walk_se")
	elif atp > PI*3/8 and atp < PI*5/8:
		sprite.play("walk_s")
	elif atp > PI*5/8 and atp < PI*7/8:
		sprite.play("walk_sw")
	elif atp < -PI/8 and atp > -PI*3/8:
		sprite.play("walk_ne")
	elif atp < -PI*3/8 and atp > -PI*5/8:
		sprite.play("walk_n")
	elif atp < -PI*5/8 and atp > -PI*7/8:
		sprite.play("walk_nw")
	else:
		sprite.play("walk_w")
	print(atp)

func _on_remove_from_array(object: Variant) -> void:
	pass # Replace with function body.
