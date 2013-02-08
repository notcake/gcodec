local self = {}
GCodec.Source.MdlReader = GCodec.MakeConstructor (self, GCodec.Codec)

function self:ctor (model)
	self.Model = model
	
	-- Deserialization
	A = self
	self.MdlHeader = GCodec.Source.MDL.Header ()
	self.VvdHeader = GCodec.Source.VVD.Header ()
end

function self:Deserialize (inBuffer, callback)
	self.MdlHeader:Deserialize (inBuffer)
	callback (true)
end

function self:Serialize (outBuffer, callback)
	
end