extends ColorRect

@onready var player = get_tree().get_first_node_in_group("player")

var mouse_over = false
var upgrade = null

signal selected_upgrade

func _ready():
	connect("selected_upgrade",Callable(player,"upgrade_character"))

func _input(event):
	if event.is_action("click"):
		if mouse_over == true:
			Events.selected_upgrade.emit(upgrade)

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false
