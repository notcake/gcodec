local self = {}
GCodec.Source.VVD.Header = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Magic    = ""
	self.Version  = 0
	self.Checksum = 0
	
	self.LODCount = 0
	self.LODVertices = {}
	
	self.FixupCount = 0
	self.FixupTableOffset = 0
	self.VertexDataOffset = 0
	self.TangentDataOffset = 0
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	self.Magic = inBuffer:Bytes (4)
	
	self.Version  = inBuffer:UInt32 ()
	self.Checksum = inBuffer:UInt32 ()
	self.LODCount = inBuffer:Bytes (64)
	
	for i = 1, 8 do
		self.LODVertices [i] = inBuffer:UInt32 ()
	end
	
	self.FixupCount = inBuffer:UInt32 ()
	self.FixupTableOffset = inBuffer:UInt32 ()
	self.VertexDataOffset = inBuffer:UInt32 ()
	self.TangentDataOffset = inBuffer:UInt32 ()
	
	callback (true)
end