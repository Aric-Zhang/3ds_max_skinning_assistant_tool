--relpace old str with new str in original str
fn fn_replace_all ori_str old_str new_str = (
	if findString new_str old_str != undefined then(
		substring_array = #(ori_str)
		last_ele_str_pos = findString substring_array[substring_array.count] old_str
		while last_ele_str_pos != undefined do(
			if last_ele_str_pos == 1 then(
				sub_str = subString substring_array[substring_array.count] (old_str.count+1) (-1)
				substring_array[substring_array.count] = ""
				append substring_array sub_str
			)
			else(
				sub_str_1 = subString (substring_array[substring_array.count]) 1 (last_ele_str_pos-1)
				sub_str_2 = subString substring_array[substring_array.count] (last_ele_str_pos + old_str.count) (-1)
				substring_array[substring_array.count] = sub_str_1
				append substring_array sub_str_2
			)
			last_ele_str_pos = findString substring_array[substring_array.count] old_str
		)
		print substring_array
		res_str = substring_array[1]
		for i in 2 to substring_array.count do(
			res_str = append res_str new_str
			res_str = append res_str substring_array[i]
		)
		return res_str
	)
	else(
		str_pos = findString ori_str old_str
		if old_str == "" do(
			return ori_str
		)
		while str_pos != undefined do(
			ori_str = replace ori_str str_pos old_str.count new_str
			str_pos = findString ori_str old_str
		)
		return ori_str
	)
)

--process command string which contains objects to select,returns an array of scene objects
fn fn_process_selection_command_str command_str = (
	if findString command_str "select" == 1 then(
		command_str = substring command_str 7 -1
	)
	arr = #()
	try( 
		arr = execute command_str
	)catch(
		print (getCurrentException())
	)
	if classof arr!=array then(
		print "result is not an array type."
		print (classof arr)
		messagebox "result is not an array type."
		return #()
	)
	ideal_object_num = arr.count
	arr = makeUniqueArray arr
	undefined_pos = findItem arr undefined
	if undefined_pos !=0 then(
		arr = deleteItem arr undefined_pos
	)
	found_num = arr.count
	format "% objects not found\n" (ideal_object_num - found_num)
	return arr
)

--merge several command results into one
fn fn_sum_up_selection_by_command_ary command_list = (
	joined_array = #()
	for command_str in command_list do(
		arr = fn_process_selection_command_str command_str
		join joined_array arr
	)
	return joined_array
)

--return the node's name of added bones
fn fn_get_added_bone_names skin_modifier = (
	names_array = #()
	bone_count = SkinOps.GetNumberBones skin_modifier 
	format "number_bones:%" bone_count
	for i in 1 to bone_count do(
		bone_id = skinOps.GetBoneIDByListID skin_modifier i
		append names_array (skinOps.GetBoneName skin_modifier bone_id 0)
	)
	return names_array
)

--add bones in the collection to target skin modifier
fn fn_add_bone_from_collection skin_modifier bone_collection check_unique:true = (
	if check_unique then(
		names_array = fn_get_added_bone_names skin_modifier
		for bn in bone_collection do(
			if findItem	names_array bn.name!=0 then(
				print (bn.name + " Duplication detected, already ignored.")
			)
			else(
				skinOps.addbone skin_modifier bn 0 
			)
		)
	)
	else(
		for bn in bone_collection do(
			skinOps.addbone skin_modifier bn 0 
		)
	)
	completeRedraw()
)

-----------------------------------------------------------------------------
--the structure which defines skin and bone preset
if obj_bone_preset == undefined then(
	struct obj_bone_preset (obj_name,command_str)
)

m2_body = obj_bone_preset obj_name:"M2_*_body" command_str:"select #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403, $ADD_L401, $ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 Spine1', $'Bip01 Spine2', $B_Long, $B_Spine2, $B_RC, $B_LC, $'Bip01 Neck', $'Bip01 Neck1', $'Bip01 Head', $'Bip01 L Clavicle', $'Bip01 L UpperArm', $Bone_L_ArmTwist, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Clavicle', $'Bip01 R UpperArm', $Bone_R_ArmTwist, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1', $B_Spine, $'Bip01 R Thigh', $Bone_R_ThighTwist, $'Bip01 L Thigh', $Bone_L_ThighTwist, $B_RP, $B_LP)"
m2_hand = obj_bone_preset obj_name:"M2_*_hand" command_str:"select #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', $'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', $'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', $'Bip01 L Finger42', $B_LH, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', $'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12', $'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', $'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R Finger42', $B_RH, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1')"
m2_leg = obj_bone_preset obj_name:"M2_*_leg" command_str:"select #($'Bip01 Pelvis', $'Bip01 Spine', $B_Spine, $'Bip01 R Thigh', $'Bip01 R Calf', $'Bip01 R Foot', $'Bip01 R Toe0', $Bone_R_ThighTwist, $'Bip01 L Thigh', $'Bip01 L Calf', $'Bip01 L Foot', $'Bip01 L Toe0', $Bone_L_ThighTwist)"
m2_belt = obj_bone_preset obj_name:"M2_*_belt" command_str:"select #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403, $ADD_L401, $ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $Bone_R_ThighTwist, $Bone_L_ThighTwist, $'Bip01 Spine1', $'Bip01 R Thigh')"

