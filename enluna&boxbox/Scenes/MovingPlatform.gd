extends Node2D

export var platformLen = "2"

func _ready():
	for node in get_children():
		if node.get_name() != platformLen:
			remove_child(node)
