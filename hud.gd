extends Control

@onready var death_text = get_tree().get_first_node_in_group("you_died_text")
@onready var death_text_timer = get_tree().get_first_node_in_group("death_text_timer")

func _on_death_text_timer_timeout() -> void:
	death_text.visible_characters += 1
	death_text_timer.wait_time += 0.03
