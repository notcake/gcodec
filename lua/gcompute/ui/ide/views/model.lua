local self, info = GCompute.IDE.ViewTypes:CreateType ("Model")
info:SetDocumentType ("ModelDocument")

function self:ctor (container)
	self:CreateSavableProxy ()
	
	self.ModelView = vgui.Create ("GCodecModelView", container)
	
	self:SetIcon ("icon16/image.png")
end

function self:dtor ()
end

-- Persistance
function self:LoadSession (inBuffer)
	local title = inBuffer:String ()
	
	local document = self:GetDocumentManager ():GetDocumentById (inBuffer:String ())
	if document then
		self:SetDocument (document)
	end
	self:SetTitle (title)
end

function self:SaveSession (outBuffer)
	outBuffer:String (self:GetTitle ())
	outBuffer:String (self:GetDocument () and self:GetDocument ():GetId () or "")
end

-- Internal, do not call
function self:CreateFileChangeNotificationBar ()
	if self.FileChangeNotificationBar then return end
	self.FileChangeNotificationBar = vgui.Create ("GComputeFileChangeNotificationBar", self:GetContainer ())
	self.FileChangeNotificationBar:SetVisible (false)
	self.FileChangeNotificationBar:AddEventListener ("VisibleChanged",
		function ()
			self:InvalidateLayout ()
		end
	)
	self.FileChangeNotificationBar:AddEventListener ("ReloadRequested",
		function ()
			self:GetDocument ():Reload ()
		end
	)
	self:InvalidateLayout ()
end

-- Event handlers
function self:OnDocumentChanged (oldDocument, document)
	if not document then return end
	
	self:OnDocumentLoaded (document, false)
end

function self:OnDocumentLoaded (document, reloaded)
	self.ModelView:SetModel (document:GetModel ())
end

function self:PerformLayout (w, h)
	local y = 0
	
	if self.FileChangeNotificationBar and
	   self.FileChangeNotificationBar:IsVisible () then
		self.FileChangeNotificationBar:SetPos (0, y)
		self.FileChangeNotificationBar:SetWide (w)
		y = y + self.FileChangeNotificationBar:GetTall ()
	end
	
	self.ModelView:SetPos (0, y)
	self.ModelView:SetSize (w, h - y)
end