local self = {}
GCodec.Source.VVD.Vertex = GCodec.MakeConstructor (self)

function self:ctor ()
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	callback (true)
end