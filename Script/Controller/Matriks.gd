extends "res://Script/Controller/func_gen.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var m_width_baru = 3
var m_height_baru = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init(ci: CanvasItem).(ci):
	pass

func init_matrix(width, height, default = 0):
	var newArr = []

	for y in range(height):
		newArr.append([])
		newArr[y].resize(width)

		for x in range(width):
			newArr[y][x] = default

	return newArr
	
func matrix_identity(matrix):
	var value
	
	for i in range(m_height_baru):
		for j in range(m_width_baru):
			if(i == j):
				value = 1
			else:
				value = 0
			matrix[i][j] = value
			
func print_matrix(matrix):
	for i in range(m_height_baru):
		for j in range(m_width_baru):
			print(matrix[i][j])
	
func matrix_addition(matrix1, matrix2):
	var newMatrix = init_matrix(m_width_baru, m_height_baru)
	
	for i in range(m_height_baru):
		for j in range(m_width_baru):
			newMatrix[i][j] = matrix1[i][j] + matrix2[i][j]
			
	return newMatrix

func matrix_subtraction(matrix1, matrix2):
	var newMatrix = init_matrix(m_width_baru, m_height_baru)
	
	for i in range(m_height_baru):
		for j in range(m_width_baru):
			newMatrix[i][j] = matrix1[i][j] - matrix2[i][j]
			
	return newMatrix
	
func matrix_multiplication(matrix1, matrix2):
	var newMatrix = init_matrix(m_width_baru, m_height_baru)
	
	for i in range(m_height_baru):
		for j in range(m_width_baru):
			newMatrix[i][j] = matrix1[i][0]*matrix2[0][j] + matrix1[i][1]*matrix2[1][j] + matrix1[i][2]*matrix2[2][j]
			
	return newMatrix
