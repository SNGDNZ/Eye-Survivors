extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var xp_crystal = get_tree().get_first_node_in_group("xp_crystal")
@onready var sprite = $Sprite
@onready var enemy_hurt = $EnemyHurt
@onready var hurt_timer = $EnemyHurtTimer

@export var speed = 200
@export var hp = 20
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO

signal enemy_death()
signal xp_spawn()

#HEALTH
func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hurt_timer.start()
	sprite.play("hurt")
	hp -= damage
	enemy_hurt.play()
	knockback = angle * knockback_amount

func _on_enemy_hurt_timer_timeout() -> void:
	sprite.play("walk")
	if hp <= 0:
		emit_signal("enemy_death")

func _on_enemy_death() -> void:
		queue_free()
		emit_signal("xp_spawn")

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
