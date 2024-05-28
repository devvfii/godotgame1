extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0
@export var damage : int

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

signal hurt(attack: Attack)

func _on_area_entered(area):
	if area is HitBox:
		match HurtBoxType:
			0: 
				collision.call_deferred("set", "disabled", true)
				timer.start()
			1:
				pass
			2:
				if area.has_method("tempdisable"):
					area.tempdisable()
		
		var attack = Attack.new()
		attack.basedamage = damage
		
		emit_signal("hurt", attack)

func _on_timer_timeout():
	collision.call_deferred("set", "disabled", false)
