extends Area2D
class_name HitBox

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

var attack_object : Attack

func temp_disable():
	collision.call_deferred("set","disabled", true)
	timer.start()
	
func load_attack(attack: Attack):
	attack_object = attack

func _on_timer_timeout():
	collision.call_deferred("set","disabled", false)
