local self = {}
GCodec.Source.MdlReader = GCodec.MakeConstructor (self, GCodec.Codec)

function self:ctor (model)
	self.Model = model
	
	-- Deserialization
	A = self
	self.MDLHeader = GCodec.Source.MDL.Header ()
	self.VVDHeader = GCodec.Source.VVD.Header ()
	self.VTXHeader = GCodec.Source.VTX.Header ()
	self.VTXBodyParts = {}
end

function self:Deserialize (inBuffer, callback, resource)
	self.MDLHeader:Deserialize (inBuffer)
	
	self:ReadResource (resource, resource:GetNameWithoutExtension () .. ".vvd",
		function (success, inBuffer)
			if not success then return end
			
			self.VVDHeader:Deserialize (inBuffer)
			inBuffer:SeekTo (self.VVDHeader.Offset + self.VVDHeader.VertexDataOffset)
			
			-- Read vertices
			local vertexBuffer = self.Model:GetVertexBuffer ()
			local vertex = GCodec.Source.VVD.Vertex ()
			for i = 1, self.VVDHeader.LODVertices [1] do
				vertex:Deserialize (inBuffer)
				
				vertexBuffer.n = vertexBuffer.n + 1
				vertexBuffer.x  [vertexBuffer.n] = vertex.x
				vertexBuffer.y  [vertexBuffer.n] = vertex.y
				vertexBuffer.z  [vertexBuffer.n] = vertex.z
				vertexBuffer.nx [vertexBuffer.n] = vertex.nx
				vertexBuffer.ny [vertexBuffer.n] = vertex.ny
				vertexBuffer.nz [vertexBuffer.n] = vertex.nz
				vertexBuffer.u  [vertexBuffer.n] = vertex.u
				vertexBuffer.v  [vertexBuffer.n] = vertex.v
			end
		end
	)
	
	local vtxExtensions =
	{
		".vtx",
		".dx90.vtx",
		".dx80.vtx",
		".sw.vtx"
	}
	local i = 0
	local function nextVTXExtension ()
		i = i + 1
		if not vtxExtensions then return end
		
		self:ReadResource (resource, resource:GetNameWithoutExtension () .. vtxExtensions [i],
			function (success, inBuffer)
				if not success then nextVTXExtension () return end
				
				self.VTXHeader:Deserialize (inBuffer)
				
				local bodyPartOffset = self.VTXHeader.Offset + self.VTXHeader.BodyPartOffset
				for bodyPartId = 1, self.VTXHeader.BodyPartCount do
					local bodyPart = GCodec.Source.VTX.BodyPart ()
					self.VTXBodyParts [#self.VTXBodyParts + 1] = bodyPart
					inBuffer:SeekTo (bodyPartOffset)
					bodyPart:Deserialize (inBuffer)
					bodyPartOffset = inBuffer:GetSeekPos ()
					
					local modelOffset = bodyPart.Offset + bodyPart.ModelOffset
					for modelId = 1, bodyPart.ModelCount do
						local model = GCodec.Source.VTX.Model ()
						bodyPart.Models [#bodyPart.Models + 1] = model
						inBuffer:SeekTo (modelOffset)
						model:Deserialize (inBuffer)
						modelOffset = inBuffer:GetSeekPos ()
						
						local lodOffset = model.Offset + model.LODOffset
						for lodId = 1, model.LODCount do
							local lod = GCodec.Source.VTX.LOD ()
							model.LODs [#model.LODs + 1] = lod
							inBuffer:SeekTo (lodOffset)
							lod:Deserialize (inBuffer)
							lodOffset = inBuffer:GetSeekPos ()
							
							local meshOffset = lod.Offset + lod.MeshOffset
							for meshId = 1, lod.MeshCount do
								local mesh = GCodec.Source.VTX.Mesh ()
								lod.Meshes [#lod.Meshes + 1] = mesh
								inBuffer:SeekTo (meshOffset)
								mesh:Deserialize (inBuffer)
								meshOffset = inBuffer:GetSeekPos ()
								
								local stripGroupOffset = mesh.Offset + mesh.StripGroupOffset
								for stripGroupId = 1, mesh.StripGroupCount do
									local stripGroup = GCodec.Source.VTX.StripGroup ()
									mesh.StripGroups [#mesh.StripGroups + 1] = stripGroup
									inBuffer:SeekTo (stripGroupOffset)
									stripGroup:Deserialize (inBuffer)
									stripGroupOffset = inBuffer:GetSeekPos ()
									
									local stripOffset = stripGroup.Offset + stripGroup.StripOffset
									for stripId = 1, stripGroup.StripCount do
										local strip = GCodec.Source.VTX.Strip ()
										stripGroup.Strips [#stripGroup.Strips + 1] = strip
										inBuffer:SeekTo (stripOffset)
										strip:Deserialize (inBuffer)
										stripOffset = inBuffer:GetSeekPos ()
									end
								end
							end
						end
					end
				end
			end
		)
	end
	nextVTXExtension ()
	
	callback (true)
end

function self:Serialize (outBuffer, callback, resource)
	
end