extends CharacterBody2D

@export var speed = 150.0
@onready var animations: AnimationPlayer
@onready var previousDirection: String = "Down"

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	move_and_slide()

enum {
	IDLE, MOVING, DYING, DEAD
}

func updateAnimation():
	var direction = previousDirection

	if velocity.x < 0:
		direction = "Left"
	elif velocity.x > 0:
		direction = "Right"
	elif velocity.y < 0:
		direction = "Up"
	elif velocity.y > 0:
		direction = "Down"

	if velocity.length() == 0:
		animations.play("idle" + previousDirection)
	else:
		previousDirection = direction
		animations.play("walk" + direction)

var current_state = IDLE
