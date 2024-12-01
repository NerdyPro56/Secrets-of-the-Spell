extends Sprite2D
@onready var player: CharacterBody2D = $"../player"
@onready var textbox: CanvasLayer = $"../Textbox"
@onready var timer: Timer = $Timer
var already = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.name == "player" and !already:
		already = true
		body.cutscene = true
		textbox.queue_text("Thank God!         ")
		textbox.queue_text("You saved me!        ")
		textbox.queue_text("Here take this:           ")
		textbox.queue_text("You will need it in your travels          ")
		timer.start()

func _on_timer_timeout() -> void:
	player.cutscene = false
	player.bow = true
	textbox.queue_text("Press q or right click to use bow                ")
	
