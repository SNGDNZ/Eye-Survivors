extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var xp_crystal = preload("res://exp_crystal.tscn")
@onready var sprite = $Sprite
@onready var enemy_hurt_sound = $EnemyHurt
@onready var enemy_death_sound = $EnemyDeath
@onready var hurt_timer = $EnemyHurtTimer
@export var speed = 200
@export var hp = 20
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO

signal enemy_death()
signal xp_spawn()
signal enemy_hurt()
signal remove_from_array(object)

#HEALTH
func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	emit_signal("enemy_hurt")

func _on_enemy_hurt():
	hurt_timer.start()
	sprite.play("hurt")
	enemy_hurt_sound.play()

func _on_enemy_hurt_timer_timeout() -> void:
	sprite.play("walk")
	if hp <=0:
		emit_signal("enemy_death")

func _on_enemy_death() -> void:
	emit_signal("xp_spawn")
	emit_signal("remove_from_array",self)
	queue_free()



#MOVEMENT
func _physics_process(delta: float):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	if self.global_position.distance_to(player.global_position) < 43:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	velocity += knockback
	if(player.global_position.x - self.global_position.x) < 0:
		sprite.flip_h = false 
	else:
		sprite.flip_h = true
	move_and_slide()
