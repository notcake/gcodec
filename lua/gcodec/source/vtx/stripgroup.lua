local self = {}
GCodec.Source.VTX.StripGroup = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset       = 0
	
	self.VertexCount  = 0
	self.VertexOffset = 0
	self.IndexCount   = 0
	self.IndexOffset  = 0
	self.StripCount   = 0
	self.StripOffset  = 0
	self.Flags        = 0
	
	self.Strips       = {}
end

function self:Deserialize (inBuffer)
	self.Offset       = inBuffer:GetPosition ()
	
	self.VertexCount  = inBuffer:UInt32 ()
	self.VertexOffset = inBuffer:UInt32 ()
	self.IndexCount   = inBuffer:UInt32 ()
	self.IndexOffset  = inBuffer:UInt32 ()
	self.StripCount   = inBuffer:UInt32 ()
	self.StripOffset  = inBuffer:UInt32 ()
	self.Flags        = inBuffer:UInt8  ()
	
	return self
end