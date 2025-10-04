local REQUIRED_KEY = "6689334512709666"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local COL_BG   = Color3.fromRGB(10,10,12)
local COL_TOP  = Color3.fromRGB(20,20,24)
local COL_CARD = Color3.fromRGB(30,30,34)
local COL_TXT  = Color3.fromRGB(235,235,240)
local COL_ACC  = Color3.fromRGB(140,100,255)

local function corner(p, r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 12); c.Parent=p return c end
local function stroke(p, col, tr) local s=Instance.new("UIStroke"); s.Color=col or Color3.fromRGB(90,90,90); s.Transparency=tr or 0.25; s.Parent=p return s end

local gui=Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name="ULTIMATE_K3_Menu"; gui.IgnoreGuiInset=true; gui.ResetOnSpawn=false; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local function notify(msg, isErr)
	local toast=Instance.new("Frame", gui)
	toast.BackgroundColor3=Color3.fromRGB(20,20,24); toast.Size=UDim2.fromOffset(360,58)
	toast.AnchorPoint=Vector2.new(1,1); toast.Position=UDim2.new(1,380,1,-16); toast.BorderSizePixel=0; toast.ClipsDescendants=true
	corner(toast,10); stroke(toast, isErr and Color3.fromRGB(220,80,80) or COL_ACC, 0.2)

	local lbl=Instance.new("TextLabel", toast)
	lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.Gotham; lbl.TextSize=14; lbl.TextWrapped=true
	lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.TextYAlignment=Enum.TextYAlignment.Center
	lbl.Text=msg; lbl.TextColor3=isErr and Color3.fromRGB(255,190,190) or COL_TXT; lbl.Position=UDim2.fromOffset(12,0); lbl.Size=UDim2.new(1,-24,1,0)

	local bar=Instance.new("Frame", toast)
	bar.BackgroundColor3=isErr and Color3.fromRGB(220,80,80) or COL_ACC; bar.BorderSizePixel=0
	bar.Size=UDim2.new(1,0,0,3); bar.Position=UDim2.new(0,0,1,-3)

	TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Position=UDim2.new(1,-16,1,-16)}):Play()
	TweenService:Create(bar, TweenInfo.new(2.8, Enum.EasingStyle.Linear), {Size=UDim2.new(0,0,0,3)}):Play()
	task.delay(3, function()
		TweenService:Create(toast, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Position=UDim2.new(1,380,1,-16)}):Play()
		task.delay(0.22,function() toast:Destroy() end)
	end)
end

local win=Instance.new("Frame", gui)
win.BackgroundColor3=COL_BG; win.BorderSizePixel=0; win.Size=UDim2.fromOffset(700,480)
win.Position=UDim2.fromScale(0.5,0.5); win.AnchorPoint=Vector2.new(0.5,0.5); win.Visible=false
corner(win,14); stroke(win, COL_ACC, 0.45)

local top=Instance.new("Frame", win)
top.BackgroundColor3=COL_TOP; top.BorderSizePixel=0; top.Size=UDim2.new(1,0,0,42)
corner(top,12); stroke(top, COL_ACC, 0.6)

local title=Instance.new("TextLabel", top)
title.BackgroundTransparency=1; title.Font=Enum.Font.GothamBold; title.TextSize=18; title.TextColor3=COL_TXT
title.TextXAlignment=Enum.TextXAlignment.Left; title.Text="ULTIMATE K3NGX1RIV Menu"
title.Position=UDim2.fromOffset(14,0); title.Size=UDim2.new(1,-140,1,0)

local function icon(txt)
	local b=Instance.new("TextButton"); b.Text=txt; b.Font=Enum.Font.GothamBold; b.TextScaled=true; b.TextColor3=COL_TXT
	b.BackgroundColor3=COL_CARD; b.BorderSizePixel=0; b.AutoButtonColor=true; b.Size=UDim2.fromOffset(28,28)
	corner(b,8); stroke(b, COL_ACC, 0.7); return b
end
local btnMin=icon("–"); btnMin.Parent=top; btnMin.AnchorPoint=Vector2.new(1,0.5); btnMin.Position=UDim2.new(1,-48,0.5,0)
local btnClose=icon("×"); btnClose.Parent=top; btnClose.AnchorPoint=Vector2.new(1,0.5); btnClose.Position=UDim2.new(1,-12,0.5,0)

local content=Instance.new("Frame", win)
content.BackgroundTransparency=1; content.Position=UDim2.fromOffset(12,54); content.Size=UDim2.new(1,-24,1,-66)

