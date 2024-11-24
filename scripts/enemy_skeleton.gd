class_name XpCrystal
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite
@onready var animation = $Sprite/AnimationPlayer
@onready var hurt_sound1 = $EnemyHurtSnd1
@onready var hurt_sound2 = $EnemyHurtSnd2
@onready var hurt_timer = $EnemyHurtTimer
@onready var death_timer = $EnemyDeathTimer

@export var speed = 70
@export var hp = 20
@export var knockback_recovery = 3.5
@export var experience = 0

var isdead = false
var knockback_enemy = Vector2.ZERO
var xp_gem = preload("res://scenes/xp_crystal.tscn")

signal enemy_death()
signal xp_spawn()
signal enemy_hurt()
signal remove_from_array(object)

#HEALTH
func _on_hurtbox_hurt(damage, angle, knockback):
	hp -= damage
	knockback_enemy = angle * knockback
	print("enemy hurt")
	emit_signal("enemy_hurt")

func _on_enemy_hurt():
	hurt_timer.start()
	#animation.play("damage_flash")
	if randf_range(0,1) > 0.5:
		hurt_sound1.set_pitch_scale(randf_range(0.5, 0.7))
		hurt_sound1.play()
	else:
		hurt_sound2.set_pitch_scale(randf_range(0.5, 0.7))
		hurt_sound2.play()

func _on_enemy_hurt_timer_timeout() -> void:
	sprite.play("walk_e")
	if hp <=0:
		emit_signal("enemy_death")
		isdead = true

func _on_enemy_death() -> void:
	sprite.play("death")
	emit_signal("xp_spawn")
	emit_signal("remove_from_array",self)
	death_timer.start()

func _on_enemy_death_timer_timeout() -> void:
	#emit_signal("xp_spawn")
	
	self.queue_free()

func _on_xp_spawn():
	var new_gem = xp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.xp_worth = experience
	loot_base.call_deferred("add_child",new_gem)
	

#MOVEMENT
func _physics_process(delta: float):
	if isdead:
		return
	knockback_enemy = knockback_enemy.move_toward(Vector2.ZERO, knockback_recovery)
	if self.global_position.distance_to(player.global_position) < 10:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	velocity += knockback_enemy
	if(player.global_position.x - self.global_position.x) < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	move_and_slide()


func _on_remove_from_array(object: Variant) -> void:
	pass # Replace with function body.
