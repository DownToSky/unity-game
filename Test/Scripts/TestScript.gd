extends Node
var myRoot

var ScreenWidth
var ScreenHeight
const BaseWidth = 144      #base Width of your game
const BaseHeight = 216     #base Height of your game


func _ready():
	myRoot = get_tree().get_root()
	ScreenWidth = OS.get_window_size().x
	ScreenHeight = OS.get_window_size().y
	print("The Screen Size is "+str(OS.get_window_size()))
	
	RenderAdjust()
	
	
	
#############################The Functions#####################################
func RenderAdjust():
	#Get the Maximum Resize value by dividing the width and height of base size from screen size
	var gameResizeW = floor(ScreenWidth/BaseWidth) 
	var gameResizeH = floor(ScreenHeight/BaseHeight) 
	var Resize = 0
	var NewBaseW = 0
	var NewBaseH = 0
	var ScreenOffsetX = 0
	var ScreenOffsetY = 0
	
	print("Base Resize Scale is ("+str(gameResizeW)+","+str(gameResizeH)+")")
	
	
	# get the lowest value from width or height of the Resize
	if (gameResizeW <= gameResizeH):
		Resize = gameResizeW
	else:
		Resize = gameResizeH
	print("Desired Resize Scale is ("+str(Resize)+")")
	
	
	# Multiply the Resize and Base Size to get the Resized value
	NewBaseW = BaseWidth*Resize
	NewBaseH = BaseHeight*Resize
	print("New Resized Base is ("+str(NewBaseW)+","+str(NewBaseH)+")")
	
	#Get the Screen Offset to make the game centered on the Screen
	ScreenOffsetX = floor((ScreenWidth/2) - (NewBaseW/2))
	ScreenOffsetY = floor((ScreenHeight/2) - (NewBaseH/2))
	print("Screen Offset Coordinate is ("+str(ScreenOffsetX)+","+str(ScreenOffsetY)+")")
	
	#Render the Game in True Pixel Perfect
	myRoot.set_render_target_to_screen_rect(Rect2(Vector2(ScreenOffsetX,ScreenOffsetY),Vector2(NewBaseW,NewBaseH)))
	
	pass