local scroll=Instance.new("ScrollingFrame", content)
scroll.BackgroundTransparency=1; scroll.ScrollBarThickness=6; scroll.Size=UDim2.fromScale(1,1)
scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local pad=Instance.new("UIPadding", scroll)
pad.PaddingTop=UDim.new(0,8); pad.PaddingLeft=UDim.new(0,8); pad.PaddingRight=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8)
local grid=Instance.new("UIGridLayout", scroll)
grid.CellPadding=UDim2.fromOffset(10,10)
grid.CellSize=UDim2.new(0.5,-12,0,56)

local reopen=Instance.new("TextButton", gui)
reopen.Text="K3 Menu"; reopen.Font=Enum.Font.GothamBold; reopen.TextSize=14; reopen.TextColor3=COL_TXT
reopen.BackgroundColor3=COL_CARD; reopen.BorderSizePixel=0; reopen.Size=UDim2.fromOffset(110,34)
reopen.Position=UDim2.new(0,14,0,14); reopen.Visible=false
corner(reopen,10); stroke(reopen, COL_ACC, 0.7)
btnClose.MouseButton1Click:Connect(function() win.Visible=false; reopen.Visible=true end)
reopen.MouseButton1Click:Connect(function() reopen.Visible=false; win.Visible=true end)

local minimized=false
btnMin.MouseButton1Click:Connect(function()
	minimized=not minimized
	local h=minimized and 42 or 480
	TweenService:Create(win, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Size=UDim2.new(win.Size.X.Scale, win.Size.X.Offset, 0, h)}):Play()
	content.Visible=not minimized
end)

do
	local dragging=false; local dragStart; local startPos
	top.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true; dragStart=i.Position; startPos=win.Position
			i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			local d=i.Position-dragStart
			win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
		end
	end)
end

local function runURL(url, label)
	notify("Loading "..(label or "script").."...", false)
	local ok, err = pcall(function()
		local src = game:HttpGet(url)
		local f = loadstring(src)
		f()
	end)
	if ok then notify((label or "Script").." executed!", false) else notify("Error: "..tostring(err), true) end
end
local function tile(text, cb)
	local b=Instance.new("TextButton", scroll)
	b.Text=text; b.Font=Enum.Font.GothamBold; b.TextSize=16; b.TextColor3=COL_TXT
	b.BackgroundColor3=COL_CARD; b.AutoButtonColor=true; b.BorderSizePixel=0
	corner(b,10); stroke(b, COL_ACC, 0.5)
	b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.08), {BackgroundColor3=Color3.fromRGB(45,45,52)}):Play() end)
	b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.08), {BackgroundColor3=COL_CARD}):Play() end)
	b.MouseButton1Click:Connect(function() pcall(cb) end)
	return b
end

local function H() local ch=LP.Character or LP.CharacterAdded:Wait() return ch:FindFirstChildOfClass("Humanoid") end
local function HRP() local ch=LP.Character or LP.CharacterAdded:Wait() return ch:FindFirstChild("HumanoidRootPart") end

local flyOn=false
local flyConn=nil
local flySpeed=60

local flyPanel=Instance.new("Frame", gui)
flyPanel.BackgroundColor3=Color3.fromRGB(18,18,26)
flyPanel.BorderSizePixel=0
flyPanel.Size=UDim2.fromOffset(360,170)
flyPanel.Position=UDim2.fromScale(0.5,0.5)
flyPanel.AnchorPoint=Vector2.new(0.5,0.5)
flyPanel.Visible=false
corner(flyPanel,12); stroke(flyPanel, COL_ACC, 0.45)

local fpTop=Instance.new("Frame", flyPanel)
fpTop.BackgroundColor3=Color3.fromRGB(24,24,32)
fpTop.BorderSizePixel=0
fpTop.Size=UDim2.new(1,0,0,36)
corner(fpTop,12); stroke(fpTop, COL_ACC, 0.5)

local fpTitle=Instance.new("TextLabel", fpTop)
fpTitle.BackgroundTransparency=1; fpTitle.Font=Enum.Font.GothamBold; fpTitle.TextSize=16
fpTitle.TextColor3=COL_TXT; fpTitle.Text="Fly Controller"
fpTitle.TextXAlignment=Enum.TextXAlignment.Left; fpTitle.Size=UDim2.new(1,-90,1,0); fpTitle.Position=UDim2.fromOffset(10,0)

local fpMin=icon("–"); fpMin.Parent=fpTop; fpMin.AnchorPoint=Vector2.new(1,0.5); fpMin.Position=UDim2.new(1,-64,0.5,0)
local fpClose=icon("×"); fpClose.Parent=fpTop; fpClose.AnchorPoint=Vector2.new(1,0.5); fpClose.Position=UDim2.new(1,-28,0.5,0)

