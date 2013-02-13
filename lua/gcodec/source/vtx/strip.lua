local self = {}
GCodec.Source.VTX.Strip = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset = 0
	
	self.IndexCount = 0
	self.IndexOffset = 0
	self.VertexCount = 0
	self.VertexOffset = 0
	self.BoneCount = 0
	self.Flags = 0
	self.BoneStateChangeCount = 0
	self.BoneStateChangeOffset = 0
end

function self:Deserialize (inBuffer)
	self.Offset = inBuffer:GetSeekPos ()
	
	self.IndexCount = inBuffer:UInt32 ()
	self.IndexOffset = inBuffer:UInt32 ()
	self.VertexCount = inBuffer:UInt32 ()
	self.VertexOffset = inBuffer:UInt32 ()
	self.BoneCount = inBuffer:UInt16 ()
	self.Flags = inBuffer:UInt8 ()
	self.BoneStateChangeCount = inBuffer:UInt32 ()
	self.BoneStateChangeOffset = inBuffer:UInt32 ()
end