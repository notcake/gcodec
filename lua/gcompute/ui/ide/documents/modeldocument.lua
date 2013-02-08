local self, info = GCompute.IDE.DocumentTypes:CreateType ("ModelDocument")
info:SetViewType ("Model")

function self:ctor ()
	self.Model = nil
end

function self:dtor ()
	if self.Model then
		self.Model:dtor ()
	end
end

function self:GetModel ()
	return self.Model
end

function self:SetModel (model)
	if self.Model == model then return end
	
	if self.Model then
		self.Model:dtor ()
	end
	self.Model = model
	
	self:DispatchEvent ("ModelChanged", self.Model)
end