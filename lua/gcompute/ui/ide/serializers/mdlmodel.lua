local self, info = GCompute.IDE.SerializerRegistry:CreateType ("MdlModel")
info:SetDocumentType ("ModelDocument")
info:AddExtension ("mdl")
info:SetCanDeserialize (true)

function self:ctor (document)
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCompute.NullCallback
	
	local model = GCodec.Model ()
	local mdlReader = GCodec.Source.MdlReader (model)
	mdlReader:Deserialize (inBuffer, function (success)
		self.Document:SetModel (model)
		callback (success)
	end)
end

function self:Serialize (outBuffer, callback)
	callback = callback or GCompute.NullCallback
	callback (true)
end