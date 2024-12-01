extends Node
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var wizard = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("hurt"):
		if !wizard:
			body.hurt(100)
	if body.has_method("hurt_player"):
		body.hurt_player(10)

func _on_timer_timeout() -> void:
	animation_player.play("shoot")
