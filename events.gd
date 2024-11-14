extends Node

#ENEMY
signal hurtbox_hurt()
signal enemy_hurt()
signal xp_spawn_signal()
signal hurt(damage, angle, knockback)

#PLAYER
signal player_hurtbox_hurt(damage, angle, knockback)
signal player_hurt()
signal player_death()
