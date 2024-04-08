default_slot_bone_str = "$B_Hat, $B_LH, $B_RH, $B_LC, $B_RC, $B_Spine2, $B_Long, $B_Spine, $B_LP, $B_RP"

--extract nodes from given command str and remove invalid ones then return an array of their names
fn fn_process_slot_bone_str slot_bone_str:default_slot_bone_str = (
	aquire_nodes_command_str = "#("+default_slot_bone_str+")"
	slot_nodes = execute aquire_nodes_command_str
	ideal_slot_num = slot_nodes.count
	slot_nodes = makeUniqueArray slot_nodes
	undefined_pos = findItem slot_nodes undefined
	if undefined_pos !=0 then(
		slot_nodes = deleteItem slot_nodes undefined_pos
	)
	print slot_nodes
	found_num = slot_nodes.count
	format "% objects not found\n" (ideal_slot_num - found_num)
	names_arr = for sl in slot_nodes collect sl.name
	return names_arr
)

--return a bitarray of bone ids which are named after the given name string
fn fn_get_bone_id_bitarray_by_bone_name skin_modifier name_str = (
	bone_count = skinOps.GetNumberBones skin_modifier
	bone_bitarray = #{}
	for i in 1 to bone_count do(
		bone_id = skinOps.GetBoneIDByListID skin_modifier i
		bone_name = skinOps.GetBoneName skin_modifier bone_id 0
		if name_str == bone_name then(
			bone_bitarray[bone_id] = true
		)
	)
	return bone_bitarray
)

--Call the functions above.Directly convert a command string containing the slot bones into a bitarray of bone ids.  
fn fn_get_joined_bone_id_bitarray_by_slot_bone_str skin_modifier slot_bone_str:default_slot_bone_str = (
	names_arr = fn_process_slot_bone_str slot_bone_str:default_slot_bone_str
	joined_bitarray = #{}
	for name_str in names_arr do(
		bone_bitarray = fn_get_bone_id_bitarray_by_bone_name skin_modifier name_str
		joined_bitarray = join joined_bitarray bone_bitarray
	)
	return joined_bitarray
)

--set the weight of bone in bitarray to all vertices 0
fn fn_set_weight_0_by_bone_bitarray skin_modifier bone_bitarray = (
	bone_array = bone_bitarray as array
	print bone_array.count
	weight_array = for bn in bone_array collect 0
	vertex_num = skinOps.GetNumberVertices skin_modifier
	disableSceneRedraw()
	for i in 1 to vertex_num do(
		skinOps.SetVertexWeights skin_modifier i bone_array weight_array
	)
	enableSceneRedraw()
	completeRedraw()
)

---------------------------------------------------------------------------------
fn fn_test_get_ba_by_bone_name = (
	print(fn_get_bone_id_bitarray_by_bone_name $.modifiers[#Skin] "B_RP")
)

fn fn_test_select_slot = (
	fn_process_slot_bone_str()
)

fn fn_test_replac_weight = (
	ba = fn_get_bone_id_bitarray_by_bone_name $.modifiers[#Skin] "B_Long"
	fn_set_weight_0_by_bone_bitarray $.modifiers[#Skin] ba
)

fn fn_test_auto_set_0 = (
	ba = fn_get_joined_bone_id_bitarray_by_slot_bone_str $.modifiers[#Skin]
	fn_set_weight_0_by_bone_bitarray $.modifiers[#Skin] ba
)

fn fn_test_join_bitary = (
	print (fn_get_joined_bone_id_bitarray_by_slot_bone_str $.modifiers[#Skin])
)

--fn_test_auto_set_0()

--fn_test_join_bitary()
--fn_test_replac_weight()

--fn_test_get_ba_by_bone_name()

--fn_test_select_slot()