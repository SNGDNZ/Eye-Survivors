extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitbox") var HurtboxType = 0
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtboxType:
				0: #Cooldown
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: #HitOnce
					pass
				2: #DisableHitbox
					if area.has_method("temp_disable"):
						area.temp_disable()
			var damage = area.damage
			emit_signal("hurt",damage)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
