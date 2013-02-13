local self = {}
GCodec.Source.VTX.Vertex = GCodec.MakeConstructor (self)

function self:ctor ()
	self.BoneWeightIndices = { 0, 0, 0 }
	self.BoneCount = 0
	self.OriginalMeshVertexId = 0
	self.BoneIds = { 0, 0, 0 }
end

function self:Deserialize (inBuffer)
	self.BoneWeightIndices [1] = inBuffer:UInt8 ()
	self.BoneWeightIndices [2] = inBuffer:UInt8 ()
	self.BoneWeightIndices [3] = inBuffer:UInt8 ()
	self.BoneCount = inBuffer:UInt8 ()
	self.OriginalMeshVertexId = inBuffer:UInt16 ()
	self.BoneIds [1] = inBuffer:UInt8 ()
	self.BoneIds [2] = inBuffer:UInt8 ()
	self.BoneIds [3] = inBuffer:UInt8 ()
end