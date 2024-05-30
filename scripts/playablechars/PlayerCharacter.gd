extends CharacterBody2D
class_name PlayerCharacter

enum PLAYER_CLASS {SWORDSMAN, DRACONID, SPECIAL}

@export var sprite : AnimatedSprite2D

var player_name : String
var player_class : String
var current_state : State

var input_vector : Vector2 # keyboard movement input
var aim_vector : Vector2 # direction to mouse
	
func face_cursor():
	var mouse_position = get_global_mouse_position()
	aim_vector = global_position.direction_to(mouse_position)
	
	if global_position[0] > mouse_position[0]:
		sprite.flip_h = false
	elif global_position[0] < mouse_position[0]:
		sprite.flip_h = true

func map_input_vector():
	input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	input_vector = input_vector.normalized()
	

func basic_attack():
	pass
	
func special_attack():
	pass

func ultimate_attack():
	pass

func dodge():
	pass
	
func _input(event):
	# keyboard events
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
		if Input.is_action_just_pressed("roll") and current_state.state_name == "Idle" and input_vector != Vector2.ZERO:
			dodge()
	
	# mouse events
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("attack") and current_state.state_name == "Idle":
			basic_attack()
		if Input.is_action_just_pressed("skill") and current_state.state_name == "Idle":
			special_attack()
