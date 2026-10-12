extends CharacterBody2D

@export var speed = 20
@export var endPoint: Marker2D
@export var limit = 0.5
var startPos #Starting Position
var endPos #Ending Position

@onready var animations = $AnimatedSprite2D

func _ready() -> void:
	startPos = position
	endPos = endPoint.global_position

func changeDirection():
	var tempEnd = endPos
	endPos = startPos
	startPos = tempEnd

func updateVelocity(): 
	var moveDir = endPos - position
	if moveDir.length() <= limit:
		changeDirection()
	velocity = moveDir.normalized()*speed


func _physics_process(delta: float) -> void:
	updateVelocity()
	move_and_slide()
	animations.play(name)
