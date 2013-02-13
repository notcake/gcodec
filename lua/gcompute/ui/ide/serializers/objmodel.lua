local self, info = GCompute.IDE.SerializerRegistry:CreateType ("ObjModel")
info:SetDocumentType ("ModelDocument")
info:AddExtension ("obj")
info:SetCanDeserialize (true)
info:SetCanSerialize (true)

function self:ctor (document)
end

function self:Deserialize (inBuffer, callback, resource)
	callback = callback or GCompute.NullCallback
	
	local model = GCodec.Model ()
	local objReader = GCodec.ObjReader (model, self:GetResourceLocator ())
	objReader:Deserialize (inBuffer,
		function (success)
			self.Document:SetModel (model)
			callback (success)
		end,
		resource
	)
end

function self:Serialize (outBuffer, callback, resource)
	callback = callback or GCompute.NullCallback
	callback (true)
end