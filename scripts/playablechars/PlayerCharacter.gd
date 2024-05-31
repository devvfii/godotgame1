extends CharacterBody2D
class_name PlayerCharacter

enum PLAYER_CLASS {SWORDSMAN, DRACONID, SPECIAL}

@export var sprite : Sprite2D

@onready var state_machine = $"State Machine"
@onready var hurtbox = $HurtBox
@onready var health = $HealthComponent

var player_name : String
var player_class : String

var current_state : State
var hit_processed := false

var input_vector : Vector2 # keyboard movement input
var aim_vector : Vector2 # direction to mouse
var knock_vector : Vector2 # knockback
var roll_vector : Vector2 # last input vector before roll

var speed := 120.0

func face_cursor():
	var mouse_position = get_global_mouse_position()
	aim_vector = global_position.direction_to(mouse_position)
	
	if global_position[0] < mouse_position[0]:
		sprite.flip_h = false
	elif global_position[0] > mouse_position[0]:
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
	
func die():
	print("you died")
	sprite.visible = false
	
func _physics_process(_delta):
	face_cursor()
	map_input_vector()
	current_state = state_machine.current_state
	
	match current_state.getState():
		"Idle":
			velocity = input_vector * speed
		"Attacking":
			velocity = input_vector * speed
		"Hurt":
			velocity = input_vector * speed
		"Rolling":
			velocity = roll_vector * speed
	move_and_slide()

func _input(event):
	# keyboard events
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
		if Input.is_action_just_pressed("roll") and current_state.state_name == "Idle" and input_vector != Vector2.ZERO:
			state_machine.current_state.transition_to("Rolling")
			dodge()
	
	# mouse events
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("attack") and current_state.state_name == "Idle":
			state_machine.current_state.transition_to("Attacking")
			basic_attack()
		if Input.is_action_just_pressed("skill") and current_state.state_name == "Idle":
			special_attack()
