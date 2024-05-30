extends Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var hitbox = $HitBox/CollisionShape2D

var direction_vector
var isSwinging = false
var start
var speed = 450 * PI / 180
const SWING_FRICTION = 680 * PI / 180

var mainAttack := Attack.new()
var specialAttack := Attack.new()

func _ready():
	hitbox.disabled = true
	
	mainAttack.basedamage = 40

	specialAttack.basedamage = 30

func activate(aim_vector):
	direction_vector = aim_vector
	animation_player.play("dash")
	
func swing(aim_vector):
	direction_vector = aim_vector
	animation_player.play("swing")

func _physics_process(delta):
	if isSwinging:
		start += speed * delta
		speed -= SWING_FRICTION * delta
		rotation = start


func _on_animation_player_animation_started(anim_name):
	if anim_name == "swing":
		start = direction_vector.angle() - 35 * PI / 180
		isSwinging = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swing":
		speed = 450 * PI / 180
		isSwinging = false
