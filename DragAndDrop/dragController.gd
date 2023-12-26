extends Node

signal released(pos)

var parent
export var ReturnToStart : bool = true

var pos_locked
var touch_pos
var entered = false
var init_pos : Vector2

func _ready():
	parent = self.get_parent()
	if not parent is Control:
		printerr("Error: parent is not a control node")
	else:
		init_pos = parent.rect_position
		parent.connect("gui_input", self, "_on_gui_input")

func _on_gui_input(event):
	if parent is Control:
		if event is InputEventScreenDrag:
			if !pos_locked:
				if touch_pos!=Vector2.ZERO:
					parent.rect_global_position += (event.position-touch_pos)*self.rect_position

				
		if event is InputEventScreenTouch:
			touch_pos = event.position
			
			if !event.pressed:
				emit_signal("released", parent.rect_position)
				if !entered:
					if ReturnToStart:
						parent.rect_position = init_pos
