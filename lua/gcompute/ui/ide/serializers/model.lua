local self, info = GCompute.IDE.SerializerRegistry:CreateType ("Model")
info:SetDocumentType ("ModelDocument")
info:AddExtension ("obj")
info:SetCanDeserialize (true)
info:SetCanSerialize (true)

function self:ctor (document)
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCompute.NullCallback
	
	local model = GCodec.Model ()
	local objReader = GCodec.ObjReader (model)
	objReader:Deserialize (inBuffer, function (success)
		self.Document:SetModel (model)
		callback (success)
	end)
end

function self:Serialize (outBuffer, callback)
	callback = callback or GCompute.NullCallback
	callback (true)
end