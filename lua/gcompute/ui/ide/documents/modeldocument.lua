local self, info = GCompute.IDE.DocumentTypes:CreateType ("ModelDocument")
info:SetViewType ("Model")

function self:ctor ()
	self.Model = nil
end

function self:dtor ()
	self.Model:dtor ()
end

function self:GetModel ()
	return self.Model
end

function self:SetModel (model)
	if self.Model then
		self.Model:dtor ()
	end
	self.Model = model
end