local self = {}
GCodec.Source.VTX.Model = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset    = 0
	
	self.LODCount  = 0
	self.LODOffset = 0
	
	self.LODs      = {}
end

function self:Deserialize (inBuffer)
	self.Offset    = inBuffer:GetPosition ()
	
	self.LODCount  = inBuffer:UInt32 ()
	self.LODOffset = inBuffer:UInt32 ()
	
	return self
end