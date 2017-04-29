Script inspired by Mabakos SA-MP 0.2 medit script
Made by OffRoader23

Changelog
1.0.1 - Fixed some console warnings/errors
1.1 - Fixed for Windows servers
1.2 - Added /mclone /mstack, changed code to make it run a bit more smoothly, updated objects limit to 500 (this can be changed through the offedit.lua)
1.3 - Added /minfo to get the map info of the item your currently editing
1.4 - Added /mloop and /guestb


In-Game Map Editor - Commands
/mcreate <obj model number> - Creates object with specified model number
/msave - Saves object into script, and gives you that objects script ID
/mdestroy - Destroy currently selected object
/msel <ID> - Select object saved into script by objects script ID
/mclear - Clear all objects made with the map editor
/ox <value> - Move object on X axis
/oy <value> - Move object on Y axis
/oz <value> - Move object on Z axis
/rx <value> - Rotate object on X axis
/ry <value> - Rotate object on Y axis
/rz <value> - Rotate object on Z axis
/savemap <name> - Save all current items into script folder with specified name
/loadmap <name> - Load map from script folder with specified name
/saveobj <description> - Saves currently selected object to objects.txt with description and creator

New in 1.2

/mclone x y z rx ry rz - Clones currently selected object with the distance you specify (offsets not required)
/mstack num x y z rx ry rz - Clones currently selected object the specified ammount of times, with the distance away from the original

New in 1.3

/minfo to get the map info of the item your currently editing, give you model number, position, and rotation.

New in 1.4

/mloop pieces radius width rotaxis loops rotation - Makes a loop with currently selected piece.  Example:  /mloop 50 30 20 -y - If you use this with an object ID of 18450 (flat road) it makes a loop out of 50 pieces, the loops radius is 30, diameter 60, and from the first piece to the last there is a gap of 20 units, the object rotation axis for a 18450 is -y, if it is not set as that the loop will not be made right.  This is a more advanced command, and takes a lot of trial and error to get correct.
/guestb name - Guest someone with a building pass.  Gives them the ability to build, but not to loadmap, mclear, and savemap.  To do that put their name in offedit.lua.