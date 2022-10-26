extends "res://Script/Controller/Matriks.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var m_width = 3
var m_height = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init(ci: CanvasItem).(ci):
	pass

# LINGKARAN
func lingkaran(x_center, y_center, radius, color):
	var x = 0
	var y = radius
	var p = 1 - radius
	
	lingkaran_plot_points(x_center, y_center, x, y, color)
	
	while x < y:
		x += 1
		if p < 0:
			p += 2 * x + 1
		else:
			y -= 1
			p += 2 * (x - y) + 1
		
		lingkaran_plot_points(x_center, y_center, x, y, color)


# SETENGAH LINGAKARAN
func lingkaran_half(x_center, y_center, radius, color):
	var x = 0
	var y = radius
	var p = 1 - radius
	
	lingkaran_plot_points(x_center, y_center, x, y, color)
	
	while x < y:
		x += 1
		if p < 0:
			p += 2 * x + 1
		else:
			y -= 1
			p += 2 * (x - y) + 1
		
		lingkaran_plot_points_half(x_center, y_center, x, y, color)


# TRANSLASI LINGKARAN		
func lingkaran_translate(x_center, y_center, radius, color, tx, ty):
	var matrix = init_matrix(m_width, m_height)
	matrix_identity(matrix)
	
	var x = 0
	var y = radius
	var p = 1 - radius
	
	# Translation
	matrix[0][2] = x_center
	matrix[1][2] = y_center
	matrix = translate(matrix, tx, ty)
	
	lingkaran_plot_points(matrix[0][2], matrix[1][2], x, y, color)
	
	while x < y:
		x += 1
		if p < 0:
			p += 2 * x + 1
		else:
			y -= 1
			p += 2 * (x - y) + 1
		
		lingkaran_plot_points(matrix[0][2], matrix[1][2], x, y, color)


func lingkaran_plot_points(x_center, y_center, x, y, color):
	put_pixel(x_center+x, y_center+y, color)
	put_pixel(x_center-x, y_center+y, color)
	put_pixel(x_center+x, y_center-y, color)
	put_pixel(x_center-x, y_center-y, color)
	put_pixel(x_center+y, y_center+x, color)
	put_pixel(x_center-y, y_center+x, color)
	put_pixel(x_center+y, y_center-x, color)
	put_pixel(x_center-y, y_center-x, color)


func lingkaran_plot_points_half(x_center, y_center, x, y, color):
	put_pixel(x_center+x, y_center-y, color)
	put_pixel(x_center-x, y_center-y, color)
	put_pixel(x_center+y, y_center-x, color)
	put_pixel(x_center-y, y_center-x, color)


# ELLIPS
func ellips(xCenter, yCenter, Rx, Ry, color):
	var Rx2 = Rx*Rx
	var Ry2 = Ry*Ry
	var twoRx2 = 2*Rx2
	var twoRy2 = 2*Ry2
	var p
	var x = 0
	var y = Ry
	var px = 0
	var py = twoRx2*y
	
	ellips_plot_points(xCenter, yCenter, x, y, color)
	
	# Region 1
	p = round(Ry2 - (Rx2*Ry) + (0.25 * Rx2))
	while (px < py):
		x += 1
		px += twoRy2
		if (p < 0):
			p += Ry2 + px
		else:
			y -= 1
			py -= twoRx2
			p += Ry2 + px - py
		ellips_plot_points(xCenter, yCenter, x, y, color)
		
	# Region 2
	p = round(Ry2*(x+0.5)*(x+0.5) + Rx2*(y-1)*(y-1) - Rx2*Ry2)
	while (y > 0):
		y -= 1
		py -= twoRx2
		if (p > 0):
			p += Rx2 - py
		else :
			x += 1
			px += twoRy2
			p += Rx2 - py + px
		ellips_plot_points(xCenter, yCenter, x, y, color)
	

