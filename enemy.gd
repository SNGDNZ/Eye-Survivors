extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite
@export var speed = 200
@export var hp = 20

#HEALTH
func _on_hurtbox_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

#MOVEMENT
func _physics_process(delta: float):
	if self.global_position.distance_to(player.global_position) < 45:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	if(player.global_position.x - self.global_position.x) < 0:
		sprite.flip_h = false 
	else:
		sprite.flip_h = true
	move_and_slide()
