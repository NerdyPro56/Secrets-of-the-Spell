extends Area2D
@onready var textbox: CanvasLayer = $"../Textbox"
@onready var _01_chest_open_1: AudioStreamPlayer = $"01ChestOpen1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	if textbox.current_state == textbox.State.READING:
		return
	else:
		textbox.queue_text("The door is locked.                 ")
		_01_chest_open_1.play()
