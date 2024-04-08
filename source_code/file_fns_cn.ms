file_path = getFileNamePath(getSourceFileName())
	
including_ms_list = #(
"skin_fns.ms",
"sel_add_fns.ms",
"slot_fns.ms"
)

for file in including_ms_list do(
	full_file_path = "scripts\\test_folder\\"+file
	if (doesFileExist full_file_path)==false then(
		copyFile (file_path + file) (full_file_path)
	)
)
--运行每个依赖文件--将之装载至内存
for file in including_ms_list do(
	FileIn (file_path+file)
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--auto switch lines
fn fn_auto_change_line ori_str ch_num = (
	new_str = ""
	for i in 1 to ori_str.count do(
		new_str = append new_str ori_str[i]
		if i-(i/ch_num)*ch_num == 0 then(
			new_str = append new_str "\n"
		)
	)
	print new_str
	return new_str	
)

--get obj names in scene by command str
fn fn_get_names_arr_from_command command_str = (
	obj_arr = fn_process_selection_command_str command_str
	names_arr = for obj in obj_arr collect obj.name
	return names_arr
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
global PresetRollout 
global SkinMainRollout
global Edit_Preset_Rollout
global SlotRollout
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--arg部分用来在界面关闭以后重新运行之前保存界面上的数据
if editing_preset_index_arg == undefined then(
	global editing_preset_index_arg = 0
)
if apply_to_state_arg == undefined then(
	global apply_to_state_arg = 1
)
if replace_checked_arg == undefined then(
	global replace_checked_arg = false
)

global old_str_arg = ""
global new_str_arg = ""

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--主rollout
rollout SkinMainRollout "蒙皮加速工具" width:162 height:80
(
	button 'btn_add_all_bones' "按预设添加选择集骨骼" pos:[5,5] width:120 height:20 align:#left
	button 'btn_add_bone_detail' "..." pos:[130,5] width:27 height:20 align:#left
	button 'btn_clean_slot_weight' "清除选择集槽骨骼权重" pos:[5,30] width:120 height:20 align:#left
	button 'btn_slot_detail' "..." pos:[130,30] width:26 height:20 align:#left
	button 'btn_verts_by_bone' "选择当前骨骼影响的顶点" pos:[5,55] width:152 height:20 align:#left
	
	fn fn_clean_slot_weight_on_all_presets = (
		for preset in default_preset_list do(
			skin_modifier = fn_select_obj_and_get_skin_modifier_by_preset preset
			if skin_modifier!=undefined then(
				--ba is a bitarray type which hold bone indexes
				ba = fn_get_joined_bone_id_bitarray_by_slot_bone_str skin_modifier
				fn_set_weight_0_by_bone_bitarray skin_modifier ba
			)
			else(
				print "当前选中物体没有蒙皮修改器."
			)
		)
	)
	
	fn fn_clean_slot_weight_on_selection = (
		if selection.count == 0 do(
			messagebox "没有物体被选中。" title:"提示"
		)
		obj_list = selection as array
		for obj in obj_list do(
			skin_modifier = obj.modifiers[#Skin]
			if(skin_modifier!=undefined)then(
				modPanel.setCurrentObject obj.modifiers[#Skin]
				ba = fn_get_joined_bone_id_bitarray_by_slot_bone_str skin_modifier
				fn_set_weight_0_by_bone_bitarray skin_modifier ba
			)
			else(
				format "%没有蒙皮修改器.\n" obj.name
			)
		)
	)
	
	on btn_add_all_bones pressed do
	(
		undo "Exec all presets" on(
			obj_array = selection as array
			fn_exec_preset_list obj_array:obj_array
		)
	)
	
	on btn_add_bone_detail pressed do
	(
		if PresetRollout.open == false then(
			createDialog PresetRollout parent:SkinMainRollout.hwnd
		)
	)
	
	on btn_clean_slot_weight pressed do
	(
		undo "Clean slot weights" on(
			--fn_clean_slot_weight_on_all_presets()
			fn_clean_slot_weight_on_selection()
		)
	)
	
	on btn_slot_detail pressed do
	(
		if SlotRollout.open == false then(
			createDialog SlotRollout parent:SkinMainRollout.hwnd
		)
	)
	on btn_verts_by_bone pressed  do
	(
		undo "Select vert bone"on(
			--skin_modifier = fn_select_current_obj_and_get_skin_modifier()
			fn_select_vert_by_bone()
		)
	)
)

--槽骨骼rollout
rollout SlotRollout "编辑槽骨骼定义" width:288 height:61
(
	edittext 'edt_slot_bnes' "命令内容" pos:[5,5] width:278 height:20 align:#left
	button 'btn_cofirm' "确认" pos:[5,35] width:135 height:20 align:#left
	button 'btn_cancel' "取消" pos:[145,35] width:135 height:20 align:#left
	
	on SlotRollout open  do
	(
		edt_slot_bnes.text = default_slot_bone_str	
	)
	on btn_cofirm pressed do
	(
		default_slot_bone_str = edt_slot_bnes.text
		destroyDialog SlotRollout
	)
	on btn_cancel pressed do
	(
		destroyDialog SlotRollout
	)
)

--骨骼预设
rollout PresetRollout "骨骼预设" width:289 height:299
(
	listbox 'lbx_presets' "预设列表" pos:[4,5] width:110 height:13 align:#left
 
	radiobuttons 'rdo_apply_ops' "" pos:[5,235] width:142 height:32 labels:#("应用所有预设", "应用当前选择的预设") columns:1 align:#left
	button 'btn_new_preset' "新建预设" pos:[5,218] width:75 height:14 align:#left
	button 'btn_edt_preset' "编辑预设" pos:[87,218] width:75 height:14 align:#left
	checkbox 'chk_replace' "替换所有" pos:[174,215] width:62 height:20 align:#left
	edittext 'edt_ori_str' "" pos:[234,215] width:50 height:20 align:#left
	label 'lbl1' "使用" pos:[188,242] width:32 height:20 align:#left
	edittext 'edt_new_str' "" pos:[218,242] width:66 height:20 align:#left
	button 'btn_apply' "应用" pos:[5,272] width:280 height:20 align:#left
	
	listbox 'lbx_avaliable_command' "场景中符合预设的骨骼" pos:[125,5] width:158 height:13 align:#left
	
	fn fn_get_processed_command_str preset = (
		
		if chk_replace.checked then(
			old_str = edt_ori_str.text
			new_str = edt_new_str.text
			res_str = fn_replace_all preset.command_str old_str new_str
			return res_str
		)
		return preset.command_str
	)
	
	fn fn_update_preset_view = (
		lbx_presets.items = for preset in default_preset_list collect(
			preset.obj_name			
		)
		current_preset = default_preset_list[1]
		command_str = fn_get_processed_command_str current_preset
		lbx_avaliable_command.items = fn_get_names_arr_from_command command_str
		print "done"
	)
	
	on PresetRollout open do
	(
		lbx_presets.items = for preset in default_preset_list collect(
			preset.obj_name			
		)
		current_preset = default_preset_list[1]
		command_str = fn_get_processed_command_str current_preset
		lbx_avaliable_command.items = fn_get_names_arr_from_command command_str
		rdo_apply_ops.state = apply_to_state_arg
		chk_replace.checked = replace_checked_arg
	)
	on lbx_presets selected sel do
	(
		current_preset = default_preset_list[sel]
		command_str = fn_get_processed_command_str current_preset
		lbx_avaliable_command.items = fn_get_names_arr_from_command command_str
	)
	on rdo_apply_ops changed stat do
	(
		apply_to_state_arg = stat
	)
	on btn_new_preset pressed do
	(
		editing_preset_index_arg = 0
		createDialog Edit_Preset_Rollout
	)
	on btn_edt_preset pressed do
	(
		editing_preset_index_arg = lbx_presets.selection
		createDialog Edit_Preset_Rollout
	)
	on chk_replace changed state do
	(
		replace_checked_arg = state
		fn_update_preset_view()
	)
	on btn_apply pressed do
	(
		if chk_replace.checked then(
			new_str = edt_new_str.text
			old_str = edt_ori_str.text
			if rdo_apply_ops.state ==1 then(
				fn_exec_preset_list preset_list:default_preset_list old_str:old_str new_str:new_str
			)
			else(
				current_preset = default_preset_list[lbx_presets.selection]
				fn_exec_preset current_preset old_str:old_str new_str:new_str
			)
		)
		else(
			if rdo_apply_ops.state ==1 then(
				fn_exec_preset_list()
			)
			else(
				current_preset = default_preset_list[lbx_presets.selection]
				fn_exec_preset current_preset
			)
		)
	)
	on lbx_avaliable_command selected sel do
	(
		name_str = lbx_avaliable_command.items[sel]
		execute ("select $'"+name_str+"'")
	)
)
--编辑预设
rollout Edit_Preset_Rollout "编辑预设" width:285 height:92
(
	edittext 'edt_input_command_str' "命令内容:" pos:[5,36] width:276 height:25 align:#left
	edittext 'edt_input_obj_name' "对象名:" pos:[5,5] width:276 height:25 align:#left
	button 'btn_confirm_command' "确认" pos:[5,67] width:136 height:20 align:#left
	button 'btn_cancel_command' "取消" pos:[144,67] width:136 height:20 align:#left
	
	--save edited preset to memory
	fn fn_save_preset preset_index:editing_preset_index_arg = (
		
		obj_name = edt_input_obj_name.text
		command_str = edt_input_command_str.text
		temp_preset = obj_bone_preset obj_name:obj_name command_str:command_str
		if preset_index == 0 then(
			append default_preset_list temp_preset 
		)
		else(
			default_preset_list[editing_preset_index_arg] = temp_preset
		)
	)
	
	on Edit_Preset_Rollout open do
	(
		index = editing_preset_index_arg
		if index!=0 then(
			current_preset = default_preset_list[index]
			edt_input_command_str.text = current_preset.command_str
			edt_input_obj_name.text = current_preset.obj_name
		)
	)
	
	on btn_confirm_command pressed do
	(
		fn_save_preset()
		PresetRollout.fn_update_preset_view()
		destroyDialog Edit_Preset_Rollout
	)
	
	on btn_cancel_command pressed do
	(
		destroyDialog Edit_Preset_Rollout
	)
)

fn test_main = (
	if SkinMainRollout.open!=true then (
		createDialog SkinMainRollout
	)
)

test_main()
--macros.load ("file_path")
--macros.