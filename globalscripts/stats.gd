extends Node

var collected_upgrades = []
var upgrade_options = []
#WEAPON
var attack_speed_mult := 1.0 #
var damage_mult := 1.0 #
var area_mult := 1.0
var attack_amount_mult := 1
var penetration_mult := 0 #
var knockback_mult := 1 
#PLAYER
var speed_mult := 1.0
var sprint_mult := 1.0
var stamina_mult := 1.0
var stamina_regen_mult := 1.0
var health_mult := 1.0
var health_regen_mult := 1.0
var pickup_range_mult := 1.0
var xp_mult := 1.0

func _ready():
	Events.calculate_upgrade.connect(calculate_stats)

func calculate_stats(upgrade):
	match UpgradeDb.UPGRADES[upgrade]["category"]:
		"attack_speed":
			attack_speed_mult -= 0.18
		"damage":
			damage_mult += 0.1
		"area":
			area_mult += 0.1
		"attack_amount":
			attack_amount_mult += 1
		"penetration":
			penetration_mult += 1
		"knockback":
			knockback_mult += 0.1
		"speed":
			speed_mult += 0.1
			sprint_mult += 0.05
		"stamina":
			stamina_mult += 0.1
		"stamina_regen":
			stamina_regen_mult += 0.1
		"health":
			health_mult += 0.1
		"health_regen_mult":
			health_regen_mult += 0.1
		"pickup_range":
			pickup_range_mult += 0.1
		"xp":
			xp_mult += 0.1
