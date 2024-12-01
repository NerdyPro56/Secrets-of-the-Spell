extends Node2D
@onready var textbox: CanvasLayer = $Textbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.queue_text("WASD to move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
