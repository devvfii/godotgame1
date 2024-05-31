extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0
@export var health_component : HealthComponent

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

signal wasHurt(attack: Attack)

func _on_area_entered(area):
	if area is HitBox:
		match HurtBoxType:
			0: 
				collision.call_deferred("set", "disabled", true)
				timer.start()
			1:
				pass
			2:
				if area.has_method("temp_disable"):
					area.tempdisable()
		
		var attack = area.attack_object
		attack.direction = Vector2(cos(area.global_position.angle_to_point(global_position)),sin(area.global_position.angle_to_point(global_position)))
		emit_signal("wasHurt", attack)

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

func _on_timer_timeout():
	collision.call_deferred("set", "disabled", false)
