extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var used_cells = self.get_used_cells()
	