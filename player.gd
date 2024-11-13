class_name Player
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var hurtbox = $Hurtbox
@onready var health_bar = get_tree().get_first_node_in_group("player_health_bar")
@onready var hurt_sound = $PlayerHurt
@onready var death_sound = $PlayerDeath
@onready var death_text = get_tree().get_first_node_in_group("you_died_text")
@onready var death_text_timer = get_tree().get_first_node_in_group("death_text_timer")
@export var speed = 400
@export var hp = 50


var isdead = false

signal player_death()

#HEALTH
func _ready():
	health_bar.value = hp
	death_text.visible = false
	isdead = false

func _on_hurtbox_hurt(damage):
	hp -= damage
	health_bar.value = hp
	if hp > 0:
		hurt_sound.play()
		hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	else:
		emit_signal("player_death")

func _on_player_death():
		var isdead = true
		death_text.visible = true
		death_text_timer.start()
		death_sound.play()
		hurtbox.queue_free()
		speed = 0



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
