local self = {}
GCodec.DefaultResourceLocator = GCodec.MakeConstructor (self)

function self:ctor ()
end

function self:FindResource (baseResource, resourcePath, callback)
	callback = callback or GCodec.NullCallback
	
	if not baseResource then callback (false) return end
	if not resourcePath then callback (false) return end
	if not VFS then callback (false) return end
	
	VFS.DefaultResourceLocator (baseResource, resourcePath, callback)
end

GCodec.DefaultResourceLocator = GCodec.DefaultResourceLocator ()