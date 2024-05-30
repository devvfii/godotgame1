extends Area2D
class_name HitBox

@export var damage : int

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

var attackObj : Attack

func tempdisable():
	collision.call_deferred("set","disabled", true)
	timer.start()
	
func loadAttack(attack: Attack):
	attackObj = attack
	damage = attackObj.basedamage

func _on_timer_timeout():
	collision.call_deferred("set","disabled", false)
