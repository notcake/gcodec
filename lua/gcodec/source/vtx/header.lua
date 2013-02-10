local self = {}
GCodec.Source.VTX.Header = GCodec.MakeConstructor (self)

function self:ctor ()
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	callback (true)
end