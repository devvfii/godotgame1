extends State
class_name PlayerHurt


@export var player : CharacterBody2D
var duration := 0.5

func Enter():
	state_name = "Hurt"
	start_timer_limit(duration)

func Exit():
	player.hit_processed = false
	

