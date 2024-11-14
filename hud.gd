extends Control

@onready var death_text = $YouDied
@onready var death_text_timer = $DeathTextTimer
@onready var player = get_tree().get_first_node_in_group("player")

func _on_death_text_timer_timeout() -> void:
	death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03