# TRANSLASI ELLIPS	
func ellips_translate(xCenter, yCenter, Rx, Ry, color, tx, ty):
	var matrix_c = init_matrix(m_width, m_height)
	matrix_identity(matrix_c)
	
	var Rx2 = Rx*Rx
	var Ry2 = Ry*Ry
	var twoRx2 = 2*Rx2
	var twoRy2 = 2*Ry2
	var p
	var x = 0
	var y = Ry
	var px = 0
	var py = twoRx2*y
	
	# Translation
	matrix_c[0][2] = xCenter
	matrix_c[1][2] = yCenter
	matrix_c = translate(matrix_c, tx, ty)
	
	ellips_plot_points(matrix_c[0][2], matrix_c[1][2], x, y, color)
	
	# Region 1
	p = round(Ry2 - (Rx2*Ry) + (0.25 * Rx2))
	while (px < py):
		x += 1
		px += twoRy2
		if (p < 0):
			p += Ry2 + px
		else:
			y -= 1
			py -= twoRx2
			p += Ry2 + px - py
		
		ellips_plot_points(matrix_c[0][2], matrix_c[1][2], x, y, color)
		
	# Region 2
	p = round(Ry2*(x+0.5)*(x+0.5) + Rx2*(y-1)*(y-1) - Rx2*Ry2)
	while (y > 0):
		y -= 1
		py -= twoRx2
		if (p > 0):
			p += Rx2 - py
		else :
			x += 1
			px += twoRy2
			p += Rx2 - py + px
		
		ellips_plot_points(matrix_c[0][2], matrix_c[1][2], x, y, color)


# ROTASI ELLIPS		
func ellips_rotate(xCenter, yCenter, Rx, Ry, color, degree, refpt):
	var Rx2 = Rx*Rx
	var Ry2 = Ry*Ry
	var twoRx2 = 2*Rx2
	var twoRy2 = 2*Ry2
	var p
	var x = 0
	var y = Ry
	var px = 0
	var py = twoRx2*y
	
	ellips_plot_points_rotate(xCenter, yCenter, x, y, color, degree, refpt)
	
	# Region 1
	p = round(Ry2 - (Rx2*Ry) + (0.25 * Rx2))
	while (px < py):
		x += 1
		px += twoRy2
		if (p < 0):
			p += Ry2 + px
		else:
			y -= 1
			py -= twoRx2
			p += Ry2 + px - py
		ellips_plot_points_rotate(xCenter, yCenter, x, y, color, degree, refpt)
		
	# Region 2
	p = round(Ry2*(x+0.5)*(x+0.5) + Rx2*(y-1)*(y-1) - Rx2*Ry2)
	while (y > 0):
		y -= 1
		py -= twoRx2
		if (p > 0):
			p += Rx2 - py
		else :
			x += 1
			px += twoRy2
			p += Rx2 - py + px
		ellips_plot_points_rotate(xCenter, yCenter, x, y, color, degree, refpt)
		

func ellips_plot_points(xCenter, yCenter, x, y, color):
	put_pixel(xCenter + x, yCenter + y, color)
	put_pixel(xCenter - x, yCenter + y, color)
	put_pixel(xCenter + x, yCenter - y, color)
	put_pixel(xCenter - x, yCenter - y, color)


func ellips_plot_points_rotate(xCenter, yCenter, x, y, color, degree, refpt):
	var matrix = init_matrix(m_width, m_height)
	matrix_identity(matrix)
	
	# Rotate 1
	matrix[0][2] = xCenter + x
	matrix[1][2] = yCenter + y
	matrix = rotate(matrix, degree, Vector2(refpt.x,refpt.y))
	put_pixel(matrix[0][2], matrix[1][2], color)
	
	# Rotate 2
	matrix[0][2] = xCenter - x
	matrix[1][2] = yCenter + y
	matrix = rotate(matrix, degree, Vector2(refpt.x,refpt.y))
	put_pixel(matrix[0][2], matrix[1][2], color)
	
	# Rotate 3
	matrix[0][2] = xCenter + x
	matrix[1][2] = yCenter - y
	matrix = rotate(matrix, degree, Vector2(refpt.x,refpt.y))
	put_pixel(matrix[0][2], matrix[1][2], color)
	
	# Rotate 4
	matrix[0][2] = xCenter - x
	matrix[1][2] = yCenter - y
	matrix = rotate(matrix, degree, Vector2(refpt.x,refpt.y))
	put_pixel(matrix[0][2], matrix[1][2], color)


