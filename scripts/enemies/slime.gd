extends CharacterBody2D

class_name Slime

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var state_machine = $"State Machine"
@onready var health = $HealthComponent
@onready var hitbox = $HitBox

var speed: float
var baseatk: float
var target: CharacterBody2D
	
func _ready():
	var attack = Attack.new()
	attack.base_damage = 40.0
	hitbox.load_attack(attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	match state_machine.current_state.getState():
		"Idle":
			animation_player.play("idle")
		"Follow":
			animation_player.play("attack")
		"Hurt":
			animation_player.play("hurt")
		
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hurt":
		state_machine.on_child_transition(state_machine.current_state, "follow")


func _on_hurt_box_was_hurt(attack):
	state_machine.on_child_transition(state_machine.current_state, "hurt")
	health.damage(attack)
