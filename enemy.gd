extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite
@onready var enemy_hurt = $EnemyHurt
@onready var hurt_timer = $EnemyHurtTimer
@export var speed = 200
@export var hp = 20


#HEALTH
func _on_hurtbox_hurt(damage):
	hurt_timer.start()
	sprite.play("hurt")
	hp -= damage
	enemy_hurt.play()
	if hp <= 0:
		queue_free()

func _on_enemy_hurt_timer_timeout() -> void:
	sprite.play("walk")

#MOVEMENT
func _physics_process(delta: float):
	if self.global_position.distance_to(player.global_position) < 43:
		return
	var dir = global_position.direction_to(player.global_position)
	velocity = dir*speed
	if(player.global_position.x - self.global_position.x) < 0:
		sprite.flip_h = false 
	else:
		sprite.flip_h = true
	move_and_slide()
