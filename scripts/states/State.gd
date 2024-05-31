extends Node

class_name State
signal Transitioned

var state_name : String

var quick_timer_helper := QuickTimer.new()
var timer : Timer

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta : float):
	pass
	
func Physics_Update(_delta: float):
	pass

func getState():
	return state_name

func transition_to(new_state_name : String):
	Transitioned.emit(self, new_state_name)
	
func return_to_idle():
	timer.queue_free()
	Transitioned.emit(self, "Idle")
	
func start_timer_limit(t : float):
	timer = quick_timer_helper.create(t)
	add_child(timer)
	timer.timeout.connect(return_to_idle)
	timer.start()
