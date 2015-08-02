local self = {}
GCodec.Codec = GCodec.MakeConstructor (self)

function self:ctor (object, resourceLocator)
	self.ResourceLocator = resourceLocator or GCodec.DefaultResourceLocator
end

function self:CheckYield ()
end

function self:GetResourceLocator ()
	return self.ResourceLocator
end

function self:ReadResource (baseResource, resourcePath, callback)
	callback = callback or GCodec.NullCallback
	
	self:GetResourceLocator ():FindResource (baseResource, resourcePath,
		function (success, resource)
			if not success then callback (false) return end
			resource:Open (GLib.GetLocalId (), VFS.OpenFlags.Read,
				function (returnCode, fileStream)
					if returnCode ~= VFS.ReturnCode.Success then callback (false) return end
					
					fileStream:Read (fileStream:GetLength (),
						function (returnCode, data)
							if returnCode == VFS.ReturnCode.Progress then return end
							
							fileStream:Close ()
							if returnCode ~= VFS.ReturnCode.Success then callback (false) return end
							callback (true, GLib.StringInBuffer (data))
						end
					)
				end
			)
		end
	)
end

-- Serialization
function self:Serialize (outBuffer, callback, resource)
	GCodec.Error ("Codec:Serialize : Not implemented.")
	callback (false)
end

function self:Deserialize (inBuffer, callback, resource)
	GCodec.Error ("Codec:Deserialize : Not implemented.")
	callback (false)
end