# SEGI BANYAK
func segi_banyak(radius, side, center, theta, color):
	var x = []
	var y = []
	var pi = 3.14
	theta = theta / side
	for i in side:
		x.append(radius * cos(2*pi*(i+1)/side + theta) + center.x)
		y.append(radius * sin(2*pi*(i+1)/side + theta) + center.y)
		
	for i in side:
		if i == side - 1:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[0],y[0]), color, 'thin')
		else:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[i+1],y[i+1]), color, 'thin')


# TRANSLASI SEGI BANYAK
func segi_banyak_translate(radius, side, center, theta, color, tx, ty):
	var matrix = init_matrix(m_width, m_height)
	matrix_identity(matrix)
	
	var x = []
	var y = []
	var pi = 3.14
	theta = theta / side
	for i in side:
		x.append(radius * cos(2*pi*(i+1)/side + theta) + center.x)
		y.append(radius * sin(2*pi*(i+1)/side + theta) + center.y)
		
	for i in side:
		# Translation Process
		matrix[0][2] = x[i]
		matrix[1][2] = y[i]
		matrix = translate(matrix, tx, ty)
		x[i] = matrix[0][2]
		y[i] = matrix[1][2]
		
	for i in side:
		if i == side - 1:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[0],y[0]), color, 'thin')
		else:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[i+1],y[i+1]), color, 'thin')


# SCALE SEGI BANYAK			
func segi_banyak_scale(radius, side, center, theta, color, sx, sy, refpt):
	var matrix = init_matrix(m_width, m_height)
	matrix_identity(matrix)
	
	var x = []
	var y = []
	var pi = 3.14
	theta = theta / side
	for i in side:
		x.append(radius * cos(2*pi*(i+1)/side + theta) + center.x)
		y.append(radius * sin(2*pi*(i+1)/side + theta) + center.y)
		
	for i in side:
		# Scalation Process
		matrix[0][2] = x[i]
		matrix[1][2] = y[i]
		matrix = scale(matrix, sx, sy, refpt)
		x[i] = matrix[0][2]
		y[i] = matrix[1][2]
		
	for i in side:
		if i == side - 1:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[0],y[0]), color, 'thin')
		else:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[i+1],y[i+1]), color, 'thin')


# ROTASI SEGI BANYAK
func segi_banyak_rotate(radius, side, center, theta, color, degree, refpt):
	var matrix = init_matrix(m_width, m_height)
	matrix_identity(matrix)
	
	var x = []
	var y = []
	var pi = 3.14
	theta = theta / side
	for i in side:
		x.append(radius * cos(2*pi*(i+1)/side + theta) + center.x)
		y.append(radius * sin(2*pi*(i+1)/side + theta) + center.y)
		
	for i in side:
		# Rotation Process
		matrix[0][2] = x[i]
		matrix[1][2] = y[i]
		matrix = rotate(matrix, degree, refpt)
		x[i] = matrix[0][2]
		y[i] = matrix[1][2]
		
	for i in side:
		if i == side - 1:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[0],y[0]), color, 'thin')
		else:
			lineDDA(Vector2(x[i],y[i]), Vector2(x[i+1],y[i+1]), color, 'thin')


# TRANSLASI
func translate(matrix, tx, ty):
	var newM = init_matrix(m_width, m_height)
	matrix_identity(newM)
	
	newM[0][2] = tx
	newM[1][2] = ty
	
	return matrix_multiplication(newM, matrix)


# SCALE
func scale(matrix, sx, sy, refpt):
	var newM = init_matrix(m_width, m_height)
	matrix_identity(newM)
	
	newM[0][0] = sx
	newM[0][2] = (1 - sx) * refpt.x
	newM[1][1] = sy
	newM[1][2] = (1 - sy) * refpt.y
	
	return matrix_multiplication(newM, matrix)
	

