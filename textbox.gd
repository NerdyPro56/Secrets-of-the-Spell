extends CanvasLayer

const CHAR_READ_RATE = 0.05  # Delay between each character reveal

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var start_symbol: Label = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol: Label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label: Label = $TextboxContainer/MarginContainer/HBoxContainer/Label2
@onready var reveal_timer: Timer = $RevealTimer
@onready var end_timer: Timer = $EndTimer
var end = false
enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var current_text = ""
var char_index = 0

func _ready():
	print("Starting state: State.READY")
	hide_textbox()

func _process(delta):
	match current_state:
		State.READY:
			if text_queue.size() > 0:
				display_text()
		State.FINISHED:
			if Input.is_action_just_pressed("text") || end:
				change_state(State.READY)
				hide_textbox()
				end_timer.stop()  # Stop the timer if manually skipped

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	current_text = text_queue.pop_front()
	label.text = ""
	char_index = 0
	change_state(State.READING)
	show_textbox()
	reveal_timer.start(CHAR_READ_RATE)

func _on_RevealTimer_timeout():
	if char_index < current_text.length():
		label.text += current_text[char_index]
		char_index += 1
	else:
		end_symbol.text = "v"
		reveal_timer.stop()
		change_state(State.FINISHED)
		end_timer.start()  # Start end_timer when finished displaying text

# Function called when end_timer times out
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")


func _on_end_timer_timeout() -> void:
	end = true
func is_textbox_finished() -> bool:
	return (end == true and text_queue.size() <= 0)
