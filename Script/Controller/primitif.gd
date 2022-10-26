extends Node
var windows_height = ProjectSettings.get("display/window/size/height")
var windows_width = ProjectSettings.get("display/window/size/width")
var canvasItem: CanvasItem = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init(ci: CanvasItem):
	canvasItem = ci

func put_pixel(x, y, color):
	canvasItem.draw_primitive(PoolVector2Array([Vector2(x, y)]), PoolColorArray([color]), PoolVector2Array())
	
func line_dda (xa:int, ya:int, xb:int, yb:int, color:Color, tipe:String):
	var dx = xb-xa
	var dy = yb-ya
	var steps
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	
	if (abs(dx) > abs(dy)) : steps = abs(dx)
	else : steps = abs(dy)
	
	xIncrement = dx/steps
	yIncrement = dy/steps
	
	if tipe == "thin":
		for i in steps:
			x += xIncrement 
			y += yIncrement
			put_pixel(round(x), round(y), color)
	
	elif tipe == "bold":
		for i in steps:
			x += xIncrement
			y += yIncrement
			put_pixel(round(x), round(y), color)
			for n in 4:
				if dx > dy:
					put_pixel(x,y+n,color)
				else:
					put_pixel(x+n,y,color)
	
	elif tipe == "dashed":
		var counter = 0
		for i in steps:
			if counter <= 10:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color) 
				counter = counter+1 
			elif (counter > 10) && (counter <= 15):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 15: counter = 0

	elif tipe == "point":
		var counter = 0
		for i in steps:
			if counter == 0:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 3: counter = 0

	elif tipe == "point_dash":
		var counter = 0
		for i in steps:
			if counter == 0:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x += xIncrement
				y += yIncrement
				counter = counter+1
			elif (counter > 3) && (counter <= 13):
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 13) && (counter <= 17):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 17: counter = 0
		
func lineDDA(a,b,color,tipe):
	var dx = b.x-a.x
	var dy = b.y-a.y
	var steps
	var xIncrement
	var yIncrement
	var x = a.x
	var y = a.y
	
	if (abs(dx) > abs(dy)) : steps = abs(dx)
	else : steps = abs(dy)
	
	xIncrement = dx/steps
	yIncrement = dy/steps
	
	if tipe == "thin":
		for i in steps:
			x += xIncrement 
			y += yIncrement
			put_pixel(round(x), round(y), color)
	
	elif tipe == "bold":
		for i in steps:
			x += xIncrement
			y += yIncrement
			put_pixel(round(x), round(y), color)
			for n in 4:
				if dx > dy:
					put_pixel(x,y+n,color)
				else:
					put_pixel(x+n,y,color)
	
	elif tipe == "dashed":
		var counter = 0
		for i in steps:
			if counter <= 10:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 10) && (counter <= 15):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 15: counter = 0

	elif tipe == "point":
		var counter = 0
		for i in steps:
			if counter == 0:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 3: counter = 0


	elif tipe == "point_dash":
		var counter = 0
		for i in steps:
			if counter == 0:
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x += xIncrement
				y += yIncrement
				counter = counter+1
			elif (counter > 3) && (counter <= 13):
				x += xIncrement
				y += yIncrement
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 13) && (counter <= 17):
				x += xIncrement
				y += yIncrement
				counter = counter+1
				if counter == 17: counter = 0
				

func line_bersenham (xa:int, ya:int, xb:int, yb:int, color:Color, tipe):
	var dx = abs(xa - xb)
	var dy = abs(ya - yb)
	var p = 2 * dy - dx
	var twoDy = 2 * dy
	var twoDyDx = 2 * (dy - dx)
	var x
	var y
	var xEnd
	
	#determine which point to use as start, which as end
	if(xa > xb):
		x = xb
		y = yb
		xEnd = xa
	else:
		x = xa
		y = ya
		xEnd = xb

	if tipe == "thin":
		while x < xEnd:
			x = x+1
			if (p < 0):
				p += twoDy
			else :
				y = y+1
				p += twoDyDx
			put_pixel(x,y,color)

	elif tipe == "bold":
		while x < xEnd:
			x = x+1 
			if (p < 0):
				p += twoDy 
			else :
				y = y+1
				p += twoDyDx
			put_pixel(x,y,color)
			for i in 4:
				if dx > dy:
					put_pixel(x,y+i,color)
				else:
					put_pixel(x+i,y,color)

	elif tipe == "dashed":
		var counter = 0
		while x < xEnd:
			if counter <= 10:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 10) && (counter <= 15):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 15: counter = 0

	elif tipe == "point":
		var counter = 0
		while x < xEnd:
			if counter == 0:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 3: counter = 0

	elif tipe == "point_dash":
		var counter = 0
		while x < xEnd:
			if counter == 0:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
			elif (counter > 3) && (counter <= 13):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 13) && (counter <= 17):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 17: counter = 0

func lineBersenham(a,b,color,tipe):
	var dx = abs(a.x-b.x)
	var dy = abs(a.y-b.y)
	var p = 2*dy-dx
	var twoDy = 2*dy
	var twoDyDx = 2*(dy-dx)
	var x 
	var y
	var xEnd
	
	if (a.x > b.x ):
		x = b.x 
		y = b.y
		xEnd = a.x
	else :
		x = a.x
		y = a.y
		xEnd = b.x
	
	if tipe == "thin":
		while x < xEnd:
			x = x+1
			if (p < 0):
				p += twoDy
			else :
				y = y+1
				p += twoDyDx
			put_pixel(x,y,color)

	elif tipe == "bold":
		while x < xEnd:
			x = x+1 
			if (p < 0):
				p += twoDy 
			else :
				y = y+1
				p += twoDyDx
			put_pixel(x,y,color)
			for i in 4:
				if dx > dy:
					put_pixel(x,y+i,color)
				else:
					put_pixel(x+i,y,color)

	elif tipe == "dashed":
		var counter = 0
		while x < xEnd:
			if counter <= 10:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 10) && (counter <= 15):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 15: counter = 0

	elif tipe == "point":
		var counter = 0
		while x < xEnd:
			if counter == 0:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 3: counter = 0

	elif tipe == "point_dash":
		var counter = 0
		while x < xEnd:
			if counter == 0:
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 0) && (counter <= 3):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
			elif (counter > 3) && (counter <= 13):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				put_pixel(x,y,color)
				counter = counter+1
			elif (counter > 13) && (counter <= 17):
				x = x+1
				if (p < 0):
					p += twoDy
				else :
					y = y+1
					p += twoDyDx
				counter = counter+1
				if counter == 17: counter = 0