# ROTASI
func rotate(matrix, degree, refpt):
	var newM = init_matrix(m_width, m_height)
	matrix_identity(newM)
	
	var radian = deg2rad(degree)
	newM[0][0] = cos(radian)
	newM[0][1] = -sin(radian)
	newM[0][2] = refpt.x * (1 - cos(radian)) + refpt.y * sin(radian)
	
	newM[1][0] = sin(radian)
	newM[1][1] = cos(radian)
	newM[1][2] = refpt.y * (1 - cos(radian)) - refpt.x * sin(radian)
	
	return matrix_multiplication(newM, matrix)



# MATAHARI
func Matahari(midpoint, radius, sudut):
	var radius_segibanyak = 10
	#segi_banyak(radius+radius_segibanyak, 10, midpoint, 0.0, Color('#fcf803'))
	segi_banyak_rotate(radius+radius_segibanyak, 10, midpoint, 0.0, Color('#fcf803'), sudut, midpoint)
	while radius_segibanyak >= -5:
		radius_segibanyak -= 1
		#segi_banyak(radius+radius_segibanyak, 10, midpoint, 0.0, Color('#fcf803'))
		segi_banyak_rotate(radius+radius_segibanyak, 10, midpoint, 0.0, Color('#fcf803'), sudut, midpoint)
	
	lingkaran(midpoint.x, midpoint.y, radius, Color('#fa5705'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#fa5705'))


# MERKURIUS
func Merkurius(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#b0a29b'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#b0a29b'))


# VENUS
func Venus(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#bd6304'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#bd6304'))


# BUMI
func Bumi(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#6a80f7'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#6a80f7'))


# BULAN
func Bulan(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#f7e26a'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#f7e26a'))
	

# MARS
func Mars(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#fca74c'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#fca74c'))


# JUPITER
func Jupiter(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#9c5902'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#9c5902'))


# SATURNUS
func Saturnus(midpoint, radius):
	var radius_half = radius
	var radius_x = radius+15
	var radius_y = radius-10
	lingkaran(midpoint.x, midpoint.y, radius, Color('#ffe2bd'))
	
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#ffe2bd'))
	
	ellips(midpoint.x, midpoint.y, radius_x, radius_y, Color('#ffffff')) 
	ellips(midpoint.x, midpoint.y, radius_x-1, radius_y-1, Color('#ffffff')) 
	ellips(midpoint.x, midpoint.y, radius_x-2, radius_y-2, Color('#ffffff')) 
	ellips(midpoint.x, midpoint.y, radius_x-3, radius_y-3, Color('#a6a2a2')) 
	ellips(midpoint.x, midpoint.y, radius_x-4, radius_y-4, Color('#a6a2a2'))
	ellips(midpoint.x, midpoint.y, radius_x-5, radius_y-5, Color('#ffffff'))
	ellips(midpoint.x, midpoint.y, radius_x-6, radius_y-6, Color('#ffffff'))
	
	lingkaran_half(midpoint.x, midpoint.y, radius, Color('#ffe2bd'))
	while radius_half >= 0:
		radius_half -= 1
		lingkaran_half(midpoint.x, midpoint.y, radius_half, Color('#ffe2bd'))


# URANUS
func Uranus(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#1c2f59'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#1c2f59'))


# NEPTUNUS
func Neptunus(midpoint, radius):
	lingkaran(midpoint.x, midpoint.y, radius, Color('#091736'))
	while radius >= 0:
		radius -= 1
		lingkaran(midpoint.x, midpoint.y, radius, Color('#091736'))


# ORBIT_DALAM
func Orbit_Dalam(midpoint,radius):
	while radius <= 175  :
		lingkaran(midpoint.x, midpoint.y, radius, Color('#ffffff'))
		radius += 25


# ORBIT_LUAR
func Orbit_Luar(midpoint,radius):
	while radius <= 300 :
		lingkaran(midpoint.x, midpoint.y, radius, Color('#ffffff'))
		radius += 25

		
