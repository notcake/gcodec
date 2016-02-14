local self = {}
GCodec.Source.MDL.Header = GCodec.MakeConstructor (self)

function self:ctor ()
	self.Offset = 0
	
	self.Magic    = ""
	self.Version  = 0
	self.Checksum = 0
	self.Name     = 0
	
	self.EyePosition   = Vector ()
	self.IllumPosition = Vector ()
	
	self.HullMin = Vector ()
	self.HullMax = Vector ()
	
	self.ViewBBMin = Vector ()
	self.ViewBBMax = Vector ()
	
	self.BoneCount = 0
	self.BoneOffset = 0
	
	self.BoneControllerCount = 0
	self.BoneControllerOffset = 0
	
	self.HitboxSetCount = 0
	self.HitboxSetOffset = 0

	self.LocalAnimCount = 0
	self.LocalAnimOffset = 0
    
	self.LocalSeqCount = 0
	self.LocalSeqOffset = 0
    
	self.ActivityListVersion = 0
	self.EventsIndexed = 0
    
	self.TextureEntryCount = 0
	self.TextureEntryOffset = 0
	
	self.TexturePathCount = 0
	self.TexturePathOffset = 0
	
	self.SkinRef = 0
	self.SkinFamilies = 0
	self.SkinOffset = 0
	
	self.BodyPartCount = 0
	self.BodyPartOffset = 0
	
	self.LocalAttachmentCount = 0
	self.LocalAttachmentOffset = 0
	
	self.LocalNodeCount = 0
	self.LocalNodeOffset = 0
	self.LocalNodeNameOffset = 0
	
	self.FlexDescCount = 0
	self.FlexDescOffset = 0
	
	self.FlexControllerCount = 0
	self.FlexControllerOffset = 0
	
	self.FlexRuleCount = 0
	self.FlexRuleOffset = 0
	
	self.IKChainCount = 0
	self.IKChainOffset = 0
	
	self.MouthCount = 0
	self.MouthOffset = 0
	
	self.LocalPoseParamCount = 0
	self.LocalPoseParamOffset = 0
	
	self.SurfacePropOffset = 0
	
	self.KeyValueOffset = 0
	self.KeyValueSize = 0
	
	self.LocalIKAutoplayLockCount = 0
	self.LocalIKAutoplayLockOffset = 0
	
	self.Mass = 0
	self.Contents = 0 -- CONTENTS_* flags
	
	self.ExternalModelCount = 0
	self.ExternalModelOffset = 0
	
	self.VirtualModel = 0
	
	self.AnimBlockNameOffset = 0
	self.AnimBlockCount = 0
	self.AnimBlockOffset = 0
	
	self.AnimBlockModel = 0
	
	self.BoneTableByNameOffset = 0
	
	self.VertexBase = 0
	self.IndexBase = 0
	
	self.ConstDirectionalLightDot = 0
	self.RootLOD = 0
	self.AllowedRootLODCount = 0 -- 0: All allowed
	
	self.Unused1 = 0
	self.Unused2 = 0
	
	self.FlexControllerUICount = 0
	self.FlexControllerUIOffset = 0
	
	self.Unused3 = 0
	self.Unused4 = 0
	
	self.StudioHDR2Offset = 0
	
	self.Unused5 = 0
end

