--skin_modifier = $.modifiers[1]

--return the first Skin modifier of a specified single obj
fn fn_get_skin_modifier_1 obj = (
	for m in obj.modifiers do(
		if classof m == Skin then(
			return m
		)
	)
	return undefined
)

--get skin modifier of the object
fn fn_get_skin_modifier obj = (
	return obj.modifiers[#Skin]
)

--return a list of bone indexes which affects a specified vertex
fn fn_get_vertex_bone_id_list skin_modifier vertex_index = (
	bone_count = skinOps.GetVertexWeightCount skin_modifier vertex_index
	bone_list = for i in 1 to bone_count collect(	
		skinOps.GetVertexWeightBoneID skin_modifier vertex_index i
	)
	return bone_list
)

--return a bitarray of bone indexes of a specified vertex
fn fn_get_vertex_bone_id_bitarray skin_modifier vertex_index = (
	bone_bitarray = #{}
	bone_count = skinOps.GetVertexWeightCount skin_modifier vertex_index
	for i in 1 to bone_count do(
		bone_bitarray[skinOps.GetVertexWeightBoneID skin_modifier vertex_index i] = true
	)
	return bone_bitarray
)

--select verts by bone id
fn fn_select_vertex_by_bone_id skin_modifier bone_id = (
	vertex_bitarray = #{}
	disableSceneRedraw()
	vertex_bitarray .count = skinOps.GetNumberVertices skin_modifier
	for i in 1 to vertex_bitarray.count do(
		vert_bone_id_list = fn_get_vertex_bone_id_list skin_modifier i
		if findItem vert_bone_id_list bone_id >0 then(
			vertex_bitarray[i] = true
		)
	)
	enableSceneRedraw()
	skinOps.SelectVertices skin_modifier vertex_bitarray
	completeRedraw()
	return vertex_bitarray
)

--get current skin modifier
fn fn_select_current_obj_and_get_skin_modifier = (

	target_obj = $
	if target_obj == undefined then (
		messagebox "No object selected!"
		return ()
		--to refine
	)
	
	setCommandPanelTaskMode mode:#modify
	
	if target_obj.modifiers[Skin] == undefined then(
		return ()
	)
	modPanel.setCurrentObject $.modifiers[#Skin]
	skin_modifier = target_obj.modifiers[#Skin]	
	return skin_modifier 
)

fn fn_select_vert_by_bone =(
	try(
		if selection.count >1 then (
			messagebox "More than one objects selected!"
		)
		else if selection.count == 0 then(
			messagebox "No object selected!"
		)
		else(
			if classof (modPanel.getCurrentObject())!= Skin then(
				
				print (modPanel.getCurrentObject())
				
				setCommandPanelTaskMode mode:#modify
				modPanel.setCurrentObject $.modifiers[#Skin]
				subobjectLevel = 1
			)
			if subobjectLevel != 1 then(
				subobjectLevel = 1
			)
			vert_array = fn_select_vertex_by_bone_id $.modifiers[#Skin] (skinOps.GetSelectedBone $.modifiers[#Skin])
		)
	)
	catch(
		messagebox ("No bones in Skin modifier currently selected!")
		print (getCurrentException())
	)
)

----------------------------------------------------------------------------------
--test
fn fn_test_vertex = (
	vertex_list = for i in 1 to 146 where ((fn_get_vertex_bone_list (fn_get_skin_modifier $) i ).count>1) collect i
)

--test
fn fn_test_select_vert_by_bone =(
	vert_array = fn_select_vertex_by_bone_id $.modifiers[#Skin] (skinOps.GetSelectedBone $.modifiers[#Skin])
)

--test
fn fn_test_vertex_bone_id_ba = (
	ba = fn_get_vertex_bone_id_bitarray $.modifiers[#Skin] 4
)

--fn_test_vertex_bone_id_ba()
--fn_test_select_vert_by_bone()