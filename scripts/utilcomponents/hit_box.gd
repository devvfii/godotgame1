extends Area2D
class_name HitBox

@export var health_component : HealthComponent

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

func tempdisable():
	collision.call_deferred("set","disabled", true)
	timer.start()
	
func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

func _on_timer_timeout():
	collision.call_deferred("set","disabled", false)
