extends State
class_name PlayerRoll

@export var player : CharacterBody2D
var duration := 0.7

func Enter():
	state_name = "Rolling"
	player.speed *= 3.0
	player.hurtbox.collision.call_deferred("set", "disabled", true)
	
	start_timer_limit(duration)

func Physics_Update(_delta):
	player.speed = lerpf(player.speed, 60, 0.06)

func Exit():
	player.speed = 120.0
	player.hurtbox.collision.call_deferred("set", "disabled", false)
