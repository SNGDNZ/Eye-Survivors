extends Area2D


@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@export var blue_xp:Resource = preload("res://Sprites/loot/xpcrystal_3.png")
@export var pink_xp:Resource = preload("res://Sprites/loot/xpcrystal_2.png")
@export var red_xp:Resource = preload("res://Sprites/loot/xpcrystal_1.png")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var xp_sound = $XpSound

@export var xp_amount = 1

var target = null
var speed = -2

func _ready():
	if xp_amount <5:
		return
	elif xp_amount <25:
		sprite.texture = pink_xp
	else:
		sprite.texture = red_xp

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 20*delta

func collect():
	xp_sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return xp_amount

func _on_xp_sound_finished() -> void:
	queue_free()
