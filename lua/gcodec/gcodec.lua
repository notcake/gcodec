if GCodec then return end
GCodec = GCodec or {}

include ("glib/glib.lua")
include ("gooey/gooey.lua")

GLib.Initialize ("GCodec", GCodec)
GLib.AddCSLuaPackFile ("autorun/gcodec.lua")
GLib.AddCSLuaPackFolderRecursive ("gcodec")
GLib.AddCSLuaPackSystem ("GCodec")

include ("codec.lua")

-- Models
include ("models/model.lua")
include ("models/modelpart.lua")
include ("models/objreader.lua")

GCodec.AddReloadCommand ("gcodec/gcodec.lua", "gcodec", "GCodec")

if CLIENT then
	GCodec.IncludeDirectory ("gcodec/ui")
end