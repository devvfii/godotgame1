extends CharacterBody2D

class_name Slime

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var state_machine = $"State Machine"

const my_scene: PackedScene = preload("res://scenes/slime.tscn")

var hp: float
var speed: float
var baseatk: float
var target: CharacterBody2D

static func new_enemy(target: CharacterBody2D, hp := 100.0, speed := 60.0, baseatk := 10) -> Slime:
	var new_enemy: Slime = my_scene.instantiate()
	new_enemy.hp = hp
	new_enemy.speed = speed
	new_enemy.baseatk = baseatk
	new_enemy.target = target
	return new_enemy
	
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	match state_machine.current_state.getState():
		"Idle":
			animation_player.play("idle")
		"Follow":
			animation_player.play("attack")
		
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()

