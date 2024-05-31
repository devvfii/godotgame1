extends State
class_name PlayerAttacking

var duration := 1.2

func Enter():
	state_name = "Attacking"
	
	start_timer_limit(duration)

