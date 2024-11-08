extends Spatial

export(OpenSimplexNoise) var perlin_noise
var block_base = preload("res://BlockBase.tscn")
var block_inst = block_base.instance().get_node("MeshInstance").mesh

var map_gen_intensity = 1 # Used to determine the intensity of the land, higher = more mountains.
var map_size = 40 # The size of the map.

var time = 1

func _generate_perlin_seed():
	# Generate new seed for noise generator.
	randomize()
	perlin_noise.seed = rand_range(0, 1000000)

func _generate_blocks():
	# Get x and y coordinates for map.
	for x in range(-map_size, map_size, 1):
		for z in range(-map_size, map_size, 1):
			# Instance new block and use the size of the block for the translation value.
			var new_block = block_base.instance()
			
			# Generate perlin noise values for each block based on the iteration and the value of the perlin noise at the x, y (z) coordinates.
			var perlin_value = perlin_noise.get_noise_2d(x * block_inst.size.x + time, z * block_inst.size.z)
			var vertical_offset = round(perlin_value * new_block.get_node("MeshInstance").mesh.size.y * map_gen_intensity)
			
			# Get final translation for block.
			# x and z translations are set so each block maintains a distance from eachother based on the size.
			# y translation is the vertical offset multipled by the block's y size to ensure that each block aligns to the 3d grid.
			new_block.translation = Vector3(x * block_inst.size.x, vertical_offset * block_inst.size.y, z * block_inst.size.z)
			$BlockRoot.add_child(new_block)

func _ready():
	_generate_perlin_seed()
	_generate_blocks()