local body=Instance.new("Frame", flyPanel)
body.BackgroundTransparency=1; body.Position=UDim2.fromOffset(10,46); body.Size=UDim2.new(1,-20,1,-56)

local speedBox=Instance.new("TextBox", body)
speedBox.BackgroundColor3=Color3.fromRGB(30,30,36); speedBox.BorderSizePixel=0
speedBox.Font=Enum.Font.Gotham; speedBox.TextSize=16; speedBox.Text=tostring(flySpeed)
speedBox.PlaceholderText="Speed"; speedBox.TextColor3=COL_TXT; speedBox.PlaceholderColor3=Color3.fromRGB(160,160,170)
speedBox.Size=UDim2.new(1,0,0,36); corner(speedBox,8); stroke(speedBox, COL_ACC, 0.6)

local row=Instance.new("Frame", body)
row.BackgroundTransparency=1; row.Size=UDim2.new(1,0,0,36); row.Position=UDim2.new(0,0,0,50)

local btnEnable=Instance.new("TextButton", row)
btnEnable.Text="Enable Fly"; btnEnable.Font=Enum.Font.GothamBold; btnEnable.TextSize=16; btnEnable.TextColor3=COL_TXT
btnEnable.BackgroundColor3=Color3.fromRGB(45,45,52); btnEnable.BorderSizePixel=0
btnEnable.Size=UDim2.new(0.5,-6,1,0); corner(btnEnable,8); stroke(btnEnable, COL_ACC, 0.5)

local btnDisable=Instance.new("TextButton", row)
btnDisable.Text="Disable Fly"; btnDisable.Font=Enum.Font.GothamBold; btnDisable.TextSize=16; btnDisable.TextColor3=COL_TXT
btnDisable.BackgroundColor3=Color3.fromRGB(45,45,52); btnDisable.BorderSizePixel=0
btnDisable.Position=UDim2.new(0.5,6,0,0); btnDisable.Size=UDim2.new(0.5,-6,1,0); corner(btnDisable,8); stroke(btnDisable, COL_ACC, 0.5)

do
	local dragging=false; local dragStart; local startPos
	fpTop.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true; dragStart=i.Position; startPos=flyPanel.Position
			i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			local d=i.Position-dragStart
			flyPanel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
		end
	end)
end
local fpMinimized=false
fpMin.MouseButton1Click:Connect(function()
	fpMinimized=not fpMinimized
	local h=fpMinimized and 36 or 170
	TweenService:Create(flyPanel, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {Size=UDim2.new(flyPanel.Size.X.Scale, flyPanel.Size.X.Offset, 0, h)}):Play()
	body.Visible=not fpMinimized
end)
fpClose.MouseButton1Click:Connect(function() flyPanel.Visible=false end)

speedBox.FocusLost:Connect(function(enter)
	if enter then
		local n=tonumber(speedBox.Text)
		if n and n>0 then flySpeed=n; notify("Fly speed set to "..n, false) else speedBox.Text=tostring(flySpeed) end
	end
end)

local function startFly()
	if flyConn then flyConn:Disconnect(); flyConn=nil end
	local hum=H(); local root=HRP()
	if not hum or not root then return end
	flyOn=true
	hum.PlatformStand=false
	hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	hum:ChangeState(Enum.HumanoidStateType.Freefall)

	local alpha = 0.25 
	flyConn = RunService.RenderStepped:Connect(function(dt)
		if not flyOn then return end
		local dir = Vector3.new()

		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z) end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z) end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z) end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z) end

		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end

		local spd = tonumber(flySpeed) or 60
		local targetVel = dir.Magnitude>0 and dir.Unit * spd or Vector3.new()
		local current = root.AssemblyLinearVelocity
		local newVel = current:Lerp(targetVel*3, alpha)
		root.AssemblyLinearVelocity = newVel

		hum:ChangeState(Enum.HumanoidStateType.Freefall)
	end)
end

local function stopFly()
	flyOn=false
	if flyConn then flyConn:Disconnect(); flyConn=nil end
	local hum=H()
	if hum then hum.PlatformStand=false end
end

btnEnable.MouseButton1Click:Connect(function() if not flyOn then startFly() end end)
btnDisable.MouseButton1Click:Connect(function() if flyOn then stopFly() end end)

tile("Fly Controller", function() flyPanel.Visible=true end)

