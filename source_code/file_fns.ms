file_path = getFileNamePath(getSourceFileName())
	
including_ms_list = #(
"skin_fns.ms",
"sel_add_fns.ms",
"slot_fns.ms",
"test.mcr"
)

doesFileExist (file_path  + "test_folder")
--copyFile (file_path  + "test_folder") ("scripts\\"+"test_folder")
makeDir ("scripts\\"  + "test_folder")

doesFileExist "\\xsjms\\????\\????\\???????\\????\\SkinActuator_wxx\\AddSkinModifier.ms"
copyFile "\\xsjms\\????\\????\\???????\\????\\SkinActuator_wxx\\AddSkinModifier.ms" (file_path)

for file in including_ms_list do(
	full_file_path = "scripts\\test_folder\\"+file
	if (doesFileExist full_file_path)==false then(
		copyFile (file_path + file) (full_file_path)
	)
)

--macros.load ("file_path")
--macros.run "MyTestTool" "test"