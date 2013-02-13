local self = {}
GCodec.Source.VVD.Vertex = GCodec.MakeConstructor (self)

function self:ctor ()
	self.BoneWeightData = GCodec.Source.VVD.BoneWeightData ()
	self.x  = 0
	self.y  = 0
	self.z  = 0
	self.nx = 0
	self.ny = 0
	self.nz = 0
	self.u  = 0
	self.v  = 0
end

function self:Deserialize (inBuffer)
	self.BoneWeightData:Deserialize (inBuffer)
	self.x  = inBuffer:Float ()
	self.y  = inBuffer:Float ()
	self.z  = inBuffer:Float ()
	self.nx = inBuffer:Float ()
	self.ny = inBuffer:Float ()
	self.nz = inBuffer:Float ()
	self.u  = inBuffer:Float ()
	self.v  = inBuffer:Float ()
end