tile("Require Executor", function()
	runURL("https://raw.githubusercontent.com/iK4oS/backdoor.exe/v6x/source.lua", "Require Executor")
end)
tile("c00lgui", function()
	runURL("https://raw.githubusercontent.com/LuaGunsX/LuasLegacyScripts/refs/heads/main/%5BGUI%5D%20c00lgui", "c00lgui")
end)
tile("INF YIELD", function()
	runURL("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Infinite Yield")
end)
tile("AimMany", function()
	runURL("https://raw.githubusercontent.com/malucomaf16/AimMany-Menu/refs/heads/main/AimMany.lua", "AimMany")
end)
tile("REMOTE-EVENTS", function()
	runURL("https://raw.githubusercontent.com/malucomaf16/show-remote-events/refs/heads/main/SRM.lua", "Remote Events")
end)
tile("Touch-Fly", function()
	runURL("https://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447", "Touch Fly")
end)
tile("THE-RAKE", function()
	runURL("https://rawscripts.net/raw/UPD-The-Rake-REMASTERED-the-rake-remastered-OP-keyless-41703", "THE-RAKE")
end)
tile("RC7-Cloud", function()
    runURL("https://pastefy.app/QNFO1zLn/raw", "RC7-Cloud")
	end)

local gate=Instance.new("Frame", gui)
gate.BackgroundColor3=Color3.fromRGB(18,18,26); gate.BorderSizePixel=0
gate.Size=UDim2.fromOffset(360,160); gate.Position=UDim2.fromScale(0.5,0.5); gate.AnchorPoint=Vector2.new(0.5,0.5)
corner(gate,12); stroke(gate, COL_ACC, 0.45)

local gateTop=Instance.new("Frame", gate)
gateTop.BackgroundColor3=Color3.fromRGB(24,24,32); gateTop.BorderSizePixel=0; gateTop.Size=UDim2.new(1,0,0,36)
corner(gateTop,12); stroke(gateTop, COL_ACC, 0.5)

local gateTitle=Instance.new("TextLabel", gateTop)
gateTitle.BackgroundTransparency=1; gateTitle.Font=Enum.Font.GothamBold; gateTitle.TextSize=16; gateTitle.TextColor3=COL_TXT
gateTitle.Text="Enter Access Key"; gateTitle.Size=UDim2.new(1,-90,1,0); gateTitle.Position=UDim2.fromOffset(10,0); gateTitle.TextXAlignment=Enum.TextXAlignment.Left

local bodyGate=Instance.new("Frame", gate)
bodyGate.BackgroundTransparency=1; bodyGate.Position=UDim2.fromOffset(10,46); bodyGate.Size=UDim2.new(1,-20,1,-56)

local keyBox=Instance.new("TextBox", bodyGate)
keyBox.BackgroundColor3=Color3.fromRGB(30,30,36); keyBox.BorderSizePixel=0
keyBox.Font=Enum.Font.Gotham; keyBox.TextSize=16; keyBox.Text=""
keyBox.PlaceholderText="Paste your key here"; keyBox.TextColor3=COL_TXT; keyBox.PlaceholderColor3=Color3.fromRGB(160,160,170)
keyBox.Size=UDim2.new(1,0,0,36); corner(keyBox,8); stroke(keyBox, COL_ACC, 0.6)

local unlock=Instance.new("TextButton", bodyGate)
unlock.Text="Unlock"; unlock.Font=Enum.Font.GothamBold; unlock.TextSize=16; unlock.TextColor3=COL_TXT
unlock.BackgroundColor3=Color3.fromRGB(45,45,52); unlock.BorderSizePixel=0
unlock.Size=UDim2.new(0.5,-6,0,36); unlock.Position=UDim2.new(0,0,0,50)
corner(unlock,8); stroke(unlock, COL_ACC, 0.5)

local cancel=Instance.new("TextButton", bodyGate)
cancel.Text="Close"; cancel.Font=Enum.Font.GothamBold; cancel.TextSize=16; cancel.TextColor3=COL_TXT
cancel.BackgroundColor3=Color3.fromRGB(45,45,52); cancel.BorderSizePixel=0
cancel.Size=UDim2.new(0.5,-6,0,36); cancel.Position=UDim2.new(0.5,6,0,50)
corner(cancel,8); stroke(cancel, COL_ACC, 0.5)

cancel.MouseButton1Click:Connect(function() gui:Destroy() end)
unlock.MouseButton1Click:Connect(function()
	local input=(keyBox.Text or ""):gsub("^%s+",""):gsub("%s+$","")
	if input==REQUIRED_KEY then
		notify("Key accepted. Welcome!", false)
		gate.Visible=false
		win.Visible=true
	else
		notify("Invalid key.", true)
	end
end)
