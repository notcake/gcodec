local self = {}
GCodec.Source.VTX.LOD = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset = 0
	
	self.MeshCount = 0
	self.MeshOffset = 0
	self.SwitchPoint = 0
	
	self.Meshes = {}
end

function self:Deserialize (inBuffer)
	self.Offset = inBuffer:GetSeekPos ()
	
	self.MeshCount = inBuffer:UInt32 ()
	self.MeshOffset = inBuffer:UInt32 ()
	self.SwitchPoint = inBuffer:Float ()
end