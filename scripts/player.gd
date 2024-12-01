class_name Player
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@onready var sprite: AnimatedSprite2D = $Sprite2D

@onready var hurtbox = $Hurtbox
@onready var hurt_sound = $PlayerHurtSnd
@onready var death_sound = $PlayerDeathSnd
@onready var stamina_timer = $StaminaTimer
@onready var stamina_regen_timer = $StaminaRegenTimer
@onready var stamina_timeout_timer = $StaminaTimeoutTimer

@export var speed = 100 * Stats.speed_mult
@export var hp_max = 50
@export var hp = 50
@export var stamina_max = 50
@export var stamina = 50
@export var stamina_regen = 1 #per 0.1 second
@export var stamina_usage = 0.5 #per 0.05 second
@export var stamina_timeout = false

var sprint_mod = 1.4
var sprinting = false
var isdead = false
var xp_amt = 0
var xp_level = 1
var xp_collected = 0

signal player_hurt()
signal player_death()

func _ready():
	Events.player_hurt.connect(_on_player_hurt)
	Events.player_death.connect(_on_player_death)
	isdead = false

#HEALTH
func _on_hurtbox_hurt(damage, _angle, _knockback):
	hp -= damage
	if hp > 0:
		emit_signal("player_hurt")
		Events.player_hurt.emit(damage)
	else:
		emit_signal("player_death")
		Events.player_death.emit()

func _on_player_hurt(_damage) -> void:
	hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	hurt_sound.play()

func _on_player_death():
		isdead = true
		print("isdead")
		hp = 0
		death_sound.play()
		hurtbox.set_collision_layer_value(2, false)
		hurtbox.set_collision_mask_value(2, false)
		sprite.play("idle")
		velocity = Vector2.ZERO

#MOVEMENT
func _physics_process(_delta):
	if hp <= 0:
		return
	if sprinting:
		sprite.speed_scale = speed*sprint_mod / 100
	else:
		sprite.speed_scale = speed / 100
	movement()

func movement():
	if Input.is_action_pressed("shift") and stamina > 0 and stamina_timeout_timer.is_stopped() and sprite.is_playing():
		sprinting = true
		stamina_regen_timer.stop()
		if stamina_timer.is_stopped():
			stamina_timer.start()
	else:
		sprinting = false
		stamina_timer.stop()
		if stamina_regen_timer.is_stopped() and stamina < stamina_max:
			stamina_regen_timer.start()
			if stamina < 0.5 and stamina_timeout_timer.is_stopped():
				stamina_timeout_timer.start()
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if direction == Vector2(0,0):
		sprite.play("idle")
		sprite.pause()
	elif direction == Vector2(1,0):
		sprite.play("walk_e")
	elif direction == Vector2(-1,0):
		sprite.play("walk_w")
	elif direction == Vector2(0,-1):
		sprite.play("walk_n")
	elif direction == Vector2(0,1):
		sprite.play("walk_s")
	elif direction.x < -0.7 and direction.y > 0.7:
		sprite.play("walk_sw")
	elif direction.x > 0.7 and direction.y < -0.7:
		sprite.play("walk_ne")
	elif direction.x and direction.y > 0.7:
		sprite.play("walk_se")
	elif direction.x and direction.y < -0.7:
		sprite.play("walk_nw")
	direction = direction.normalized()
	if sprinting:
		velocity = direction * speed * sprint_mod
	else:
		velocity = direction * speed
	move_and_slide()

func _on_stamina_timer_timeout() -> void:
	stamina -= stamina_usage

func _on_stamina_regen_timer_timeout() -> void:
	stamina += stamina_regen

#XP RELATED
func _on_grab_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var gem_xp = area.collect()
		Events.calculate_xp.emit(gem_xp)
		#print("player_xp_emit")
