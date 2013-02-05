local self = {}
GCodec.Model = GCodec.MakeConstructor (self)

function self:ctor ()
	self.VertexBuffer =
	{
		n  = 0,
		x  = {},
		y  = {},
		z  = {},
		w  = {},
		u  = {},
		v  = {},
		nx = {},
		ny = {},
		nz = {}
	}
	
	self.IndexBuffer = {}
	self.Parts = {}
	
	self.AABBMin = Vector (0, 0, 0)
	self.AABBMax = Vector (0, 0, 0)
end

function self:dtor ()
	for part in self:GetPartEnumerator () do
		part:dtor ()
	end
end

function self:AddPart ()
	local part = GCodec.ModelPart (self)
	self.Parts [#self.Parts + 1] = part
	return part
end

function self:GetAABB ()
	return self.AABBMin, self.AABBMax
end

function self:GetAABBMin ()
	return self.AABBMin
end

function self:GetAABBMax ()
	return self.AABBMax
end

function self:GetPart (partId)
	return self.Parts [partId]
end

function self:GetPartCount ()
	return #self.Parts
end

function self:GetPartEnumerator ()
	local i = 0
	return function ()
		i = i + 1
		return self.Parts [i]
	end
end

function self:GetVertexBuffer ()
	return self.VertexBuffer
end

function self:GetVertexCount ()
	return self.VertexBuffer.n
end

function self:GetIndexBuffer ()
	return self.IndexBuffer
end

function self:GetIndexCount ()
	return #self.IndexBuffer
end

function self:SetAABB (aabbMin, aabbMax)
	self.AABBMin = aabbMin
	self.AABBMax = aabbMax
end

function self:SetAABBMin (aabbMin)
	self.AABBMin = aabbMin
end

function self:SetAABBMax (aabbMax)
	self.AABBMax = aabbMax
end