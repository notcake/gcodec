if SERVER or
   file.Exists ("gcodec/gcodec.lua", "LUA") or
   file.Exists ("gcodec/gcodec.lua", "LCL") and GetConVar ("sv_allowcslua"):GetBool () then
	include ("gcodec/gcodec.lua")
end