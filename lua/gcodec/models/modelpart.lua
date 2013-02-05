local self = {}
GCodec.ModelPart = GCodec.MakeConstructor (self)

function self:ctor (model)
	self.Model = model
	
	self.Mesh      = nil
	self.MeshValid = false
	
	self.StartIndex = 0
	self.TriangleCount = 0
end

function self:dtor ()
	if self.Mesh then
		self.Mesh:Destroy ()
		self.Mesh = nil
		self.MeshValid = false
	end
end

function self:GetMesh ()
	if not self.MeshValid then
		self:BuildMesh ()
	end
	return self.Mesh
end

function self:GetStartIndex ()
	return self.StartIndex
end

function self:GetTriangleCount ()
	return self.TriangleCount
end

function self:GetModel ()
	return self.Model
end

function self:SetStartIndex (index)
	self.StartIndex = index
end

function self:SetTriangleCount (triangleCount)
	self.TriangleCount = triangleCount
end

-- Internal, do not call
function self:BuildMesh ()
	if self.Mesh then
		self.Mesh:Destroy ()
		self.Mesh = nil
		self.MeshValid = false
	end
	
	local vertexCache = {}
	local vertices = {}
	local vertexBuffer = self.Model:GetVertexBuffer ()
	local indexBuffer = self.Model:GetIndexBuffer ()
	for i = self.StartIndex, self.StartIndex + self.TriangleCount * 3 - 1, 3 do
		local vertex1 = self:BuildVertex (vertexBuffer, vertexCache, indexBuffer [i] or 0)
		local vertex2 = self:BuildVertex (vertexBuffer, vertexCache, indexBuffer [i + 1] or 0)
		local vertex3 = self:BuildVertex (vertexBuffer, vertexCache, indexBuffer [i + 2] or 0)
		vertices [#vertices + 1] = vertex1
		vertices [#vertices + 1] = vertex2
		vertices [#vertices + 1] = vertex3
	end
	
	self.Mesh = Mesh ()
	self.Mesh:BuildFromTriangles (vertices)
	self.MeshValid = true
	
	return self.Mesh
end

function self:BuildVertex (vertexBuffer, vertexCache, index)
	if vertexCache [index] then return vertexCache [index] end
	
	local vertex =
	{
		pos    = Vector (vertexBuffer.x [index], vertexBuffer.y [index], vertexBuffer.z [index]),
		normal = Vector (vertexBuffer.nx [index], vertexBuffer.ny [index], vertexBuffer.nz [index]),
		u      = vertexBuffer.u [index] or 0,
		v      = vertexBuffer.v [index] or 0,
		color  = GLib.Colors.White
	}
	vertexCache [index] = vertex
	return vertexCache [index]
end