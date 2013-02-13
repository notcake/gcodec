local self = {}
GCodec.Source.VTX.Header = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset = 0
	
	self.Version = 0
	self.VertexCacheSize = 0
	self.MaxBonesPerStrip = 0
	self.MaxBonesPerTri = 0
	self.MaxBonesPerVertex = 0
	self.Checksum = 0
	self.LODCount = 0
	
	self.MaterialReplacementListOffset = 0
	self.BodyPartCount = 0
	self.BodyPartOffset = 0
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	self.Offset = inBuffer:GetSeekPos ()
	
	self.Version = inBuffer:UInt32 ()
	self.VertexCacheSize = inBuffer:UInt32 ()
	self.MaxBonesPerStrip = inBuffer:UInt16 ()
	self.MaxBonesPerTri = inBuffer:UInt16 ()
	self.MaxBonesPerVertex = inBuffer:UInt32 ()
	self.Checksum = inBuffer:UInt32 ()
	self.LODCount = inBuffer:UInt32 ()
	
	self.MaterialReplacementListOffset = inBuffer:UInt32 ()
	self.BodyPartCount = inBuffer:UInt32 ()
	self.BodyPartOffset = inBuffer:UInt32 ()
	
	callback (true)
end