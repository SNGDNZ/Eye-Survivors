extends Node


const ICON_PATH = "res://sprites/upgrade_icons/"
#const WEAPON_PATH = 
const UPGRADES = {
	"food":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Food",
		"desc": "+50 HP",
		"level": "",
		"prerequisites": [],
		"type": "item"
	},
	"attack_speed1":{
		"icon": ICON_PATH + "attack_speed.png",
		"displayname": "Attack speed",
		"desc": "+10% attack speed",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"attack_speed2":{
		"icon": ICON_PATH + "attack_speed.png",
		"displayname": "Attack speed",
		"desc": "+10% attack speed",
		"level": "Lvl 2",
		"prerequisites": ["attack_speed1"],
		"type": "upgrade"
	},
	"attack_speed3":{
		"icon": ICON_PATH + "attack_speed.png",
		"displayname": "Attack speed",
		"desc": "+10% attack speed",
		"level": "Lvl 3",
		"prerequisites": ["attack_speed2"],
		"type": "upgrade"
	},
	"attack_speed4":{
		"icon": ICON_PATH + "attack_speed.png",
		"displayname": "Attack speed",
		"desc": "+10% attack speed",
		"level": "Lvl 4",
		"prerequisites": ["attack_speed3"],
		"type": "upgrade"
	},
	"attack_speed5":{
		"icon": ICON_PATH + "attack_speed.png",
		"displayname": "Attack speed",
		"desc": "+10% attack speed",
		"level": "Lvl 5",
		"prerequisites": ["attack_speed4"],
		"type": "upgrade"
	},
	"damage1":{
		"icon": ICON_PATH + "damage.png",
		"displayname": "Damage",
		"desc": "+10% damage",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"damage2":{
		"icon": ICON_PATH + "damage.png",
		"displayname": "Damage",
		"desc": "+10% damage",
		"level": "Lvl 2",
		"prerequisites": ["damage1"],
		"type": "upgrade"
	},
	"damage3":{
		"icon": ICON_PATH + "damage.png",
		"displayname": "Damage",
		"desc": "+10% damage",
		"level": "Lvl 3",
		"prerequisites": ["damage2"],
		"type": "upgrade"
	},
	"damage4":{
		"icon": ICON_PATH + "damage.png",
		"displayname": "Damage",
		"desc": "+10% damage",
		"level": "Lvl 4",
		"prerequisites": ["damage3"],
		"type": "upgrade"
	},
	"damage5":{
		"icon": ICON_PATH + "damage.png",
		"displayname": "Damage",
		"desc": "+10% damage",
		"level": "Lvl 5",
		"prerequisites": ["damage4"],
		"type": "upgrade"
	},
	"area1":{
		"icon": ICON_PATH + "area.png",
		"displayname": "Area",
		"desc": "+10% area",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"area2":{
		"icon": ICON_PATH + "area.png",
		"displayname": "Area",
		"desc": "+10% area",
		"level": "Lvl 2",
		"prerequisites": ["area1"],
		"type": "upgrade"
	},
	"area3":{
		"icon": ICON_PATH + "area.png",
		"displayname": "Area",
		"desc": "+10% area",
		"level": "Lvl 3",
		"prerequisites": ["area2"],
		"type": "upgrade"
	},
	"area4":{
		"icon": ICON_PATH + "area.png",
		"displayname": "Area",
		"desc": "+10% area",
		"level": "Lvl 4",
		"prerequisites": ["area3"],
		"type": "upgrade"
	},
	"area5":{
		"icon": ICON_PATH + "area.png",
		"displayname": "Area",
		"desc": "+10% area",
		"level": "Lvl 5",
		"prerequisites": ["area4"],
		"type": "upgrade"
	},
	"penetration1":{
		"icon": ICON_PATH + "penetration.png",
		"displayname": "Penetration",
		"desc": "+1 enemy penetration",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"penetration2":{
		"icon": ICON_PATH + "penetration.png",
		"displayname": "Penetration",
		"desc": "+1 enemy penetration",
		"level": "Lvl 2",
		"prerequisites": ["penetration1"],
		"type": "upgrade"
	},
	"penetration3":{
		"icon": ICON_PATH + "penetration.png",
		"displayname": "Penetration",
		"desc": "+1 enemy penetration",
		"level": "Lvl 3",
		"prerequisites": ["penetration2"],
		"type": "upgrade"
	},
	"penetration4":{
		"icon": ICON_PATH + "penetration.png",
		"displayname": "Penetration",
		"desc": "+1 enemy penetration",
		"level": "Lvl 4",
		"prerequisites": ["penetration3"],
		"type": "upgrade"
	},
	"penetration5":{
		"icon": ICON_PATH + "penetration.png",
		"displayname": "Penetration",
		"desc": "+1 enemy penetration",
		"level": "Lvl 5",
		"prerequisites": ["penetration4"],
		"type": "upgrade"
	},
	"knockback1":{
		"icon": ICON_PATH + "knockback.png",
		"displayname": "Knockback",
		"desc": "+10% knockback",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"knockback2":{
		"icon": ICON_PATH + "knockback.png",
		"displayname": "Knockback",
		"desc": "+10% knockback",
		"level": "Lvl 2",
		"prerequisites": ["knockback1"],
		"type": "upgrade"
	},
	"knockback3":{
		"icon": ICON_PATH + "knockback.png",
		"displayname": "Knockback",
		"desc": "+10% knockback",
		"level": "Lvl 3",
		"prerequisites": ["knockback2"],
		"type": "upgrade"
	},
	"knockback4":{
		"icon": ICON_PATH + "knockback.png",
		"displayname": "Knockback",
		"desc": "+10% knockback",
		"level": "Lvl 4",
		"prerequisites": ["knockback3"],
		"type": "upgrade"
	},
	"knockback5":{
		"icon": ICON_PATH + "knockback.png",
		"displayname": "Knockback",
		"desc": "+10% knockback",
		"level": "Lvl 5",
		"prerequisites": ["knockback4"],
		"type": "upgrade"
	},
	"speed1":{
		"icon": ICON_PATH + "movement_speed.png",
		"displayname": "Movement speed",
		"desc": "+10% speed, +5% sprint speed",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"speed2":{
		"icon": ICON_PATH + "movement_speed.png",
		"displayname": "Movement speed",
		"desc": "+10% speed, +5% sprint speed",
		"level": "Lvl 2",
		"prerequisites": ["speed1"],
		"type": "upgrade"
	},
	"speed3":{
		"icon": ICON_PATH + "movement_speed.png",
		"displayname": "Movement speed",
		"desc": "+10% speed, +5% sprint speed",
		"level": "Lvl 3",
		"prerequisites": ["speed2"],
		"type": "upgrade"
	},
	"speed4":{
		"icon": ICON_PATH + "movement_speed.png",
		"displayname": "Movement speed",
		"desc": "+10% speed, +5% sprint speed",
		"level": "Lvl 4",
		"prerequisites": ["speed3"],
		"type": "upgrade"
	},
	"speed5":{
		"icon": ICON_PATH + "movement_speed.png",
		"displayname": "Movement speed",
		"desc": "+10% speed, +5% sprint speed",
		"level": "Lvl 5",
		"prerequisites": ["speed4"],
		"type": "upgrade"
	},
	"stamina1":{
		"icon": ICON_PATH + "stamina.png",
		"displayname": "Stamina",
		"desc": "+10% stamina",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"stamina2":{
		"icon": ICON_PATH + "stamina.png",
		"displayname": "Stamina",
		"desc": "+10% stamina",
		"level": "Lvl 2",
		"prerequisites": ["stamina1"],
		"type": "upgrade"
	},
	"stamina3":{
		"icon": ICON_PATH + "stamina.png",
		"displayname": "Stamina",
		"desc": "+10% stamina",
		"level": "Lvl 3",
		"prerequisites": ["stamina2"],
		"type": "upgrade"
	},
	"stamina4":{
		"icon": ICON_PATH + "stamina.png",
		"displayname": "Stamina",
		"desc": "+10% stamina",
		"level": "Lvl 4",
		"prerequisites": ["stamina3"],
		"type": "upgrade"
	},
	"stamina5":{
		"icon": ICON_PATH + "stamina.png",
		"displayname": "Stamina",
		"desc": "+10% stamina",
		"level": "Lvl 5",
		"prerequisites": ["stamina4"],
		"type": "upgrade"
	},
	"stamina_regen1":{
		"icon": ICON_PATH + "stamina_regen.png",
		"displayname": "Stamina regen",
		"desc": "+10% stamina regen",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"stamina_regen2":{
		"icon": ICON_PATH + "stamina_regen.png",
		"displayname": "Stamina regen",
		"desc": "+10% stamina regen",
		"level": "Lvl 2",
		"prerequisites": ["stamina_regen1"],
		"type": "upgrade"
	},
	"stamina_regen3":{
		"icon": ICON_PATH + "stamina_regen.png",
		"displayname": "Stamina regen",
		"desc": "+10% stamina regen",
		"level": "Lvl 3",
		"prerequisites": ["stamina_regen2"],
		"type": "upgrade"
	},
	"stamina_regen4":{
		"icon": ICON_PATH + "stamina_regen.png",
		"displayname": "Stamina regen",
		"desc": "+10% stamina regen",
		"level": "Lvl 4",
		"prerequisites": ["stamina_regen3"],
		"type": "upgrade"
	},
	"stamina_regen5":{
		"icon": ICON_PATH + "stamina_regen.png",
		"displayname": "Stamina regen",
		"desc": "+10% stamina regen",
		"level": "Lvl 5",
		"prerequisites": ["stamina_regen4"],
		"type": "upgrade"
	},
	"health1":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Health",
		"desc": "+10% Health",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"health2":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Health",
		"desc": "+10% Health",
		"level": "Lvl 2",
		"prerequisites": ["health1"],
		"type": "upgrade"
	},
	"health3":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Health",
		"desc": "+10% Health",
		"level": "Lvl 3",
		"prerequisites": ["health2"],
		"type": "upgrade"
	},
	"health4":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Health",
		"desc": "+10% Health",
		"level": "Lvl 4",
		"prerequisites": ["health3"],
		"type": "upgrade"
	},
	"health5":{
		"icon": ICON_PATH + "health.png",
		"displayname": "Health",
		"desc": "+10% Health",
		"level": "Lvl 5",
		"prerequisites": ["health4"],
		"type": "upgrade"
	},
	"health_regen1":{
		"icon": ICON_PATH + "health_regen.png",
		"displayname": "Health regen",
		"desc": "+0.3/s health regen",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"health_regen2":{
		"icon": ICON_PATH + "health_regen.png",
		"displayname": "Health regen",
		"desc": "+0.3/s health regen",
		"level": "Lvl 2",
		"prerequisites": ["health_regen1"],
		"type": "upgrade"
	},
	"health_regen3":{
		"icon": ICON_PATH + "health_regen.png",
		"displayname": "Health regen",
		"desc": "+0.3/s health regen",
		"level": "Lvl 3",
		"prerequisites": ["health_regen2"],
		"type": "upgrade"
	},
	"health_regen4":{
		"icon": ICON_PATH + "health_regen.png",
		"displayname": "Health regen",
		"desc": "+0.3/s health regen",
		"level": "Lvl 4",
		"prerequisites": ["health_regen3"],
		"type": "upgrade"
	},
	"health_regen5":{
		"icon": ICON_PATH + "health_regen.png",
		"displayname": "Health regen",
		"desc": "+0.3/s health regen",
		"level": "Lvl 5",
		"prerequisites": ["health_regen4"],
		"type": "upgrade"
	},
	"pickup_range1":{
		"icon": ICON_PATH + "pickup_range.png",
		"displayname": "Pickup range",
		"desc": "+10% pickup range",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"pickup_range2":{
		"icon": ICON_PATH + "pickup_range.png",
		"displayname": "Pickup range",
		"desc": "+10% pickup range",
		"level": "Lvl 2",
		"prerequisites": ["pickup_range1"],
		"type": "upgrade"
	},
	"pickup_range3":{
		"icon": ICON_PATH + "pickup_range.png",
		"displayname": "Pickup range",
		"desc": "+10% pickup range",
		"level": "Lvl 3",
		"prerequisites": ["pickup_range2"],
		"type": "upgrade"
	},
	"pickup_range4":{
		"icon": ICON_PATH + "pickup_range.png",
		"displayname": "Pickup range",
		"desc": "+10% pickup range",
		"level": "Lvl 4",
		"prerequisites": ["pickup_range3"],
		"type": "upgrade"
	},
	"pickup_range5":{
		"icon": ICON_PATH + "pickup_range.png",
		"displayname": "Pickup range",
		"desc": "+10% pickup range",
		"level": "Lvl 5",
		"prerequisites": ["pickup_range4"],
		"type": "upgrade"
	},
	"xp1":{
		"icon": ICON_PATH + "xp.png",
		"displayname": "Xp amount",
		"desc": "+10% xp",
		"level": "Lvl 1",
		"prerequisites": [],
		"type": "upgrade"
	},
	"xp2":{
		"icon": ICON_PATH + "xp.png",
		"displayname": "Xp amount",
		"desc": "+10% xp",
		"level": "Lvl 2",
		"prerequisites": ["xp1"],
		"type": "upgrade"
	},
	"xp3":{
		"icon": ICON_PATH + "xp.png",
		"displayname": "Xp amount",
		"desc": "+10% xp",
		"level": "Lvl 3",
		"prerequisites": ["xp2"],
		"type": "upgrade"
	},
	"xp4":{
		"icon": ICON_PATH + "xp.png",
		"displayname": "Xp amount",
		"desc": "+10% xp",
		"level": "Lvl 4",
		"prerequisites": ["xp3"],
		"type": "upgrade"
	},
	"xp5":{
		"icon": ICON_PATH + "xp.png",
		"displayname": "Xp amount",
		"desc": "+10% xp",
		"level": "Lvl 5",
		"prerequisites": ["xp4"],
		"type": "upgrade"
	},
}
