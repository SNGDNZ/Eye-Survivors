extends Node

@onready var sprite = $Sprite2D
@onready var attack_timer = $AttackTimer

var hp = 1 
var damage = 5
var knockback_amount = 200 
var area_size = 200 
var attack_speed = 1.5 * Stats.attack_speed_mult

var mousetarget := Vector2.ZERO
var targetpos1 := Vector2.ZERO
var targetpos2 := Vector2.ZERO
var angle := Vector2.ZERO
