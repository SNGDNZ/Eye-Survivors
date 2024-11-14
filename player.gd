class_name Player
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = get_tree().get_first_node_in_group("player_health_bar")
@onready var hurt_sound = $PlayerHurt
@onready var death_sound = $PlayerDeath
@onready var death_text = get_tree().get_first_node_in_group("you_died_text")
@onready var death_text_timer = get_tree().get_first_node_in_group("death_text_timer")
@export var speed = 300
@export var hp = 50

#UTILITY
func _input(event):
	if event.is_action_pressed("t") and not isdead:
		emit_signal("player_death")
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()


var isdead = false

signal player_death()

func _ready():
	attack()
	health_bar.value = hp
	death_text.visible = false
	isdead = false

#ATTACKS
var gun = preload("res://gun.tscn")

#AttackNodes
@onready var gun_timer = get_tree().get_first_node_in_group("gun_timer")
@onready var gun_attack_timer = get_tree().get_first_node_in_group("gun_attack_timer")
@onready var gun_enemy_detection_area = $EnemyDetectionArea

#Gun
var gun_attackspeed = 0.2
var gun_level = 1

#Enemy Related
var enemy_close = []

func attack():
	if isdead == true:
		return
	if enemy_close.size() <= 0:
		return
	var gun_attack = gun.instantiate()
	gun_attack.position = position
	gun_attack.target = get_random_target()
	gun_attack.level = gun_level
	add_child(gun_attack)
	gun_attack_timer.start()

func _on_gun_attack_timer_timeout() -> void:
	if gun_level > 0:
		gun_attack_timer.wait_time = gun_attackspeed
		attack()
		gun_attack_timer.start()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)

#HEALTH
func _on_hurtbox_hurt(damage, _angle, _knockback):
	hp -= damage
	health_bar.value = hp
	if hp > 0:
		hurt_sound.play()
		hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	else:
		emit_signal("player_death")

func _on_player_death():
		isdead = true
		hp = 0
		health_bar.value = hp
		death_text.visible = true
		death_text_timer.start()
		death_sound.play()
		hurtbox.queue_free()
		sprite.play("idle")
		velocity = Vector2.ZERO

#MOVEMENT
func movement():
	if hp <= 0:
		return
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
		#ANIMATIONS
	if velocity.x > 0:
		sprite.flip_h = true
	if velocity.x < 0:
		sprite.flip_h = false
	if velocity != Vector2.ZERO:
		sprite.play("walk")
	if velocity == Vector2.ZERO:
		sprite.play("idle")

func _physics_process(delta):
	movement()
	move_and_slide()