if default_preset_list == undefined then(
	default_preset_list = #(m2_body,m2_hand,m2_leg,m2_belt)
)
-----------------------------------------------------------------------------
--as the function name describes
fn fn_select_obj_and_get_skin_modifier_by_preset preset = (
	if classof preset != obj_bone_preset then (
		--to refine
		messagebox "Preset is not a obj_bone_preset type!"
		print (classof preset)
		return ()
	)
	target_obj_path = execute ("$'"+preset.obj_name+"'")
	if target_obj_path.count>1 then (
		throw ("More than one object named "+preset.obj_name+" found!")
	)
	if target_obj_path == undefined then (
		throw ("No object path named "+preset.obj_name+" found!")
		--to refine
	)
	target_obj = target_obj_path[1]
	if target_obj == undefined then (
		throw ("No object named "+preset.obj_name+" found!")
		--to refine
	)
	
	select target_obj_path
	
	setCommandPanelTaskMode mode:#modify
	
	if target_obj.modifiers[Skin] == undefined then(
		return ()
	)
	skin_modifier = target_obj.modifiers[#Skin]	
	return skin_modifier 
)

--auto find target object and auto find bones to add and finish the bone adding work
fn fn_exec_preset preset old_str:"Bip01" new_str:"Bip01" obj_array:undefined = (
	print (classof preset)
	print obj_bone_preset
	print (classof preset == obj_bone_preset)
	if classof preset != obj_bone_preset then (
		--to refine
		messagebox "Preset is not a obj_bone_preset type!"
		--throw "Preset is not a obj_bone_preset type!"
		return ()
		throw "Preset is not a obj_bone_preset type!"
	)
	target_obj_path = execute ("$'"+preset.obj_name+"'")
	if target_obj_path.count>1 then (
		throw ("More than one object named "+preset.obj_name+" found!")
	)
	if target_obj_path == undefined then (
		throw ("No object path named "+preset.obj_name+" found!")
		--to refine
	)
	target_obj = target_obj_path[1]
	if target_obj == undefined then (
		throw ("No object named "+preset.obj_name+" found!")
		--to refine
	)
	else if obj_array!=undefined and findItem obj_array target_obj==0 then(
		format "preset % do not match any object in given selection,already ignored\n" preset.obj_name
		return ()
	)
	print (classof target_obj)
	
	select target_obj_path
	
	setCommandPanelTaskMode mode:#modify
	
	if target_obj.modifiers[Skin] == undefined then(
		addmodifier target_obj (Skin())
	)
	skin_modifier = target_obj.modifiers[#Skin]	
	print (skin_modifier)
	-------------------
	--old_str = "Bip01"
	--new_str = "Bip01"
	-------------------
	command_str = fn_replace_all preset.command_str old_str new_str
	bone_arr = fn_process_selection_command_str command_str	
	fn_add_bone_from_collection skin_modifier bone_arr
)

fn fn_exec_preset_list preset_list:default_preset_list old_str:"Bip01" new_str:"Bip01" obj_array:undefined = (
	for preset in preset_list do(
		try(
			fn_exec_preset preset old_str:old_str new_str:new_str obj_array:obj_array
		)
		catch(
			print (getCurrentException())
			--throw()
			--to refine
		)
	)
)

-------------------------------------------------------------------

fn fn_test_replace = (
	ori_str = "select #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', $'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', $'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', $'Bip01 L Finger42', $B_LH, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', $'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12', $'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', $'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R Finger42', $B_RH, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1')"
	old_str = "Bip"
	new_str = "Biped"
	res_str = fn_replace_all ori_str old_str new_str
	return res_str
)

fn fn_test_exec = (
	command_str = fn_test_replace()
	arr = fn_process_selection_command_str command_str
	return arr
)

fn fn_test_join = ( 
	command_1 = "select #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', $'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', $'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', $'Bip01 L Finger42', $B_LH, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', $'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12', $'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', $'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R Finger42', $B_RH, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1')"
	command_2 = "select #($'Bip01 Pelvis', $'Bip01 Spine', $B_Spine, $'Bip01 R Thigh', $'Bip01 R Calf', $'Bip01 R Foot', $'Bip01 R Toe0', $Bone_R_ThighTwist, $'Bip01 L Thigh', $'Bip01 L Calf', $'Bip01 L Foot', $'Bip01 L Toe0', $Bone_L_ThighTwist)"
	command_3 = "select #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403, $ADD_L401, $ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $Bone_R_ThighTwist, $Bone_L_ThighTwist, $'Bip01 Spine1', $'Bip01 R Thigh')"
	command_4 = "select #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403, $ADD_L401, $ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 Spine1', $'Bip01 Spine2', $B_Long, $B_Spine2, $B_RC, $B_LC, $'Bip01 Neck', $'Bip01 Neck1', $'Bip01 Head', $'Bip01 L Clavicle', $'Bip01 L UpperArm', $Bone_L_ArmTwist, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Clavicle', $'Bip01 R UpperArm', $Bone_R_ArmTwist, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1', $B_Spine, $'Bip01 R Thigh', $Bone_R_ThighTwist, $'Bip01 L Thigh', $Bone_L_ThighTwist, $B_RP, $B_LP)"
	old_str = "Bip"
	new_str = "Bip"
	command_list = #(command_1,command_2,command_3,command_4)
	for i in 1 to command_list.count do(
		command_list[i] = fn_replace_all command_list[i] old_str new_str
	)
	return fn_sum_up_selection_by_command_ary command_list
)

fn fn_test_add_bone = (
	fn_add_bone_from_collection $.modifiers[#Skin] (fn_test_join())
)

fn fn_test_exec_preset = (
	fn_exec_preset m2_body
)

fn fn_test_get_bone_names = (
	return (fn_get_added_bone_names $.modifiers[#Skin])
)

fn fn_test_exec_preset_list = (
	fn_exec_preset_list()
)

--fn_test_exec_preset_list()

--print (fn_test_replace())

--fn_test_get_bone_names()

--fn_test_exec_preset()
--fn_test_add_bone()