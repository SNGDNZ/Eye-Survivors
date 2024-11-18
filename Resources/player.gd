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
@onready var level_display = get_tree().get_first_node_in_group("level_display")
@onready var xp_bar = get_tree().get_first_node_in_group("xp_bar")

@export var speed = 300
@export var hp = 50

var isdead = false
var xp_amt = 0
var xp_level = 1
var xp_collected = 0

signal player_hurt()
signal player_death()

func _ready():
	gun_attack()
	health_bar.value = hp
	death_text.visible = false
	isdead = false

#HEALTH
func _on_hurtbox_hurt(damage, _angle, _knockback_amount):
	hp -= damage
	if hp > 0:
		emit_signal("player_hurt")
	else:
		emit_signal("player_death")

func _on_player_hurt() -> void:
	health_bar.value = hp
	hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	hurt_sound.play()

func _on_player_death():
		isdead = true
		print("isdead")
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

func _physics_process(_delta):
	movement()
	move_and_slide()

#ATTACKS
var gun = preload("res://Resources/gun.tscn")
var orb = preload("res://Resources/orb.tscn")

@onready var gun_attack_timer = get_tree().get_first_node_in_group("gun_attack_timer")
@onready var gun_enemy_detection_area = $EnemyDetectionArea
@onready var gun_fire_sound = $Gun/GunFire

@onready var orb_attack_timer = $Orb/OrbAttackTimer
@onready var orb_float_timer = $Orb/OrbFloatTimer
@onready var orb_tick_timer = $Orb/OrbTickTimer
@onready var orb_fire_sound = $Orb/OrbFire
@onready var orb_impact_sound = $Orb/OrbImpact

var orb_float_target = Vector2.ZERO
var orb_angle = Vector2.ZERO
var orb_tick_amount = 0

#ENEMY RELATED
var enemy_close = []

#ORB
var orb_attack_speed = 0.2
var orb_level = 1

func _process(delta):
	if Input.is_action_just_pressed("click"):
		print ("click")
		orb_attack()

func orb_attack():
	print ("orb_attack")
	if isdead:
		return
	#if orb_attack_timer.is_stopped = false:
		return
	var orb_attack = orb.instantiate()
	orb_attack.position = position
	orb_attack.target = get_global_mouse_position()
	orb_attack.level = orb_level
	orb_attack_timer.wait_time = orb_attack_speed
	add_child(orb_attack)
	orb_attack_timer.start()
	orb_float_timer.start()

func _on_orb_float_timer_timeout():
	orb_tick_timer.start()

func _on_orb_tick_timer_timeout() -> void:
	Events.orb_tick.emit()


#GUN
var gun_attackspeed = 0.2
var gun_level = 1

func gun_attack():
	if isdead:
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
		gun_attack()
		gun_attack_timer.start()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)



#XP RELATED
func _on_grab_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var gem_xp = area.collect()
		Events.calculate_xp.emit(gem_xp)
		print ("player_xp_emit")