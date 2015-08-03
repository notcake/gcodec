local self = {}
GCodec.Source.VVD.BoneWeightData = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Weights   = { 0, 0, 0 }
	self.BoneIds   = { 0, 0, 0 }
	self.BoneCount = 0
end

function self:Deserialize (inBuffer)
	self.Weights [1] = inBuffer:Float ()
	self.Weights [2] = inBuffer:Float ()
	self.Weights [3] = inBuffer:Float ()
	self.BoneIds [1] = inBuffer:UInt8 ()
	self.BoneIds [2] = inBuffer:UInt8 ()
	self.BoneIds [3] = inBuffer:UInt8 ()
	self.BoneCount   = inBuffer:UInt8 ()
	
	return self
end