extends Area2D

@export var damage = 50

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

func tempdisable():
	collision.call_deferred("set","disabled", true)
	timer.start()


func _on_timer_timeout():
	collision.call_deferred("set","disabled", false)
