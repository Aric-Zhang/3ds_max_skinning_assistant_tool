# Tool Installation:
1. Drag the mzp package into the max interface. No response on the interface is considered normal behavior. The installation is now complete.
2. In the Customize UI (under the Toolbar tab), locate the MyTestTool category and select the test open tool.
3. Drag it out to create a button.
4. Click to run.
If after step 1 you do not find the above-mentioned mcr in the Customize User Interface, navigate directly to the max installation directory -> script folder -> skin_folder, where you will find test_cn.mcr. Drag this into the max interface.
# Using the Tool:
Three rows of buttons：

## The first row contains buttons for applying all bone presets and their advanced options. 
Opening advanced options reveals a left-side ListBox displaying loaded presets and a right-side ListBox showing bones found in the scene for the current preset. 

**Presets:** A structure consisting of object names and selection commands that correspond to the objects in the respective file name.  

**Edit Preset / New Preset:** Change the contents of a preset by modifying its definition (string), which includes object names and command content. Clicking these will open the Edit Preset dialog. 

**Preset Object Name:** e.g., “m2_*_body”, where * can represent any string. Case-insensitive matching will recognize scene objects named like “M2_2308_body”. 

**Preset Command Content:** e.g., “select #($'Bip001 L Clavicle', $'Bip001 R Clavicle', ……)”, presented in MAXScript code format. However, the statement will not be directly executed upon execution. 
Currently, newly created or modified presets have a lifespan limited to the current max software session. They need to be reloaded for the next session. 

**Replace/Use:** Perform preprocessing operations on the preset command content. For example, when creating a Biped skeleton, it is named Biped001 *, but the preset uses Biped01 *. In this case, use “Biped001” to replace “Biped01” so that the preset can be applied directly.

**Apply Current/Apply All:** Apply Current applies only the selected preset, while Apply All applies all presets.

**Apply Button:** Applies the presets based on the above settings.
## The second row contains buttons for clearing all slot bone weights and editing slot bone definitions.
**Clear All Slot Bone Weights:** Sets the weight of slot bones in all identifiable objects to 0 according to the preset and slot bone definitions.

**Slot Bone Definition Editing:** Defined as a string containing slot bone names. Modify the string content to change the slot bone definition. Changes are valid for the current max software session.
## The third row selects vertices influenced by the selected bones.
Must be run with the Skinning Modifier displayed in the Modify panel.
# Tool Uninstallation
In the 'usermarco' folder of 3DS MAX, locate _ZZS_Skin_Util-Macro_Script.mcr and delete it.

In the 'scripts' folder at the root directory of 3DS MAX, find the skin_folder and delete its contents entirely.
