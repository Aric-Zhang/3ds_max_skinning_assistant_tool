fn FN_AddSkinModifier SelectedObjArray = 
(
	M2_body = #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403,
				$ADD_L401, $ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 Spine1', $'Bip01 Spine2', 
				$B_Long, $B_Spine2, $B_RC, $B_LC, $'Bip01 Neck', $'Bip01 Neck1', $'Bip01 Head', $'Bip01 L Clavicle',
				$'Bip01 L UpperArm', $Bone_L_ArmTwist, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Clavicle',
				$'Bip01 R UpperArm', $Bone_R_ArmTwist, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1', $B_Spine, $'Bip01 R Thigh', 
				$Bone_R_ThighTwist, $'Bip01 L Thigh',$Bone_L_ThighTwist, $B_RP, $B_LP)
	M2_hand = #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', $'Bip01 L Finger11',
				$'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', $'Bip01 L Finger3', 
				$'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', $'Bip01 L Finger42', 
				$B_LH, $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', $'Bip01 R Finger01', 
				$'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12', $'Bip01 R Finger2', 
				$'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', $'Bip01 R Finger32', 
				$'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R Finger42', $B_RH, $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1')
	M2_leg = #($'Bip01 Pelvis', $'Bip01 Spine', $B_Spine, $'Bip01 R Thigh', $'Bip01 R Calf', $'Bip01 R Foot', $'Bip01 R Toe0', 
				$Bone_R_ThighTwist, $'Bip01 L Thigh', $'Bip01 L Calf', $'Bip01 L Foot', $'Bip01 L Toe0', $Bone_L_ThighTwist)
	M2_belt = #($ADD_L101, $ADD_L102, $ADD_L103, $ADD_R101, $ADD_R102, $ADD_R103, $ADD_R401, $ADD_R402, $ADD_R403, $ADD_L401, 
				$ADD_L402, $ADD_L403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $Bone_R_ThighTwist, $Bone_L_ThighTwist, 
				$'Bip01 Spine1', $'Bip01 R Thigh')
	F2_body = #($ADD_R101, $ADD_R102, $ADD_R103, $ADD_L101, $ADD_L102, $ADD_L103, $ADD_L401, $ADD_L402, $ADD_L403, $ADD_R401, 
				$ADD_R402, $ADD_R403, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $Bone_L_ThighTwist, $'Bip01 L Calf', 
				$'Bip01 Spine1', $'Bip01 Spine2', $'Bip01 Neck', $'Bip01 L Clavicle', $'Bip01 L UpperArm', $Bone_L_ArmTwist, 
				$'Bip01 R Clavicle', $'Bip01 R UpperArm', $Bone_R_ArmTwist, $'Bip01 Neck1', $'Bip01 Head', 
				$Bone_chest_R, $Bone_chest_L, $B_Long, $B_Spine2, $B_RC, $B_LC, $'Bip01 R Thigh', $'Bip01 R Calf', 
				$Bone_R_ThighTwist, $B_Spine, $B_LP, $B_RP)
	F2_hand = #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', 
				$'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22',
		 		$'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', 
		 		$'Bip01 L Finger42', $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', 
		 		$'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12',
		  		$'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', 
				$'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R Finger42', $'Bip01 R ForeTwist', 
				$'Bip01 R ForeTwist1')
	F2_leg = #($'Bip01 Pelvis', $'Bip01 R Toe0', $'Bip01 L Thigh', $Bone_L_ThighTwist, $'Bip01 L Calf', $'Bip01 L Foot', 
				$'Bip01 L Toe0', $'Bip01 R Thigh', $'Bip01 R Calf', $'Bip01 R Foot', $Bone_R_ThighTwist, $'Bip01 Spine', 
				$B_LH’,  $B_RH)
	F2_belt = #($ADD_R101, $ADD_R102, $'Bip01 Spine1', $ADD_L101, $ADD_L102, $ADD_L103, $ADD_L401, $ADD_L402, $ADD_L403, 
				$ADD_R401, $ADD_R402, $Bone_L_ThighTwist, $'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $Bone_R_ThighTwist, 
				$'Bip01 Spine2', $'Bip01 R Thigh', $ADD_R103, $ADD_R403)
	M1_body = #($'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Calf', $'Bip01 R Calf', $'Bip01 Spine1', $'Bip01 Spine2', $'Bip01 Neck',
				$'Bip01 Head', $'Bip01 L Clavicle', $'Bip01 L ForeTwist', $'Bip01 L ForeTwist1', $'Bip01 LUpArmTwist', 
				$'Bip01 LUpArmTwist1', $'Bip01 R Clavicle', $'Bip01 R ForeTwist', $'Bip01 R ForeTwist1', $'Bip01 RUpArmTwist', 
				$'Bip01 RUpArmTwist1', $B_LC, $B_RC, $B_Spine2, $B_Long, $B_Spine, $ADD_L101, $ADD_L102, $ADD_R101, $ADD_R102, 
				$ADD_R401, $ADD_R402, $ADD_L401, $ADD_L402, $'Bip01 LThighTwist', $'Bip01 LThighTwist1', $'Bip01 RThighTwist', 
				$'Bip01 RThighTwist1', $B_LP, $B_RP)
	M1_hand = #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', 
				$'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', 
				$'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', 
				$'Bip01 L Finger42', $B_LH, $'Bip01 R Finger42', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', 
				$'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12',
				$'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', 
				$'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R ForeTwist1', $'Bip01 R ForeTwist', 
				$B_RH, $'Bip01 L ForeTwist')
	M1_leg = #($'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Calf', $'Bip01 L Foot', $'Bip01 L Toe0', $'Bip01 R Calf', $'Bip01 R Foot', 
				$'Bip01 R Toe0', $'Bip01 RThighTwist', $'Bip01 LThighTwist', $'Bip01 LThighTwist1', $'Bip01 RThighTwist1', $'Bip01 Spine1')
	M1_belt = #($'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 RThighTwist', $'Bip01 LThighTwist', $ADD_L101, $ADD_L401, $ADD_R101, 
				$ADD_R401, $ADD_R402, $ADD_L102, $ADD_L402, $'Bip01 Spine2', $'Bip01 LThighTwist1', $'Bip01 Spine1', 
				$'Bip01 RThighTwist1', $ADD_R102)
	F1_body = #($'Bip01 Pelvis', $'Bip01 Spine', $'Bip01 L Thigh', $'Bip01 L Calf', $'Bip01 R Thigh', $'Bip01 R Calf', 
				$'Bip01 Spine1', $'Bip01 Spine2', $'Bip01 Neck', $'Bip01 Neck1', $'Bip01 Head', $'Bip01 L Clavicle', 
				$'Bip01 L UpperArm', $Bone_L_ArmTwist, $'Bip01 R Clavicle', $'Bip01 R UpperArm', $Bone_R_ArmTwist, 
				$B_LC, $B_RC, $B_Spine2, $B_Long, $B_Spine, $'Bip01 LThighTwist', $'Bip01 RThighTwist', $ADD_L501, $ADD_L502, 
				$ADD_L401, $ADD_L402, $ADD_R401, $ADD_R402, $ADD_R501, $ADD_R502, $ADD_R101, $ADD_R102, $ADD_L101, $ADD_L102, 
				$B_LP, $B_RP)
	F1_hand = #($'Bip01 L Hand', $'Bip01 L Finger0', $'Bip01 L Finger01', $'Bip01 L Finger02', $'Bip01 L Finger1', 
				$'Bip01 L Finger11', $'Bip01 L Finger12', $'Bip01 L Finger2', $'Bip01 L Finger21', $'Bip01 L Finger22', 
				$'Bip01 L Finger3', $'Bip01 L Finger31', $'Bip01 L Finger32', $'Bip01 L Finger4', $'Bip01 L Finger41', 
				$'Bip01 L Finger42', $B_LH, $'Bip01 R Finger42', $'Bip01 L ForeTwist1', $'Bip01 R Hand', $'Bip01 R Finger0', 
				$'Bip01 R Finger01', $'Bip01 R Finger02', $'Bip01 R Finger1', $'Bip01 R Finger11', $'Bip01 R Finger12', 
				$'Bip01 R Finger2', $'Bip01 R Finger21', $'Bip01 R Finger22', $'Bip01 R Finger3', $'Bip01 R Finger31', 
				$'Bip01 R Finger32', $'Bip01 R Finger4', $'Bip01 R Finger41', $'Bip01 R ForeTwist1', $'Bip01 R ForeTwist', $B_RH, 
				$'Bip01 L ForeTwist')
	F1_leg = #($'Bip01 R Thigh', $'Bip01 L Thigh', $'Bip01 L Calf', $'Bip01 L Foot', $'Bip01 L Toe0', $'Bip01 RThighTwist', 
				$'Bip01 R Calf', $'Bip01 R Foot', $'Bip01 R Toe0', $'Bip01 LThighTwist', $'Bip01 Pelvis')
	F1_belt = #($'Bip01 Pelvis', $'Bip01 Spine', $ADD_L101, $ADD_L501, $ADD_R102, $ADD_L401, $ADD_L402, $ADD_R401, $ADD_R402, 
				$ADD_R501, $ADD_R101, $ADD_L102, $'Bip01 Spine1', $ADD_L502, $ADD_R502)

	if(selection.count == 0) then
	(
		messageBox "未选择物体！    "
	)
	else
	(
		FalseNum = 0
		selectedNum = 0
		isDie = false
		--添加修改器
		--modPanel.addModToSelection(Skin())
		--addModifier selection (Skin())
		
		SelectedObjA = #()
		for obj in SelectedObjArray do 
		(
			append SelectedObjA obj
		) 
		for obj in SelectedObjA do
		(
			selectedNum += 1
			--添加蒙皮
			if(obj.modifiers[#Skin]==undefined) then
			(
				addModifier obj (Skin())
			)
			--添加骨骼
			BonesNum = skinOps.GetNumberBones obj.modifiers[skin]
			nameArray = FilterString obj.name "_"
			print nameArray[1]
			print nameArray[3]
			boneArray = #()
			case nameArray[1] of
			(
				"M2":
				(
					case nameArray[3] of
					(
						"body":						
						(
							boneArray = M2_body
						)
						"hand":
						(
							boneArray = M2_hand
						)
						"leg":(
							boneArray = M2_leg
						)
						"belt":(
							boneArray = M2_belt
						)
						default:()
					)
				)
				"F2":
				(
					case nameArray[3] of
					(
						"body":
						(
							boneArray = F2_body
						)
						"hand":
						(
							boneArray = F2_hand
						)
						"leg":
						(
							boneArray = F2_leg
						)
						"belt":
						(
							boneArray = F2_belt
						)
							default:()
					)
				)
				"M1":
				(
					case nameArray[3] of
					(
						"body":
						(
							boneArray = M1_body
						)
						"hand":
						(
							boneArray = M1_hand
						)
						"leg":
						(
							boneArray =  M1_leg
						)
						"belt":
						(
							boneArray = M1_belt
						)
						default:()
					)
				)
				"F1":
				(
					case nameArray[3] of
					(
						"body":
						(
							boneArray = F1_body
						)
						"hand":
						(
							boneArray = F1_hand
						)
						"leg":
						(
							boneArray = F1_leg
						)
						"belt":
						(
							boneArray = F1_belt
						)
						default:()
					)
				)
				default:
				(
					FalseNum += 1
					NotExistStr =obj.name +  "未在添加列表中~        "  
					messageBox NotExistStr
				)  
			)
			if(BonesNum == 0) then
			(
				select obj
				for i in 1 to boneArray.count do 
				(
					skinOps.addBone obj.modifiers[Skin] boneArray[i] 0
				)
				boneArray = #()
			)
			else
			(
				select obj
				NotExistStr = obj.name +  "原有蒙皮工具中已添加骨骼，是否继续操作？(本次操作只会添加物体所缺少的骨骼)                   "   
				isChange = true
				isChange = (queryBox NotExistStr title:"注意！" beep:true )
				if(isChange)then
				(
					print 222
					select obj
					ExitBoneArray = #()
					bonesNum = skinOps.GetNumberBones obj.modifiers[skin]
					for BoneID in 1 to bonesNum do 
					(
						append ExitBoneArray (skinOps.GetBoneNameByListID obj.modifiers[skin] BoneID 1) 
					)
					for i in 1 to boneArray.count do
					(
						if(findItem ExitBoneArray (boneArray[i].name) == 0) then
						(
							skinOps.addBone obj.modifiers[Skin] boneArray[i] 0
						)
					)
					isDie = true
					free ExitBoneArray 
					free boneArray					
				)
				else()
			)
		)
		if(FalseNum == 0 and isDie == false) then
		(
			messageBox "添加成功!   "
		)
		else if(FalseNum == selection.count and isDie == false) then
		(
			messageBox "添加失败!   "
		)		
		else if(isDie == false) then
		(
			messageBox "部分添加成功!   "
		)
		else
		(
			messageBox "骨骼添加成功!   "
		)
		global SelectionArray = SelectedObjA
		select SelectionArray
		free SelectedObjA
	)
	
)