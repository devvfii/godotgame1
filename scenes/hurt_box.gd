extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

signal hurt(damage)



func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: 
					collision.call_deferred("set", "disabled", true)
					timer.start()
				1:
					pass
				2:
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt", damage)

func _on_timer_timeout():
	collision.call_deferred("set", "disabled", false)
