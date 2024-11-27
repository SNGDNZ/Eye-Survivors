extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@export var green_xp:Resource = preload("res://sprites/loot/xp/xp_gem_green.png")
@export var blue_xp:Resource = preload("res://sprites/loot/xp/xp_gem_blue.png")
@export var red_xp:Resource = preload("res://sprites/loot/xp/xp_gem_red.png")
@export var white_xp:Resource = preload("res://sprites/loot/xp/xp_gem_white.png")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var xp_sound = $XpSound

@export var xp_worth = 1

var target = null
var speed = -4

func _ready():
	if xp_worth <5:
		sprite.texture = blue_xp
	elif xp_worth <25:
		sprite.texture = green_xp
	elif xp_worth <50:
		sprite.texture = red_xp
	else:
		sprite.texture = white_xp

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 20*delta

func collect():
	xp_sound.play(0.5)
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	#print("xp_worth", xp_worth)
	return xp_worth


func _on_xp_sound_finished() -> void:
	queue_free()
