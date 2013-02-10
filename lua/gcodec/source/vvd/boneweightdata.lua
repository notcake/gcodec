local self = {}
GCodec.Source.VVD.BoneWeightData = GCodec.MakeConstructor (self)

function self:ctor ()
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	callback (true)
end