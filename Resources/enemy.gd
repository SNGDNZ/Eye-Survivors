extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite
@onready var enemy_hurt_sound = $EnemyHurt
@onready var hurt_timer = $EnemyHurtTimer

@export var speed = 200
@export var hp = 20
@export var knockback_recovery = 3.5
@export var experience = 0

var knockback_enemy = Vector2.ZERO
var xp_gem = preload("res://Resources/exp_crystal.tscn")

signal enemy_death()
signal xp_spawn()
signal enemy_hurt()
signal remove_from_array(object)

#HEALTH
func _on_hurtbox_hurt(damage, angle, knockback):
	hp -= damage
	knockback_enemy = angle * knockback
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

func _on_xp_spawn() -> void:
	var new_gem = xp_gem.instantiate()
	new_gem.global_position = global_position

#MOVEMENT
	new_gem.xp_worth = experience
	loot_base.call_deferred("add_child", new_gem)
func _physics_process(delta: float):
	knockback_enemy = knockback_enemy.move_toward(Vector2.ZERO, knockback_recovery)
	if self.global_position.distance_to(player.global_position) < 43:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	velocity += knockback_enemy
	if(player.global_position.x - self.global_position.x) < 0:
		sprite.flip_h = false 
	else:
		sprite.flip_h = true
	move_and_slide()


func _on_remove_from_array(object: Variant) -> void:
	pass # Replace with function body.
