local self = {}
GCodec.Mesh = GCodec.MakeConstructor (self)

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
end

function self:dtor ()
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