extends PlayerCharacter
class_name Swordsman

@onready var swordsman_basic = $AttackObjects/SwordsmanBasic

func _ready():
	current_state = state_machine.current_state
	
func basic_attack():
	swordsman_basic.activate(aim_vector)

func dodge():
	roll_vector = input_vector

func _on_hurt_box_was_hurt(attack):
	if not hit_processed:
		hit_processed = true
		state_machine.current_state.transition_to("hurt")
		health.damage(attack)
