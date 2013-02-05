local self = {}
GCodec.Codec = GCodec.MakeConstructor (self)

function self:ctor ()
end

function self:CheckYield ()
end

function self:Deserialize (inBuffer, callback)
	GCodec.Error ("Codec:Deserialize : Not implemented.")
	callback (false)
end

function self:Serialize (outBuffer, callback)
	GCodec.Error ("Codec:Serialize : Not implemented.")
	callback (false)
end