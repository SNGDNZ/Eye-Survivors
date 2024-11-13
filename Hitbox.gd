extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableHitboxTimer

func temp_disable():
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()

func _on_disable_hitbox_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
