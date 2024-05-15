extends CharacterBody2D

@onready var animated_sprite = $Body
@onready var cursor = $Cursor
@onready var animation_player = $Body/AnimationPlayer
@onready var skill_cd = $Timers/SkillCD
@onready var attack_cd = $Timers/AttackCD
@onready var dash_timer = $Timers/DashTimer
@onready var dash_sword = $AttackObjects/Sword

var speed = 120.0
var hp = 100.0
var mouse_position
var input_vector

const ROLL_FRICTION = 180
var isRolling = false
var roll_vector

var isAttacking = false
var inSkill = false
var isDashing = false
const DASH_FRICTION = 1600
var aim_vector

func _physics_process(delta):
	input_vector = Vector2.ZERO
	mouse_position = get_global_mouse_position()
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	# cursor stuff
	cursoraiming()
	
	if dash_sword.visible:
		dash_sword.position = position
	
	if isRolling:
		speed -= ROLL_FRICTION * delta
		velocity = roll_vector * speed
	elif isDashing:
		speed -= DASH_FRICTION * delta
		velocity = aim_vector * speed
	elif input_vector == Vector2.ZERO:
		animation_player.play("idle")
		velocity = input_vector * speed
	else:
		animation_player.play("run")
		velocity = input_vector * speed
	move_and_slide()
	
func _input(event):
	# keyboard events
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			print("T was pressed")
		if Input.is_action_just_pressed("roll") and not isAttacking and not isDashing and not isRolling and input_vector != Vector2.ZERO:
			actionRoll()
	
	# mouse events
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("attack") and not isRolling and not isAttacking:
			aim_vector = position.direction_to(mouse_position)
			dash_sword.position = position
			dash_sword.rotation = aim_vector.angle() + PI/4
			attack()
		if Input.is_action_just_pressed("skill") and not isRolling and not inSkill and not isAttacking:
			aim_vector = position.direction_to(mouse_position)
			dash_sword.position = position
			dash_sword.rotation = aim_vector.angle() + PI/4
			castSkill()

func cursoraiming():
	cursor.look_at(mouse_position)
	cursor.rotate(PI/2)
	
	var mouse_distance = position.distance_to(mouse_position)
	
	if abs(mouse_distance) > 35:
		cursor.offset = Vector2(0, -35)
	elif abs(mouse_distance) < 5:
		cursor.offset = Vector2(0, -5)
	else:
		cursor.offset = Vector2(0, -abs(mouse_distance))
	
	if mouse_position[0] > position[0]:
		animated_sprite.flip_h = false
	elif mouse_position[0] < position[0]:
		animated_sprite.flip_h = true

func actionRoll():
	roll_vector = input_vector
	isRolling = true
	animation_player.play("roll")
	speed *= 2.2
	
func castSkill():
	skill_cd.one_shot = true
	inSkill = true
	skill_cd.start(2)
	
	dash_sword.activate(aim_vector)
	dash_timer.one_shot = true
	isDashing = true
	dash_timer.start(0.3)
	speed *= 5

func attack():
	attack_cd.one_shot = true
	isAttacking = true
	attack_cd.start(0.5)
	
	dash_sword.swing(aim_vector)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "roll":
		isRolling = false
		speed = 120

func _on_skill_cd_timeout():
	inSkill = false
	print("skill ready")

func _on_attack_cd_timeout():
	isAttacking = false
	print("attack ready")

func _on_dash_timer_timeout():
	isDashing = false
	speed = 120


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
