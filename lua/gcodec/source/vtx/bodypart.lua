local self = {}
GCodec.Source.VTX.BodyPart = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset = 0
	
	self.ModelCount = 0
	self.ModelOffset = 0
	
	self.Models = {}
end

function self:Deserialize (inBuffer)
	self.Offset = inBuffer:GetPosition ()
	
	self.ModelCount = inBuffer:UInt32 ()
	self.ModelOffset = inBuffer:UInt32 ()
end