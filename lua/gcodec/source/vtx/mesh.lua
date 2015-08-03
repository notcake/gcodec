local self = {}
GCodec.Source.VTX.Mesh = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset           = 0
	
	self.StripGroupCount  = 0
	self.StripGroupOffset = 0
	self.Flags            = 0
	
	self.StripGroups      = {}
end

function self:Deserialize (inBuffer)
	self.Offset           = inBuffer:GetPosition ()
	
	self.StripGroupCount  = inBuffer:UInt32 ()
	self.StripGroupOffset = inBuffer:UInt32 ()
	self.Flags            = inBuffer:UInt8  ()
	
	return self
end