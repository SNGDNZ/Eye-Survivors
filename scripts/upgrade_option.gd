extends ColorRect

@onready var player = get_tree().get_first_node_in_group("player")
@onready var lbl_name = $LabelUpgradeTitle
@onready var lbl_desc = $LabelUpgradeDesc
@onready var lbl_level = $LabelUpgradeLevel
@onready var upgrade_icon = $TextureRect

var mouse_over = false
var upgrade = null

signal selected_upgrade

func _ready():
	if upgrade == null:
		upgrade = "food"
	connect("selected_upgrade",Callable(player,"upgrade_character"))
	lbl_name.text = UpgradeDb.UPGRADES[upgrade]["displayname"]
	lbl_desc.text = UpgradeDb.UPGRADES[upgrade]["desc"]
	lbl_level.text = UpgradeDb.UPGRADES[upgrade]["level"]
	upgrade_icon.texture = load(UpgradeDb.UPGRADES[upgrade]["icon"])

func _input(event):
	if event.is_action("click"):
		if mouse_over == true:
			Events.selected_upgrade.emit(upgrade)
			Events.update_playerstats.emit()

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false
