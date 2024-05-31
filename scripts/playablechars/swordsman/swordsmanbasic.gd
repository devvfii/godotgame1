extends AnimatedSprite2D

@export var player : CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var hitbox1 = $HitBox1
@onready var hitbox2 = $HitBox2
@onready var cooldown = $Cooldown

var status := true

var direction : Vector2
var attack_object1 := Attack.new()
var attack_object2 := Attack.new()

func _ready():
	attack_object1.base_damage = 40
	attack_object2.base_damage = 50
	
	hitbox1.load_attack(attack_object1)
	hitbox2.load_attack(attack_object2)
	
func activate(aim_direction):
	if status:
		direction = aim_direction
		rotation = aim_direction.angle() + PI/2
		animation_player.play("basic")
		visible = true
		status = false
		cooldown.start()
	else:
		print("attack on cooldown")

func _physics_process(_delta):
	global_position = Vector2(player.global_position.x + direction.x * 15,player.global_position.y + direction.y * 15)

func _on_cooldown_timeout():
	status = true

func _on_animation_player_animation_finished(_anim_name):
	visible = false