function self:Deserialize (inBuffer, callback)
	callback = callback or GCodec.NullCallback
	
	self.Offset = inBuffer:GetPosition ()
	
	self.Magic = inBuffer:Bytes (4)
	
	self.Version  = inBuffer:UInt32 ()
	self.Checksum = inBuffer:UInt32 ()
	self.Name     = inBuffer:Bytes (64)
	self.FileSize = inBuffer:UInt32 ()
	
	self.EyePosition = inBuffer:Vector ()
	self.IllumPosition = inBuffer:Vector ()
	
	self.HullMin = inBuffer:Vector ()
	self.HullMax = inBuffer:Vector ()
	
	self.ViewBBMin = inBuffer:Vector ()
	self.ViewBBMax = inBuffer:Vector ()
	
	self.Flags = inBuffer:UInt32 ()
	
	self.BoneCount  = inBuffer:UInt32 ()
	self.BoneOffset = inBuffer:UInt32 ()
	
	self.BoneControllerCount  = inBuffer:UInt32 ()
	self.BoneControllerOffset = inBuffer:UInt32 ()
	
	self.HitboxSetCount  = inBuffer:UInt32 ()
	self.HitboxSetOffset = inBuffer:UInt32 ()
	
	self.LocalAnimCount  = inBuffer:UInt32 ()
	self.LocalAnimOffset = inBuffer:UInt32 ()
	
	self.LocalSequenceCount  = inBuffer:UInt32 ()
	self.LocalSequenceOffset = inBuffer:UInt32 ()
	
	self.ActivityListVersion = inBuffer:UInt32 ()
	self.EventsIndexed = inBuffer:UInt32 ()
	
	self.TextureEntryCount  = inBuffer:UInt32 ()
	self.TextureEntryOffset = inBuffer:UInt32 ()
	
	self.TexturePathCount  = inBuffer:UInt32 ()
	self.TexturePathOffset = inBuffer:UInt32 ()
	
	self.SkinRef = inBuffer:UInt32 ()
	self.SkinFamilies = inBuffer:UInt32 ()
	self.SkinOffset = inBuffer:UInt32 ()
	
	self.BodyPartCount  = inBuffer:UInt32 ()
	self.BodyPartOffset = inBuffer:UInt32 ()
	
	self.LocalAttachmentCount  = inBuffer:UInt32 ()
	self.LocalAttachmentOffset = inBuffer:UInt32 ()
	
	self.LocalNodeCount      = inBuffer:UInt32 ()
	self.LocalNodeOffset     = inBuffer:UInt32 ()
	self.LocalNodeNameOffset = inBuffer:UInt32 ()
	
	self.FlexDescriptionCount  = inBuffer:UInt32 ()
	self.FlexDescriptionOffset = inBuffer:UInt32 ()
	
	self.FlexControllerCount  = inBuffer:UInt32 ()
	self.FlexControllerOffset = inBuffer:UInt32 ()
	
	self.FlexRuleCount  = inBuffer:UInt32 ()
	self.FlexRuleOffset = inBuffer:UInt32 ()
	
	self.IKChainCount  = inBuffer:UInt32 ()
	self.IKChainOffset = inBuffer:UInt32 ()
	
	self.MouthCount  = inBuffer:UInt32 ()
	self.MouthOffset = inBuffer:UInt32 ()
	
	self.LocalPoseParametersCount  = inBuffer:UInt32 ()
	self.LocalPoseParametersOffset = inBuffer:UInt32 ()
	
	self.SurfacePropOffset = inBuffer:UInt32 ()
	
	self.KeyValueOffset = inBuffer:UInt32 ()
	self.KeyValueSize   = inBuffer:UInt32 ()
	
	self.LocalIKAutoplayLockCount  = inBuffer:UInt32 ()
	self.LocalIKAutoplayLockOffset = inBuffer:UInt32 ()
	
	self.Mass = inBuffer:Float ()
	self.Contents = inBuffer:UInt32 ()
	
	self.ExternalModelCount  = inBuffer:UInt32 ()
	self.ExternalModelOffset = inBuffer:UInt32 ()
	
	self.VirtualModel = inBuffer:UInt32 ()
	
	self.AnimBlockNameOffset = inBuffer:UInt32 ()
	self.AnimBlockCount      = inBuffer:UInt32 ()
	self.AnimBlockOffset     = inBuffer:UInt32 ()
	
	self.AnimBlockModel = inBuffer:UInt32 ()
	
	self.BoneTableByNameOffset = inBuffer:UInt32 ()
	
	self.VertexBase = inBuffer:UInt32 ()
	self.IndexBase = inBuffer:UInt32 ()
	
	self.ConstDirectionalLightDot = inBuffer:UInt32 ()
	self.RootLOD = inBuffer:UInt32 ()
	self.AllowedRootLODCount = inBuffer:UInt32 ()
	
	self.Unused1 = inBuffer:UInt8 ()
	self.Unused2 = inBuffer:UInt32 ()
	
	self.FlexControllerUICount  = inBuffer:UInt32 ()
	self.FlexControllerUIOffset = inBuffer:UInt32 ()
	
	self.Unused3 = inBuffer:UInt32 ()
	self.Unused4 = inBuffer:UInt32 ()
	
	self.StudioHDR2Offset = inBuffer:UInt32 ()
	
	self.Unused5 = inBuffer:UInt32 ()
	
	callback (true)
end