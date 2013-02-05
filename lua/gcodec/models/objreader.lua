local self = {}
GCodec.ObjReader = GCodec.MakeConstructor (self, GCodec.Codec)

function self:ctor (model)
	self.Model = model
	A = self.Model
	
	-- Deserialization
	self.Data = nil
	self.PreviousPosition = 1
	self.Position = 1
	
	self.VertexCache = {}
	
	self.Vertices =
	{
		x = {},
		y = {},
		z = {},
		w = {}
	}
	self.TextureCoordinates =
	{
		u = {},
		v = {},
		w = {}
	}
	self.Normals =
	{
		x = {},
		y = {},
		z = {}
	}
	self.Faces =
	{
		n = {},
		[1] = { v = {}, vt = {}, vn = {} }
	}
end

function self:Deserialize (inBuffer, callback)
	self.Data = inBuffer:Bytes (inBuffer:GetBytesRemaining ())
	
	local aabbMin = Vector ( math.huge,  math.huge,  math.huge)
	local aabbMax = Vector (-math.huge, -math.huge, -math.huge)
	
	local token = self:NextToken ()
	while token do
		if token == "v" then
			local x, y, z, w = self:NextDouble (), self:NextDouble (), self:NextDouble (), self:NextDouble ()
			w = w or 1
			self.Vertices.x [#self.Vertices.x + 1] = x
			self.Vertices.y [#self.Vertices.y + 1] = y
			self.Vertices.z [#self.Vertices.z + 1] = z
			self.Vertices.w [#self.Vertices.w + 1] = w
			
			aabbMin.x = math.min (aabbMin.x, x)
			aabbMin.y = math.min (aabbMin.y, y)
			aabbMin.z = math.min (aabbMin.z, z)
			aabbMax.x = math.max (aabbMax.x, x)
			aabbMax.y = math.max (aabbMax.y, y)
			aabbMax.z = math.max (aabbMax.z, z)
		elseif token == "vt" then
			local u, v, w = self:NextDouble (), self:NextDouble (), self:NextDouble ()
			w = w or 0
			self.TextureCoordinates.u [#self.TextureCoordinates.u + 1] = u
			self.TextureCoordinates.v [#self.TextureCoordinates.v + 1] = v
			self.TextureCoordinates.w [#self.TextureCoordinates.w + 1] = w
		elseif token == "vn" then
			local x, y, z = self:NextDouble (), self:NextDouble (), self:NextDouble ()
			self.Normals.x [#self.Normals.x + 1] = x
			self.Normals.y [#self.Normals.y + 1] = y
			self.Normals.z [#self.Normals.z + 1] = z
		elseif token == "f" then
			local i = 1
			
			while true do
				local data = self:NextToken () or ""
				if not string.find (data, "[0-9]") then
					self:Backtrack ()
					break
				end
				data = data .. "//"
				local vertexId, texCoordId, normalId = string.match (data, "([^/]*)/([^/]*)/([^/]*)")
				vertexId   = tonumber (vertexId)
				texCoordId = tonumber (texCoordId)
				normalId   = tonumber (normalId)
				
				self.Faces [i] = self.Faces [i] or { v = {}, vt = {}, vn = {} }
				
				self.Faces [i].v  [#self.Faces.n + 1] = vertexId
				self.Faces [i].vt [#self.Faces.n + 1] = texCoordId
				self.Faces [i].vn [#self.Faces.n + 1] = normalId
				
				i = i + 1
			end
			self.Faces.n [#self.Faces.n + 1] = i - 1
		elseif token == "mtllib" then
			local libraryName = self:NextToken ()
		elseif token == "usemtl" then
			local materialName = self:NextToken ()
		elseif token then
			print ("Unhandled definition " .. token)
		end
		token = self:NextToken ()
	end
	
	-- Construct model
	local vertexBuffer = self.Model:GetVertexBuffer ()
	local indexBuffer  = self.Model:GetIndexBuffer ()
	
	self.Model:SetAABBMin (aabbMin)
	self.Model:SetAABBMax (aabbMax)
	
	local part = self.Model:AddPart ()
	part:SetStartIndex (1)
	
	local triangleCount = 0
	for i = 1, #self.Faces.n do
		local baseIndex = self:WriteVertex (vertexBuffer, self.Faces [1].v [i], self.Faces [1].vt [i], self.Faces [1].vn [i])
		local index1 = self.Faces.n [i] >= 3 and self:WriteVertex (vertexBuffer, self.Faces [2].v [i], self.Faces [2].vt [i], self.Faces [2].vn [i])
		local index2
		for j = 3, self.Faces.n [i] do
			index2 = self:WriteVertex (vertexBuffer, self.Faces [3].v [i], self.Faces [3].vt [i], self.Faces [3].vn [i])
			
			indexBuffer [#indexBuffer + 1] = baseIndex
			indexBuffer [#indexBuffer + 1] = index1
			indexBuffer [#indexBuffer + 1] = index2
			index1 = index2
			
			triangleCount = triangleCount + 1
		end
	end
	part:SetTriangleCount (triangleCount)
	
	callback (true)
end

function self:Serialize (outBuffer, callback)
	
end

-- Internal, do not call
function self:WriteVertex (vertexBuffer, vertexId, texCoordId, normalId)
	local vertexHash = (vertexId or 0) * 65536 * 65536 + (texCoordId or 0) * 65536 + (normalId or 0)
	if not self.VertexCache [vertexHash] then
		vertexBuffer.n = vertexBuffer.n + 1
		vertexBuffer.x  [vertexBuffer.n] = self.Vertices.x [vertexId]
		vertexBuffer.y  [vertexBuffer.n] = self.Vertices.y [vertexId]
		vertexBuffer.z  [vertexBuffer.n] = self.Vertices.z [vertexId]
		vertexBuffer.w  [vertexBuffer.n] = self.Vertices.w [vertexId]
		vertexBuffer.u  [vertexBuffer.n] = self.TextureCoordinates.u [texCoordId]
		vertexBuffer.v  [vertexBuffer.n] = self.TextureCoordinates.v [texCoordId]
		vertexBuffer.nx [vertexBuffer.n] = self.Normals.x [normalId]
		vertexBuffer.ny [vertexBuffer.n] = self.Normals.y [normalId]
		vertexBuffer.nz [vertexBuffer.n] = self.Normals.z [normalId]
		self.VertexCache [vertexHash] = vertexBuffer.n
	end
	return self.VertexCache [vertexHash]
end

function self:Backtrack ()
	self.Position = self.PreviousPosition
end

function self:NextDouble ()
	local number = tonumber (self:NextToken ())
	if not number then
		self:Backtrack ()
	end
	return number
end

function self:NextToken (peek)
	if peek == nil then peek = false end
	
	local tokenStart = string.find (self.Data, "[^\r\n\t ]", self.Position)
	if not tokenStart then
		self.PreviousPosition = #self.Data + 1
		self.Position = #self.Data + 1
		return nil
	end
	
	if string.sub (self.Data, tokenStart, tokenStart) == "#" then
		-- Line comment, move to next line
		self.Position = string.find (self.Data, "[\r\n]", tokenStart)
		if not self.Position then
			self.PreviousPosition = #self.Data + 1
			self.Position = #self.Data + 1
			return nil
		end
		if string.sub (self.Data, self.Position, self.Position) == "\r" then
			self.Position = self.Position + 1
			if string.sub (self.Data, self.Position, self.Position) == "\n" then
				self.Position = self.Position + 1
			end
		else
			self.Position = self.Position + 1
		end
		
		return self:NextToken ()
	end
	
	local tokenEnd = string.find (self.Data, "[#\r\n\t ]", tokenStart) or (#self.Data + 1)
	if not peek then
		self.PreviousPosition = self.Position
		self.Position = tokenEnd
	end
	return string.sub (self.Data, tokenStart, self.Position - 1)
end

function self:PeekToken ()
	return self:NextToken (true)
end