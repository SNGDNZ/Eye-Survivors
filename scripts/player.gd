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
	Events.player_death.connect(_on_player_death)
	flame_attack()
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
		hurtbox.set_collision_layer_value(2, false)
		hurtbox.set_collision_mask_value(2, false)
		sprite.play("idle")
		velocity = Vector2.ZERO

#MOVEMENT
func _physics_process(delta):
	if hp <= 0:
		return
	movement()


func movement():
	var left_mov = Input.get_action_strength("left")
	var right_mov = Input.get_action_strength("right")
	var up_mov = Input.get_action_strength("up")
	var down_mov = Input.get_action_strength("down")
	
	if right_mov == 1:
		sprite.play("walk_e")
	if left_mov == 1:
		sprite.play("walk_w")
	if up_mov == 1:
		sprite.play("walk_n")
	if down_mov == 1:
		sprite.play("walk_s")
	
	move_and_slide()
	

#ATTACKS
var flame = preload("res://scenes/project_flame.tscn")


@onready var flame_attack_timer = get_tree().get_first_node_in_group("gun_attack_timer")
@onready var flame_enemy_detection_area = $EnemyDetectionArea
@onready var flame_fire_sound = $Gun/GunFire

var orb_angle = Vector2.ZERO

#ENEMY RELATED
var enemy_close = []

#flame
func flame_attack():
	if isdead:
		return
	if enemy_close.size() <= 0:
		return
	var flame_attack = flame.instantiate()
	flame_attack.position = position
	flame_attack.target = get_random_target()
	add_child(flame_attack)
	flame_attack_timer.start()
	flame_attack_timer.wait_time = flame_attack.attack_speed

func _on_gun_attack_timer_timeout() -> void:
	flame_attack()
	flame_attack_timer.start()

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
		#print("player_xp_emit")
