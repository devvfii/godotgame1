extends Timer
class_name QuickTimer

func create(t : float) -> Timer:
	var timer = Timer.new()
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = t
	
	return timer
