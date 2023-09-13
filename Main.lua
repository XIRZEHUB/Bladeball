
game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

spawn(function()
    while true do wait()
        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Kick)
            if not getgenv().TP_Ser and getgenv().Setting['Rejoin'] then
                if Kick.Name == 'ErrorPrompt' and Kick:FindFirstChild('MessageArea') and Kick.MessageArea:FindFirstChild("ErrorFrame") then
					wait(5)
                    local ts = game:GetService("TeleportService")
                    local p = game:GetService("Players").LocalPlayer
                    ts:Teleport(game.PlaceId)
                    wait(50)
                end
            end
        end)
    end
end)


if game:GetService("CoreGui"):FindFirstChild("QuartyzLib") then
    game:GetService("CoreGui"):FindFirstChild("QuartyzLib"):Destroy()
end
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

local Solaris = Instance.new("ScreenGui")
Solaris.Name = "QuartyzLib"
Solaris.Parent = game:GetService("CoreGui")
Solaris.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		local Tween = TweenService:Create(object, TweenInfo.new(0.15), {Position = pos})
		Tween:Play()
	end
	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

function Ripple(Object)
	spawn(function()
		local Circle = Instance.new("ImageLabel")
		Circle.Parent = Object
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1.000
		Circle.ZIndex = 10
		Circle.Image = "rbxassetid://266543268"
		Circle.ImageColor3 = Color3.fromRGB(210,210,210)
		Circle.ImageTransparency = 0.8
		Circle.Position = UDim2.new(0, Mouse.X - Circle.AbsolutePosition.X, 0, Mouse.Y - Circle.AbsolutePosition.Y)
		local Size = Object.AbsoluteSize.X
		TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(math.clamp(Mouse.X - Object.AbsolutePosition.X, 0, Object.AbsoluteSize.X)/Object.AbsoluteSize.X,Object,math.clamp(Mouse.Y - Object.AbsolutePosition.Y, 0, Object.AbsoluteSize.Y)/Object.AbsoluteSize.Y) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, Size = UDim2.fromOffset(Size,Size)}):Play()
		spawn(function()
			wait(0.5)
			Circle:Destroy()
		end)
	end)
end

local SolarisLib = {
	["Themes"] = {
		["Default"] = {
			MainFrame = Color3.fromRGB(25, 25, 25),
			TopBar = Color3.fromRGB(30, 30, 30),
			TextColor =  Color3.fromRGB(255,255,255),
			Menu = Color3.fromRGB(37, 37, 37),
			TabToggled = Color3.fromRGB(43,43,43),
			Button = Color3.fromRGB(30,30,30),
			ButtonHold = Color3.fromRGB(31,31,31),
			Toggle = Color3.fromRGB(30,30,30),
			ToggleFrame = Color3.fromRGB(155,155,155),
			ToggleToggled = Color3.fromRGB(22, 168, 76),
			Slider = Color3.fromRGB(30,30,30),
			SliderVal = Color3.fromRGB(25, 25, 25),
			SliderInc = Color3.fromRGB(60, 60, 60),
			Dropdown = Color3.fromRGB(30,30,30),
			DropdownItem = Color3.fromRGB(30,30,30),
			Textbox = Color3.fromRGB(30,30,30),
			TextboxFrame = Color3.fromRGB(25, 25, 25),
			Colorpicker = Color3.fromRGB(30,30,30),
			Label = Color3.fromRGB(30,30,30),
			Bind = Color3.fromRGB(30,30,30)
		},
		["Discord"] = {
			MainFrame = Color3.fromRGB(54,57,63),
			TopBar = Color3.fromRGB(47,49,54),
			TextColor =  Color3.fromRGB(255,255,255),
			Menu = Color3.fromRGB(47,49,54),
			TabToggled = Color3.fromRGB(54,57,63),
			Button = Color3.fromRGB(88,101,242),
			ButtonHold = Color3.fromRGB(71,82,196),
			Toggle = Color3.fromRGB(47,49,54),
			ToggleFrame = Color3.fromRGB(67,69,74),
			ToggleToggled = Color3.fromRGB(22, 168, 76),
			Slider = Color3.fromRGB(47,49,54),
			SliderVal = Color3.fromRGB(42,44,49),
			SliderInc = Color3.fromRGB(62,64,69),
			Dropdown = Color3.fromRGB(47,49,54),
			DropdownItem = Color3.fromRGB(47,49,54),
			Textbox = Color3.fromRGB(47,49,54),
			TextboxFrame = Color3.fromRGB(42,44,49),
			Colorpicker = Color3.fromRGB(47,49,54),
			Label = Color3.fromRGB(47,49,54),
			Bind = Color3.fromRGB(47,49,54)
		},
		["Blue"] = {
			MainFrame = Color3.fromRGB(35, 35, 50),
			TopBar = Color3.fromRGB(40, 40, 55),
			TextColor =  Color3.fromRGB(255,255,255),
			Menu = Color3.fromRGB(47, 47, 62),
			TabToggled = Color3.fromRGB(53,53,68),
			Button = Color3.fromRGB(40,40,55),
			ButtonHold = Color3.fromRGB(41,41,56),
			Toggle = Color3.fromRGB(40,40,55),
			ToggleFrame = Color3.fromRGB(65,65,80),
			ToggleToggled = Color3.fromRGB(64, 64, 120),
			Slider = Color3.fromRGB(40,40,55),
			SliderVal = Color3.fromRGB(35, 35, 50),
			SliderInc = Color3.fromRGB(70, 70, 85),
			Dropdown = Color3.fromRGB(40,40,55),
			DropdownItem = Color3.fromRGB(40,40,55),
			Textbox = Color3.fromRGB(40,40,55),
			TextboxFrame = Color3.fromRGB(35, 35, 50),
			Colorpicker = Color3.fromRGB(40,40,55),
			Label = Color3.fromRGB(40,40,55),
			Bind = Color3.fromRGB(40,40,55)
		},
		["Red"] = {
			MainFrame = Color3.fromRGB(50, 35, 35),
			TopBar = Color3.fromRGB(55, 40, 40),
			TextColor =  Color3.fromRGB(255,255,255),
			Menu = Color3.fromRGB(62, 47, 47),
			TabToggled = Color3.fromRGB(68,53,53),
			Button = Color3.fromRGB(55,40,40),
			ButtonHold = Color3.fromRGB(56,41,41),
			Toggle = Color3.fromRGB(55,40,40),
			ToggleFrame = Color3.fromRGB(80,65,65),
			ToggleToggled = Color3.fromRGB(120, 64, 64),
			Slider = Color3.fromRGB(55,40,40),
			SliderVal = Color3.fromRGB(50, 35, 35),
			SliderInc = Color3.fromRGB(85, 70, 70),
			Dropdown = Color3.fromRGB(55,40,40),
			DropdownItem = Color3.fromRGB(55,40,40),
			Textbox = Color3.fromRGB(55,40,40),
			TextboxFrame = Color3.fromRGB(50, 35, 35),
			Colorpicker = Color3.fromRGB(55,40,40),
			Label = Color3.fromRGB(55,40,40),
			Bind = Color3.fromRGB(55,40,40)
		},
		["Green"] = {
			MainFrame = Color3.fromRGB(35, 50, 35),
			TopBar = Color3.fromRGB(40, 55, 40),
			TextColor =  Color3.fromRGB(255,255,255),
			Menu = Color3.fromRGB(47, 62, 47),
			TabToggled = Color3.fromRGB(53,68,53),
			Button = Color3.fromRGB(40,55,40),
			ButtonHold = Color3.fromRGB(41,56,41),
			Toggle = Color3.fromRGB(40,55,40),
			ToggleFrame = Color3.fromRGB(65,80,65),
			ToggleToggled = Color3.fromRGB(64, 120, 64),
			Slider = Color3.fromRGB(40,55,40),
			SliderVal = Color3.fromRGB(35, 50, 35),
			SliderInc = Color3.fromRGB(70, 85, 70),
			Dropdown = Color3.fromRGB(40,55,40),
			DropdownItem = Color3.fromRGB(40,55,40),
			Textbox = Color3.fromRGB(40,55,40),
			TextboxFrame = Color3.fromRGB(35, 50, 35),
			Colorpicker = Color3.fromRGB(40,55,40),
			Label = Color3.fromRGB(40,55,40),
			Bind = Color3.fromRGB(40,55,40)
		}
	},
	Settings = {
		["Theme"] = "Default",
		CloseBind = "RightControl"
	},
	Flags = {},
	CurrentTab
}

local NotiFrame = Instance.new("Frame")
NotiFrame.Name = "NotiFrame"
NotiFrame.Parent = Solaris
NotiFrame.AnchorPoint = Vector2.new(0.5, 0)
NotiFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
NotiFrame.BorderSizePixel = 0
NotiFrame.Position =  UDim2.new(0.85, 0, 0, 0)
NotiFrame.Size = UDim2.new(0, 400, 1, 0)
NotiFrame.ClipsDescendants = true
NotiFrame.BackgroundTransparency = 1

local Notilistlayout = Instance.new("UIListLayout")
Notilistlayout.Parent = NotiFrame
Notilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
Notilistlayout.Padding = UDim.new(0, 5)
Notilistlayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

function SolarisLib:Notification(titel,text,delays)
    local TitleFrame = Instance.new("Frame")
    TitleFrame.Name = "TitleFrame"
    TitleFrame.Parent = NotiFrame
    TitleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    TitleFrame.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].MainFrame
    TitleFrame.BorderSizePixel = 0
    TitleFrame.Position =  UDim2.new(0.5, 0, 0.5,0)
    TitleFrame.Size = UDim2.new(0, 0, 0, 0)
    TitleFrame.ClipsDescendants = true

    local ConnerTitile = Instance.new("UICorner")

    ConnerTitile.CornerRadius = UDim.new(0, 4)
    ConnerTitile.Parent = TitleFrame

    TitleFrame:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 70),  UDim2.new(0.5, 0, 0.5,0), "Out", "Quad", 0.3, true)

    local imagenoti = Instance.new("ImageLabel")

    imagenoti.Parent = TitleFrame
    imagenoti.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    imagenoti.BackgroundTransparency = 1.000
    imagenoti.AnchorPoint = Vector2.new(0.5, 0.5)
    imagenoti.Position = UDim2.new(0.9, 0, 0.5, 0)
    imagenoti.Size = UDim2.new(0, 50, 0, 50)

    local txdlid = Instance.new("TextLabel")

    txdlid.Parent = TitleFrame
    txdlid.Name = "TextLabel_Tap"
    txdlid.BackgroundColor3 = Color3.fromRGB(50,50,50)
    txdlid.Size =UDim2.new(0, 160, 0,25 )
    txdlid.Font = Enum.Font.GothamBold
    txdlid.Text = titel
    txdlid.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
    txdlid.TextSize = 13.000
    txdlid.AnchorPoint = Vector2.new(0.5, 0.5)
    txdlid.Position = UDim2.new(0.23, 0, 0.3, 0)
    txdlid.TextXAlignment = Enum.TextXAlignment.Left
    txdlid.BackgroundTransparency = 1

    local LableFrame = Instance.new("Frame")
    LableFrame.Name = "LableFrame"
    LableFrame.Parent = TitleFrame
    LableFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    LableFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    LableFrame.BorderSizePixel = 0
    LableFrame.Position =  UDim2.new(0.36, 0, 0.67,0)
    LableFrame.Size = UDim2.new(0, 260, 0,25 )
    LableFrame.ClipsDescendants = true
    LableFrame.BackgroundTransparency = 1

    local TextNoti = Instance.new("TextLabel")

    TextNoti.Parent = LableFrame
    TextNoti.Name = "TextLabel_Tap"
    TextNoti.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextNoti.Size = UDim2.new(0, 260, 0,25)
    TextNoti.Font = Enum.Font.GothamBold
    TextNoti.Text = text
    TextNoti.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
    TextNoti.TextSize = 13.000
    TextNoti.AnchorPoint = Vector2.new(0.5, 0.5)
    TextNoti.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextNoti.TextXAlignment = Enum.TextXAlignment.Left
    TextNoti.BackgroundTransparency = 1

    repeat wait() until TitleFrame.Size == UDim2.new(0, 400-10, 0, 70)

    local Time = Instance.new("Frame")
    Time.Name = "Time"
    Time.Parent = TitleFrame
    Time.BackgroundColor3 =  Color3.fromRGB(255,255,255)
    Time.BorderSizePixel = 0
    Time.Position =  UDim2.new(0, 0, 0.,0)
    Time.Size = UDim2.new(0, 0,0,0)
    Time.ClipsDescendants = false
    Time.BackgroundTransparency = 0

    local ConnerTitile_Time = Instance.new("UICorner")

    ConnerTitile_Time.CornerRadius = UDim.new(0, 4)
    ConnerTitile_Time.Name = ""
    ConnerTitile_Time.Parent = Time

    Time:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 3),  UDim2.new(0., 0, 0.,0), "Out", "Sine", 0.3, true)
    repeat wait() until Time.Size == UDim2.new(0, 400-10, 0, 3)
    
    TweenService:Create(
        Time,
        TweenInfo.new(tonumber(delays), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0, 0, 0, 3)}
    ):Play()
    delay(tonumber(delays),function()
        TweenService:Create(
            TitleFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0, 0, 0, 0)}
        ):Play()
        wait(0.3)
        TitleFrame:Destroy()
    end)
end

function SolarisLib:Window(text)
	local fs = false
	local MainFrameHolder = Instance.new("Frame")
	local Shadow = Instance.new("Frame")
	local Image = Instance.new("ImageLabel")
	local Image_2 = Instance.new("ImageLabel")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TopBar = Instance.new("ImageLabel")
	local TopFrameTitle = Instance.new("TextLabel")
	local TabListBtn = Instance.new("ImageButton")
	local UIListLayout = Instance.new("UIListLayout")
	local MenuBtn = Instance.new("TextButton")
	local Ico = Instance.new("ImageLabel")
	local MenuFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Shadow_2 = Instance.new("Frame")
	local Image_3 = Instance.new("ImageLabel")
	local Image_4 = Instance.new("ImageLabel")
	local Frame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local CloseBtn = Instance.new("TextButton")
	local Ico_2 = Instance.new("ImageLabel")
	local Ico_3 = Instance.new("ImageLabel")
	local UISizeConstraint = Instance.new("UISizeConstraint")
	local UIPadding = Instance.new("UIPadding")
	local UICorner_4 = Instance.new("UICorner")
	local TopBarLine = Instance.new("Frame")
	local TabMenu = Instance.new("Frame")
	local Menu = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local TopBarLine_2 = Instance.new("Frame")
	local MenuCloseBtn = Instance.new("TextButton")
	local ImageLabel = Instance.new("ImageLabel")
	local Holder = Instance.new("Frame")
	local UIPadding_2 = Instance.new("UIPadding")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Shadow_3 = Instance.new("Frame")
	local Glow = Instance.new("ImageLabel")

	MainFrameHolder.Name = "MainFrameHolder"
	MainFrameHolder.Parent = Solaris
	MainFrameHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrameHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrameHolder.BackgroundTransparency = 1.000
	MainFrameHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrameHolder.Size = UDim2.new(0, 0, 0, 0)

	Shadow.Name = "Shadow"
	Shadow.Parent = MainFrameHolder
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow.BackgroundTransparency = 1.000
	Shadow.BorderSizePixel = 0
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 0, 1, 25)

	Image.Name = "Image"
	Image.Parent = Shadow
	Image.AnchorPoint = Vector2.new(0.5, 0.5)
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.BackgroundTransparency = 1.000
	Image.BorderSizePixel = 0
	Image.Position = UDim2.new(0.5, 0, 0.5, 0)
	Image.Size = UDim2.new(1.60000002, 0, 1.29999995, 0)
	Image.ZIndex = 7
	Image.Image = "rbxassetid://5587865193"
	Image.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Image.ImageTransparency = 0.300

	Image_2.Name = "Image"
	Image_2.Parent = Shadow
	Image_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Image_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image_2.BackgroundTransparency = 1.000
	Image_2.BorderSizePixel = 0
	Image_2.Position = UDim2.new(0.5, 0, 0.5, -5)
	Image_2.Size = UDim2.new(1.20000005, 0, 1.10000002, 0)
	Image_2.ZIndex = 7
	Image_2.Image = "rbxassetid://5587865193"
	Image_2.ImageColor3 = Color3.fromRGB(0, 0, 0)

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = MainFrameHolder
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(1, 0, 1, 0)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = MainFrame

	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
	TopBar.BackgroundTransparency = 1.000
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.ZIndex = 3
	TopBar.Image = "rbxassetid://6276641225"
	TopBar.ImageColor3 = Color3.fromRGB(30, 30, 30)
	TopBar.ScaleType = Enum.ScaleType.Slice
	TopBar.SliceCenter = Rect.new(256, 256, 256, 256)
	TopBar.SliceScale = 0.022

	TopFrameTitle.Name = "TopFrameTitle"
	TopFrameTitle.Parent = TopBar
	TopFrameTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopFrameTitle.BackgroundTransparency = 1.000
	TopFrameTitle.Position = UDim2.new(0, 33, 0, 0)
	TopFrameTitle.Size = UDim2.new(1, -33, 1, 0)
	TopFrameTitle.Font = Enum.Font.Gotham
	TopFrameTitle.Text = text
	TopFrameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	TopFrameTitle.TextSize = 14.000
	TopFrameTitle.TextXAlignment = Enum.TextXAlignment.Left

	TabListBtn.Name = "TabListBtn"
	TabListBtn.Parent = TopBar
	TabListBtn.AnchorPoint = Vector2.new(0, 0.5)
	TabListBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabListBtn.BackgroundTransparency = 1.000
	TabListBtn.Position = UDim2.new(0, 10, 0.5, 0)
	TabListBtn.Size = UDim2.new(0, 20, 0, 20)
	TabListBtn.Image = "http://www.roblox.com/asset/?id=5576439039"
	TabListBtn.ImageTransparency = 0.400

	UICorner_3.CornerRadius = UDim.new(0, 6)
	UICorner_3.Parent = Frame

	TopBarLine.Name = "TopBarLine"
	TopBarLine.Parent = TopBar
	TopBarLine.AnchorPoint = Vector2.new(0, 1)
	TopBarLine.BackgroundColor3 = Color3.fromRGB(175, 175, 175)
	TopBarLine.BackgroundTransparency = 0.900
	TopBarLine.BorderSizePixel = 0
	TopBarLine.Position = UDim2.new(0, 0, 1, 0)
	TopBarLine.Size = UDim2.new(1, 0, 0, 1)

	TabMenu.Name = "TabMenu"
	TabMenu.Parent = MainFrame
	TabMenu.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
	TabMenu.BackgroundTransparency = 1.000
	TabMenu.Position = UDim2.new(-0.370000005, -8, 0, 0)
	TabMenu.Size = UDim2.new(0.370000005, 0, 1, 0)
	TabMenu.ZIndex = 99

	Menu.Name = "Menu"
	Menu.Parent = TabMenu
	Menu.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
	Menu.Size = UDim2.new(1, 0, 1, 0)
	Menu.ZIndex = 99

	UICorner_5.CornerRadius = UDim.new(0, 6)
	UICorner_5.Parent = Menu

	Top.Name = "Top"
	Top.Parent = Menu
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 1.000
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 40)
	Top.ZIndex = 3

	TopBarLine_2.Name = "TopBarLine"
	TopBarLine_2.Parent = Top
	TopBarLine_2.AnchorPoint = Vector2.new(0, 1)
	TopBarLine_2.BackgroundColor3 = Color3.fromRGB(175, 175, 175)
	TopBarLine_2.BackgroundTransparency = 0.900
	TopBarLine_2.BorderSizePixel = 0
	TopBarLine_2.Position = UDim2.new(0, 0, 1, 0)
	TopBarLine_2.Size = UDim2.new(1, 0, 0, 1)

	MenuCloseBtn.Name = "MenuCloseBtn"
	MenuCloseBtn.Parent = Top
	MenuCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MenuCloseBtn.BackgroundTransparency = 1.000
	MenuCloseBtn.Size = UDim2.new(0, 40, 0, 40)
	MenuCloseBtn.Font = Enum.Font.SourceSans
	MenuCloseBtn.Text = ""
	MenuCloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	MenuCloseBtn.TextSize = 14.000

	ImageLabel.Parent = MenuCloseBtn
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(0, 10, 0, 10)
	ImageLabel.Image = "http://www.roblox.com/asset/?id=6521435525"

	Holder.Name = "Holder"
	Holder.Parent = Menu
	Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Holder.BackgroundTransparency = 1.000
	Holder.Position = UDim2.new(0, 0, 0, 40)
	Holder.Size = UDim2.new(1, 0, 1, -40)

	UIPadding_2.Parent = Holder
	UIPadding_2.PaddingTop = UDim.new(0, 7)

	UIListLayout_2.Parent = Holder
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

	Shadow_3.Name = "Shadow"
	Shadow_3.Parent = TabMenu
	Shadow_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow_3.BackgroundTransparency = 1.000
	Shadow_3.ClipsDescendants = true
	Shadow_3.Size = UDim2.new(1, 8, 1, 0)

	Glow.Name = "Glow"
	Glow.Parent = Shadow_3
	Glow.AnchorPoint = Vector2.new(0.5, 0.5)
	Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Glow.BackgroundTransparency = 1.000
	Glow.BorderSizePixel = 0
	Glow.Position = UDim2.new(0.5, -6, 0.5, 0)
	Glow.Size = UDim2.new(1, 28, 1, 28)
	Glow.ZIndex = 0
	Glow.Image = "rbxassetid://4996891970"
	Glow.ImageColor3 = Color3.fromRGB(15, 15, 15)
	Glow.ScaleType = Enum.ScaleType.Slice
	Glow.SliceCenter = Rect.new(20, 20, 280, 280)

	local ContainerFolder = Instance.new("Folder")

	ContainerFolder.Name = "ContainerFolder"
	ContainerFolder.Parent = MainFrame

	TabListBtn.MouseButton1Click:Connect(function()
		TweenService:Create(
			TabMenu,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Position = UDim2.new(0,0,0,0)}
		):Play()
	end)

	MenuCloseBtn.MouseButton1Click:Connect(function()
		TweenService:Create(
			TabMenu,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Position = UDim2.new(-0.37, -8, 0, 0)}
		):Play()
	end)

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(
			Ico,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end)

	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(
			Ico,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0.4}
		):Play()
	end)

	MenuBtn.MouseEnter:Connect(function()
		TweenService:Create(
			Ico,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end)

	MenuBtn.MouseLeave:Connect(function()
		TweenService:Create(
			Ico,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0.4}
		):Play()
	end)

	TabListBtn.MouseEnter:Connect(function()
		TweenService:Create(
			TabListBtn,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end)

	TabListBtn.MouseLeave:Connect(function()
		TweenService:Create(
			TabListBtn,
			TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0.4}
		):Play()
	end)

	MenuBtn.MouseButton1Click:Connect(function()
		MenuFrame.Visible = not MenuFrame.Visible
	end)

	local uitoggled = false
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode.Name == SolarisLib.Settings.CloseBind then
			if uitoggled == false then
				MainFrameHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
				uitoggled = true
				MainFrameHolder.Visible = false
			else
				MainFrameHolder.Visible = true
				MainFrameHolder:TweenSize(UDim2.new(0, 480, 0, 380), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
				uitoggled = false
			end
		end
	end)

	MainFrameHolder:TweenSize(UDim2.new(0, 480, 0, 380), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
	MakeDraggable(TopBar, MainFrameHolder)

    spawn(function()
        while wait() do
			pcall(function()
				MainFrame.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].MainFrame
				TopBar.ImageColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TopBar
				TabListBtn.ImageColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
				TopFrameTitle.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
				Menu.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Menu
				MenuCloseBtn.ImageLabel.ImageColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
			end)
        end
    end)

	local TabList = {}
	function TabList:Tab(text)
		local Tab = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local UIPadding = Instance.new("UIPadding")

		Tab.Name = "Tab"
		Tab.Parent = Holder
		Tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Tab.BackgroundTransparency = 1.000
		Tab.Size = UDim2.new(0.87, 0, 0, 30)
		Tab.Font = Enum.Font.Gotham
		Tab.Text = text
		Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tab.TextSize = 13.000
		Tab.TextTransparency = 0.400
		Tab.TextXAlignment = Enum.TextXAlignment.Left

		UICorner.CornerRadius = UDim.new(0, 8)
		UICorner.Parent = Tab

		UIPadding.Parent = Tab
		UIPadding.PaddingLeft = UDim.new(0, 5)

		local Container = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local UIPadding = Instance.new("UIPadding")

		Container.Name = "Container"
		Container.Parent = ContainerFolder
		Container.Active = true
		Container.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		Container.BackgroundTransparency = 1.000
		Container.BorderSizePixel = 0
		Container.Position = UDim2.new(0, 0, 0, 42)
		Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Container.CanvasSize = UDim2.new(0, 0, 0, 0)
		Container.Selectable = false
		Container.Size = UDim2.new(1, 0, 1, -42)
		Container.ScrollBarThickness = 4
		Container.Visible = false

		UIListLayout.Parent = Container
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 6)

		UIPadding.Parent = Container
		UIPadding.PaddingTop = UDim.new(0, 6)

		if fs == false then
			fs = true
			Container.Visible = true
			Tab.UIPadding.PaddingLeft = UDim.new(0,10)
			Tab.TextTransparency = 0
			Tab.BackgroundTransparency = 0  
			SolarisLib.CurrentTab = Container  
		end

		Tab.MouseButton1Click:Connect(function()
			for i,v in next, Holder:GetChildren() do
				if v:IsA("TextButton") then
					TweenService:Create(
						v,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0.4}
					):Play() 
					TweenService:Create(
						v,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play() 
					TweenService:Create(
						v.UIPadding,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{PaddingLeft = UDim.new(0,5)}
					):Play() 
				end    
				TweenService:Create(
					Tab,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play() 
				TweenService:Create(
					Tab,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play() 
				TweenService:Create(
					Tab.UIPadding,
					TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{PaddingLeft = UDim.new(0,10)}
				):Play() 
			end   
			for i,v in next, ContainerFolder:GetChildren() do
				if v.Name == "Container" then
					v.Visible = false
				end    
				Container.Visible = true
			end
			local tabtoggledname = Tab.Name
			TweenService:Create(
				TabMenu,
				TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Position = UDim2.new(-0.37, -8, 0, 0)}
			):Play()
		end)

		local SectionHold = {}
		function SectionHold:Section(text)
			local Section = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local UIListLayout = Instance.new("UIListLayout")

			Section.Name = "Section"
			Section.Parent = Container
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 1.000
			Section.Size = UDim2.new(0.899999976, 0, 0, 0)

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = Section
			SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionTitle.BackgroundTransparency = 1.000
			SectionTitle.Size = UDim2.new(0, 200, 0, 10)
			SectionTitle.Font = Enum.Font.Gotham
			SectionTitle.Text = text
			SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionTitle.TextSize = 12.000
			SectionTitle.TextTransparency = 0.380
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

			UIListLayout.Parent = Section
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 6)

			spawn(function()
				while wait() do
					pcall(function()
						SectionTitle.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						Section.Size = UDim2.new(0.9,0,0, UIListLayout.AbsoluteContentSize.Y + 15)
					end)
				end
			end)

			local Libfunc = {}
			function Libfunc:Button(text, callback)
				local Button = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local Glow = Instance.new("ImageLabel")
				local ButtonText = Instance.new("TextLabel")

				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
				Button.Size = UDim2.new(1, 0, 0, 32)
				Button.AutoButtonColor = false
				Button.Font = Enum.Font.SourceSans
				Button.Text = ""
				Button.TextColor3 = Color3.fromRGB(0, 0, 0)
				Button.TextSize = 14.000
				Button.TextTransparency = 1.000
				Button.TextXAlignment = Enum.TextXAlignment.Left
				Button.ClipsDescendants = true

				UICorner.CornerRadius = UDim.new(0, 6)
				UICorner.Parent = Button

				Glow.Name = "Glow"
				Glow.Parent = Button
				Glow.AnchorPoint = Vector2.new(0.5, 0.5)
				Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Glow.BackgroundTransparency = 1.000
				Glow.BorderSizePixel = 0
				Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
				Glow.Size = UDim2.new(1, 30, 1, 30)
				Glow.ZIndex = 0
				Glow.Image = "rbxassetid://4996891970"
				Glow.ImageColor3 = Color3.fromRGB(10, 10, 10)
				Glow.ImageTransparency = 0.860
				Glow.ScaleType = Enum.ScaleType.Slice
				Glow.SliceCenter = Rect.new(20, 20, 280, 280)

				ButtonText.Name = "ButtonText"
				ButtonText.Parent = Button
				ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.BackgroundTransparency = 1.000
				ButtonText.Position = UDim2.new(0, 10, 0, 0)
				ButtonText.Size = UDim2.new(1, -10, 1, 0)
				ButtonText.Font = Enum.Font.Gotham
				ButtonText.Text = text
				ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.TextSize = 14.000
				ButtonText.TextXAlignment = Enum.TextXAlignment.Left

				Button.MouseButton1Click:Connect(function()
					pcall(callback)
					Ripple(Button)
					TweenService:Create(
						UICorner,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{CornerRadius = UDim.new(0, 12)}
					):Play()
					wait(.1)
					TweenService:Create(
						UICorner,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{CornerRadius = UDim.new(0, 6)}
					):Play()
				end)

				local Holding = false
				Button.MouseEnter:Connect(function()
					Holding = true
				end)
				Button.MouseLeave:Connect(function()
					Holding = false
				end)

				spawn(function()
					while wait() do
						pcall(function()
							Button.BackgroundColor3 = Holding and SolarisLib.Themes[SolarisLib.Settings.Theme].ButtonHold or SolarisLib.Themes[SolarisLib.Settings.Theme].Button
							Button.ButtonText.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)
			end

			function Libfunc:Toggle(text, default, callback)
				local togglefunc = {}
				local toggled = default or false
				local Toggle = Instance.new("TextButton")
				local UICorner = Instance.new("UICorner")
				local Glow = Instance.new("ImageLabel")
				local ToggleText = Instance.new("TextLabel")
				local ToggleFrame = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local ToggleToggled = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local ToggleIco = Instance.new("ImageLabel")

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
				Toggle.Size = UDim2.new(1, 0, 0, 32)
				Toggle.AutoButtonColor = false
				Toggle.Font = Enum.Font.SourceSans
				Toggle.Text = ""
				Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.TextSize = 14.000
				Toggle.TextTransparency = 1.000
				Toggle.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 6)
				UICorner.Parent = Toggle

				Glow.Name = "Glow"
				Glow.Parent = Toggle
				Glow.AnchorPoint = Vector2.new(0.5, 0.5)
				Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Glow.BackgroundTransparency = 1.000
				Glow.BorderSizePixel = 0
				Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
				Glow.Size = UDim2.new(1, 30, 1, 30)
				Glow.ZIndex = 0
				Glow.Image = "rbxassetid://4996891970"
				Glow.ImageColor3 = Color3.fromRGB(10, 10, 10)
				Glow.ImageTransparency = 0.860
				Glow.ScaleType = Enum.ScaleType.Slice
				Glow.SliceCenter = Rect.new(20, 20, 280, 280)

				ToggleText.Name = "ToggleText"
				ToggleText.Parent = Toggle
				ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleText.BackgroundTransparency = 1.000
				ToggleText.Position = UDim2.new(0, 10, 0, 0)
				ToggleText.Size = UDim2.new(0, 1, 1, 0)
				ToggleText.Font = Enum.Font.Gotham
				ToggleText.Text = text
				ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleText.TextSize = 14.000
				ToggleText.TextXAlignment = Enum.TextXAlignment.Left

				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Toggle
				ToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
				ToggleFrame.Position = UDim2.new(1, -10, 0.5, 0)
				ToggleFrame.Size = UDim2.new(0, 20, 0, 20)

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = ToggleFrame

				ToggleToggled.Name = "ToggleToggled"
				ToggleToggled.Parent = ToggleFrame
				ToggleToggled.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleToggled.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
				ToggleToggled.Position = UDim2.new(0.5, 0, 0.5, 0)
				ToggleToggled.Size = UDim2.new(1, -2, 1, -2)

				UICorner_3.CornerRadius = UDim.new(0, 4)
				UICorner_3.Parent = ToggleToggled

				ToggleIco.Name = "ToggleIco"
				ToggleIco.Parent = ToggleToggled
				ToggleIco.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleIco.BackgroundTransparency = 1.000
				ToggleIco.Position = UDim2.new(0.5, 0, 0.5, 0)
				ToggleIco.Size = UDim2.new(1, -2, 1, -2)
				ToggleIco.Image = "http://www.roblox.com/asset/?id=6031094667"
				ToggleIco.ImageTransparency = 1.000

				function togglefunc:Set(value)
					TweenService:Create(ToggleIco,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = value and 0 or 1}):Play()
					TweenService:Create(ToggleIco,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = value and UDim2.new(1,-2,1,-2) or UDim2.new(1,-6,1,-6)}):Play()
					return callback(value)
				end

				Toggle.MouseButton1Click:Connect(function()
					toggled = not toggled
					togglefunc:Set(toggled)           
				end)

				spawn(function()
					while wait() do
						pcall(function()
							ToggleToggled.BackgroundColor3 = toggled and SolarisLib.Themes[SolarisLib.Settings.Theme].ToggleToggled or SolarisLib.Themes[SolarisLib.Settings.Theme].Toggle
							ToggleFrame.BackgroundColor3 = toggled and SolarisLib.Themes[SolarisLib.Settings.Theme].ToggleToggled or SolarisLib.Themes[SolarisLib.Settings.Theme].ToggleFrame
							Toggle.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Toggle
							ToggleText.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				togglefunc:Set(toggled)
				return togglefunc
			end

			function Libfunc:Slider(text, min, max, start, callback)
				local Slider = Instance.new("Frame")
				local SliderText = Instance.new("TextLabel")
				local SliderFrame = Instance.new("Frame")
				local SliderVal = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local BarCorner = Instance.new("UICorner")
				local BarCorner2 = Instance.new("UICorner")

				Slider.Name = "MainSliderFrame"
				Slider.Parent = Section
				Slider.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
				Slider.BorderSizePixel = 0
				Slider.Size = UDim2.new(1, 0, 0, 48)

				UICorner.Name = "MainCorner"
				UICorner.Parent = Slider

				SliderText.Name = "SliderTitle"
				SliderText.Parent = Slider
				SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderText.BackgroundTransparency = 1.000
				SliderText.BorderSizePixel = 0
				SliderText.Position = UDim2.new(0, 10, 0, 0)
				SliderText.Size = UDim2.new(0, 1, 0.5, 0)
				SliderText.Font = Enum.Font.Gotham
				SliderText.Text = text .. " : " .. tostring(start and math.floor((start / max) * (max - min) + min) or 0)
				SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderText.TextSize = 14.000
				SliderText.TextXAlignment = Enum.TextXAlignment.Left

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = Slider
				SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderFrame.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
				SliderFrame.BorderSizePixel = 0
				SliderFrame.Position = UDim2.new(0.5, 0, 0.7, 0)
				SliderFrame.Size = UDim2.new(0.95, 0, 0, 5)

				BarCorner.Parent = SliderFrame

				SliderVal.Name = "CurrentValueFrame"
				SliderVal.Parent = SliderFrame
				SliderVal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderVal.BorderSizePixel = 0
				SliderVal.Size = UDim2.new((start or 0) / max, 0, 0, 5)

				BarCorner2.Parent = SliderVal

				local Dragging = false
				local function move(input)
					local pos = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),0,1,0)
					SliderVal:TweenSize(pos, "Out", "Sine", 0.1, true)
					local SliderPrecise = ((pos.X.Scale * max) / max) * (max - min) + min
					local SliderNonPrecise = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
					local SliderValue = SliderNonPrecise or SliderPrecise
					SliderValue = tonumber(string.format("%.2f", SliderValue))
					SliderText.Text = text .. " : " .. tostring(SliderValue)
					pcall(callback, SliderValue)
				end

				SliderFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						move(input)
						Dragging = true
					end
				end)

				SliderFrame.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)

				spawn(function()
					while wait() do
						pcall(function()
							Slider.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Slider
							SliderFrame.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].SliderVal
							SliderVal.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].SliderInc
							SliderText.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)
			end

			function Libfunc:Dropdown(text, list, callback)
				local Dropfunc = {}
				local dropdowntoggled = false
				local Dropdown = Instance.new("Frame")
				local Btn = Instance.new("TextButton")
				local Title = Instance.new("TextLabel")
				local Ico = Instance.new("ImageLabel")
				local UICorner = Instance.new("UICorner")

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Section
				Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.ClipsDescendants = true
				Dropdown.Size = UDim2.new(1, 0, 0, 32)

				Btn.Name = "Btn"
				Btn.Parent = Dropdown
				Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Btn.Size = UDim2.new(1, 0, 0, 32)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.SourceSans
				Btn.Text = ""
				Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
				Btn.TextSize = 14.000

				Title.Name = "Title"
				Title.Parent = Btn
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 10, 0, 0)
				Title.Selectable = true
				Title.Size = UDim2.new(0, 1, 0, 32)
				Title.Font = Enum.Font.Gotham
				Title.Text = text .. " : N/A"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Ico.Name = "Ico"
				Ico.Parent = Btn
				Ico.AnchorPoint = Vector2.new(1, 0.5)
				Ico.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Ico.BackgroundTransparency = 1.000
				Ico.Position = UDim2.new(1, -10, 0.5, 0)
				Ico.Size = UDim2.new(0, 20, 1, -12)
				Ico.Image = "http://www.roblox.com/asset/?id=6034818379"
				Ico.ImageTransparency = 0.400

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = Btn

				local HolderFrame = Instance.new("Frame")
				local Holder = Instance.new("ScrollingFrame")
				local Layout = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")

				HolderFrame.Name = "HolderFrame"
				HolderFrame.Parent = Dropdown
				HolderFrame.BackgroundTransparency = 1
				HolderFrame.ClipsDescendants = true
				HolderFrame.Position = UDim2.new(0, 0, 0, 38)
				HolderFrame.Selectable = true
				HolderFrame.Size = UDim2.new(1, 0, 0, 0)
				HolderFrame.Visible = false

				Holder.Name = "Holder"
				Holder.Parent = HolderFrame
				Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Holder.BackgroundTransparency = 1.000
				Holder.ClipsDescendants = true
				Holder.Position = UDim2.new(0, 0, 0, 0)
				Holder.Size = UDim2.new(1, 0, 0, 0)
				Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
				Holder.ScrollBarThickness = 4
				Holder.BorderSizePixel = 0
				Holder.Visible = false

				Layout.Name = "Layout"
				Layout.Parent = Holder
				Layout.SortOrder = Enum.SortOrder.LayoutOrder
				Layout.Padding = UDim.new(0, 4)

				UIPadding.Parent = Holder
				UIPadding.PaddingTop = UDim.new(0, 2)
				UIPadding.PaddingLeft = UDim.new(0, 12)

				Btn.MouseButton1Click:Connect(function()
					dropdowntoggled = not dropdowntoggled
					TweenService:Create(
						Dropdown,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
					):Play()
					TweenService:Create(
						Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = dropdowntoggled and 180 or 0}
					):Play()
					wait(.16)
					Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					Holder.Visible = not Holder.Visible
					HolderFrame.Visible = not HolderFrame.Visible
				end)

				local framesize = 0
				local itemcount = 0
				for i,v in next, list do
					itemcount = itemcount + 1
					if itemcount == 1 then
						framesize = 32
					elseif itemcount == 2 then
						framesize = 61
					elseif itemcount >= 3 then
						framesize = 90
					end

					local Item = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
					local ItemText = Instance.new("TextLabel")

					Item.Name = "Item"
					Item.Parent = Holder
					Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					Item.Size = UDim2.new(0.9623000, 0, 0, 28)
					Item.BorderSizePixel = 0
					Item.AutoButtonColor = false
					Item.Font = Enum.Font.Gotham
					Item.Text = ""
					Item.TextColor3 = Color3.fromRGB(255, 255, 255)
					Item.TextSize = 14.000
					Item.TextTransparency = 0.400
					Item.TextXAlignment = Enum.TextXAlignment.Left
					Item.ClipsDescendants = true

					UICorner.CornerRadius = UDim.new(0, 6)
					UICorner.Parent = Item

					ItemText.Name = "ItemText"
					ItemText.Parent = Item
					ItemText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.BackgroundTransparency = 1.000
					ItemText.Position = UDim2.new(0, 5, 0, 0)
					ItemText.Size = UDim2.new(0, 1, 1, 0)
					ItemText.Font = Enum.Font.Gotham
					ItemText.Text = v
					ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.TextSize = 13.000
					ItemText.TextTransparency = 0.400
					ItemText.TextXAlignment = Enum.TextXAlignment.Left

					Item.MouseEnter:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)

					Item.MouseLeave:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.400}
						):Play()
					end)

					Item.MouseButton1Click:Connect(function()
						dropdowntoggled = not dropdowntoggled
						Ripple(Item)
						Title.Text = text .. " : " .. v
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
						):Play()
						TweenService:Create(
							Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Rotation = dropdowntoggled and 180 or 0}
						):Play()
						wait(.16)
						Dropdown.Size = UDim2.new(1, 0, 0, 32)
						Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
						Holder.Visible = not Holder.Visible
						HolderFrame.Visible = not HolderFrame.Visible
						return pcall(callback, v)
					end)
					
					Holder.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 5)
					Holder.Size = UDim2.new(1, 0, 0, framesize)
					HolderFrame.Size = UDim2.new(1, 0, 0, framesize)

					spawn(function()
						while wait() do
							pcall(function()
								Item.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].DropdownItem
								Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							end)
						end
					end)
				end

				function Dropfunc:Clear()
					dropdowntoggled = false
					itemcount = 0
					framesize = 0
					for i,v in next, Holder:GetChildren() do
						if v.Name == "Item" then
							v:Destroy()
						end
					end
					Title.Text = text .. " : " .. "N/A"
					TweenService:Create(
						Dropdown,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
					):Play()
					TweenService:Create(
						Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = dropdowntoggled and 180 or 0}
					):Play()
					wait(.16)
					Dropdown.Size = UDim2.new(1, 0, 0, 32)
					Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					HolderFrame.Size = UDim2.new(1, 0, 0, 0)
					Holder.Visible = false
					HolderFrame.Visible = false
				end

				function Dropfunc:Add(textadd)
					itemcount = itemcount + 1
					if itemcount == 1 then
						framesize = 29
					elseif itemcount == 2 then
						framesize = 58
					elseif itemcount >= 3 then
						framesize = 87
					end

					local Item = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
					local ItemText = Instance.new("TextLabel")

					Item.Name = "Item"
					Item.Parent = Holder
					Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					Item.Size = UDim2.new(0.9623000, 0, 0, 30)
					Item.BorderSizePixel = 0
					Item.AutoButtonColor = false
					Item.Font = Enum.Font.Gotham
					Item.Text = ""
					Item.TextColor3 = Color3.fromRGB(255, 255, 255)
					Item.TextSize = 14.000
					Item.TextTransparency = 0.400
					Item.TextXAlignment = Enum.TextXAlignment.Left
					Item.ClipsDescendants = true

					UICorner.CornerRadius = UDim.new(0, 6)
					UICorner.Parent = Item

					ItemText.Name = "ItemText"
					ItemText.Parent = Item
					ItemText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.BackgroundTransparency = 1.000
					ItemText.Position = UDim2.new(0, 5, 0, 0)
					ItemText.Size = UDim2.new(0, 1, 1, 0)
					ItemText.Font = Enum.Font.Gotham
					ItemText.Text = textadd
					ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.TextSize = 13.000
					ItemText.TextTransparency = 0.400
					ItemText.TextXAlignment = Enum.TextXAlignment.Left

					Item.MouseEnter:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)

					Item.MouseLeave:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.400}
						):Play()
					end)

					Item.MouseButton1Click:Connect(function()
						dropdowntoggled = not dropdowntoggled
						Ripple(Item)
						Title.Text = text .. " : " .. textadd
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
						):Play()
						TweenService:Create(
							Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Rotation = dropdowntoggled and 180 or 0}
						):Play()
						wait(.16)
						Dropdown.Size = UDim2.new(1, 0, 0, 32)
						Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
						Holder.Visible = not Holder.Visible
						HolderFrame.Visible = not HolderFrame.Visible
						return pcall(callback, textadd)
					end)
					
					Holder.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 5)
					Holder.Size = UDim2.new(1, 0, 0, framesize)
					HolderFrame.Size = UDim2.new(1, 0, 0, framesize)

					spawn(function()
						while wait() do
							pcall(function()
								Item.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].DropdownItem
								Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							end)
						end
					end)
				end

				function Dropfunc:Set(val)
					Title.Text = text .. " : " .. val
					return callback(val)
				end

				spawn(function()
					while wait() do
						pcall(function()
							Btn.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Dropdown
							Btn.Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							Btn.Ico.ImageColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				return Dropfunc
			end

			function Libfunc:MultiDropdown(text, list, callback)
				local DropdownList = {}
				local Dropfunc = {}
				local dropdowntoggled = false
				local Dropdown = Instance.new("Frame")
				local Btn = Instance.new("TextButton")
				local Title = Instance.new("TextLabel")
				local Ico = Instance.new("ImageLabel")
				local UICorner = Instance.new("UICorner")

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Section
				Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.ClipsDescendants = true
				Dropdown.Size = UDim2.new(1, 0, 0, 32)

				Btn.Name = "Btn"
				Btn.Parent = Dropdown
				Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Btn.Size = UDim2.new(1, 0, 0, 32)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.SourceSans
				Btn.Text = ""
				Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
				Btn.TextSize = 14.000

				Title.Name = "Title"
				Title.Parent = Btn
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 10, 0, 0)
				Title.Selectable = true
				Title.Size = UDim2.new(0, 1, 0, 32)
				Title.Font = Enum.Font.Gotham
				Title.Text = text .. " : N/A"
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Ico.Name = "Ico"
				Ico.Parent = Btn
				Ico.AnchorPoint = Vector2.new(1, 0.5)
				Ico.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Ico.BackgroundTransparency = 1.000
				Ico.Position = UDim2.new(1, -10, 0.5, 0)
				Ico.Size = UDim2.new(0, 20, 1, -12)
				Ico.Image = "http://www.roblox.com/asset/?id=6034818379"
				Ico.ImageTransparency = 0.400

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = Btn

				local HolderFrame = Instance.new("Frame")
				local Holder = Instance.new("ScrollingFrame")
				local Layout = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")

				HolderFrame.Name = "HolderFrame"
				HolderFrame.Parent = Dropdown
				HolderFrame.BackgroundTransparency = 1
				HolderFrame.ClipsDescendants = true
				HolderFrame.Position = UDim2.new(0, 0, 0, 38)
				HolderFrame.Selectable = true
				HolderFrame.Size = UDim2.new(1, 0, 0, 0)
				HolderFrame.Visible = false

				Holder.Name = "Holder"
				Holder.Parent = HolderFrame
				Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Holder.BackgroundTransparency = 1.000
				Holder.ClipsDescendants = true
				Holder.Position = UDim2.new(0, 0, 0, 0)
				Holder.Size = UDim2.new(1, 0, 0, 0)
				Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
				Holder.ScrollBarThickness = 4
				Holder.BorderSizePixel = 0
				Holder.Visible = false

				Layout.Name = "Layout"
				Layout.Parent = Holder
				Layout.SortOrder = Enum.SortOrder.LayoutOrder
				Layout.Padding = UDim.new(0, 4)

				UIPadding.Parent = Holder
				UIPadding.PaddingTop = UDim.new(0, 2)
				UIPadding.PaddingLeft = UDim.new(0, 12)

				Btn.MouseButton1Click:Connect(function()
					dropdowntoggled = not dropdowntoggled
					TweenService:Create(
						Dropdown,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
					):Play()
					TweenService:Create(
						Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = dropdowntoggled and 180 or 0}
					):Play()
					wait(.16)
					Dropdown.Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)
					Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					Holder.Visible = not Holder.Visible
					HolderFrame.Visible = not HolderFrame.Visible
				end)

				local framesize = 0
				local itemcount = 0
				for i,v in next, list do
					itemcount = itemcount + 1
					if itemcount == 1 then
						framesize = 32
					elseif itemcount == 2 then
						framesize = 61
					elseif itemcount >= 3 then
						framesize = 90
					end

					local Item = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
					local ItemText = Instance.new("TextLabel")

					Item.Name = "Item"
					Item.Parent = Holder
					Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					Item.Size = UDim2.new(0.9623000, 0, 0, 28)
					Item.BorderSizePixel = 0
					Item.AutoButtonColor = false
					Item.Font = Enum.Font.Gotham
					Item.Text = ""
					Item.TextColor3 = Color3.fromRGB(255, 255, 255)
					Item.TextSize = 14.000
					Item.TextTransparency = 0.400
					Item.TextXAlignment = Enum.TextXAlignment.Left
					Item.ClipsDescendants = true

					UICorner.CornerRadius = UDim.new(0, 6)
					UICorner.Parent = Item

					ItemText.Name = "ItemText"
					ItemText.Parent = Item
					ItemText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.BackgroundTransparency = 1.000
					ItemText.Position = UDim2.new(0, 5, 0, 0)
					ItemText.Size = UDim2.new(0, 1, 1, 0)
					ItemText.Font = Enum.Font.Gotham
					ItemText.Text = v
					ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.TextSize = 13.000
					ItemText.TextTransparency = 0.400
					ItemText.TextXAlignment = Enum.TextXAlignment.Left

					Item.MouseEnter:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)

					Item.MouseLeave:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.400}
						):Play()
					end)

					Item.MouseButton1Click:Connect(function()
						Ripple(Item)
						if table.find(DropdownList, v) then				
							table.remove(DropdownList, table.find(DropdownList, v))
							Title.Text = text .. " : " .. table.concat(DropdownList, ", ")
							callback(DropdownList)
						else
							table.insert(DropdownList, v)
							Title.Text = text .. " : " .. table.concat(DropdownList, ", ")
							callback(DropdownList)
						end
						return pcall(callback, DropdownList)
					end)
					
					Holder.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 5)
					Holder.Size = UDim2.new(1, 0, 0, framesize)
					HolderFrame.Size = UDim2.new(1, 0, 0, framesize)

					spawn(function()
						while wait() do
							pcall(function()
								Item.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].DropdownItem
								Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							end)
						end
					end)
				end

				function Dropfunc:Clear()
					dropdowntoggled = false
					itemcount = 0
					framesize = 0
					for i,v in next, Holder:GetChildren() do
						if v.Name == "Item" then
							v:Destroy()
						end
					end
					Title.Text = text .. " : "
					TweenService:Create(
						Dropdown,
						TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = dropdowntoggled and UDim2.new(1, 0, 0, 42 + HolderFrame.AbsoluteSize.Y) or UDim2.new(1, 0, 0, 32)}
					):Play()
					TweenService:Create(
						Ico,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = dropdowntoggled and 180 or 0}
					):Play()
					wait(.16)
					Dropdown.Size = UDim2.new(1, 0, 0, 32)
					Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					HolderFrame.Size = UDim2.new(1, 0, 0, 0)
					Holder.Visible = false
					HolderFrame.Visible = false
				end

				function Dropfunc:Add(textadd)
					itemcount = itemcount + 1
					if itemcount == 1 then
						framesize = 29
					elseif itemcount == 2 then
						framesize = 58
					elseif itemcount >= 3 then
						framesize = 87
					end

					local Item = Instance.new("TextButton")
					local UICorner = Instance.new("UICorner")
					local ItemText = Instance.new("TextLabel")

					Item.Name = "Item"
					Item.Parent = Holder
					Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					Item.Size = UDim2.new(0.9623000, 0, 0, 30)
					Item.BorderSizePixel = 0
					Item.AutoButtonColor = false
					Item.Font = Enum.Font.Gotham
					Item.Text = ""
					Item.TextColor3 = Color3.fromRGB(255, 255, 255)
					Item.TextSize = 14.000
					Item.TextTransparency = 0.400
					Item.TextXAlignment = Enum.TextXAlignment.Left
					Item.ClipsDescendants = true

					UICorner.CornerRadius = UDim.new(0, 6)
					UICorner.Parent = Item

					ItemText.Name = "ItemText"
					ItemText.Parent = Item
					ItemText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.BackgroundTransparency = 1.000
					ItemText.Position = UDim2.new(0, 5, 0, 0)
					ItemText.Size = UDim2.new(0, 1, 1, 0)
					ItemText.Font = Enum.Font.Gotham
					ItemText.Text = textadd
					ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
					ItemText.TextSize = 13.000
					ItemText.TextTransparency = 0.400
					ItemText.TextXAlignment = Enum.TextXAlignment.Left

					Item.MouseEnter:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)

					Item.MouseLeave:Connect(function()
						TweenService:Create(
							ItemText,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.400}
						):Play()
					end)

					Item.MouseButton1Click:Connect(function()
						Ripple(Item)
						if table.find(DropdownList, textadd) then				
							table.remove(DropdownList, table.find(DropdownList, textadd))
							Title.Text = text .. " : " .. table.concat(DropdownList, ", ")
							callback(DropdownList)
						else
							table.insert(DropdownList, textadd)
							Title.Text = text .. " : " .. table.concat(DropdownList, ", ")
							callback(DropdownList)
						end
						return pcall(callback, DropdownList)
					end)
					
					Holder.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 5)
					Holder.Size = UDim2.new(1, 0, 0, framesize)
					HolderFrame.Size = UDim2.new(1, 0, 0, framesize)

					spawn(function()
						while wait() do
							pcall(function()
								Item.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].DropdownItem
								Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							end)
						end
					end)
				end

				function Dropfunc:Set(val)
					if type(val) == "table" then
						for i,v in pairs(val) do
							table.insert(DropdownList, v)
						end
					else
						table.insert(DropdownList, val)
					end
					Title.Text = text .. " : " .. table.concat(DropdownList, ", ")
					return callback(DropdownList)
				end

				spawn(function()
					while wait() do
						pcall(function()
							Btn.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Dropdown
							Btn.Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							Btn.Ico.ImageColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				return Dropfunc
			end
			
			function Libfunc:Colorpicker(text, preset, callback)
				local cpkfunc = {}
				local colorpickertoggled = false
				local ColorH, ColorS, ColorV = 1, 1, 1
				local Colorpicker = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Btn = Instance.new("TextButton")
				local Box = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Colorpicker_2 = Instance.new("TextLabel")
				local Hue = Instance.new("ImageLabel")
				local HueCorner = Instance.new("UICorner")
				local HueSelection = Instance.new("ImageLabel")
				local HueGradient = Instance.new("UIGradient")
				local Color = Instance.new("ImageLabel")
				local ColorCorner = Instance.new("UICorner")
				local ColorSelection = Instance.new("ImageLabel")

				Colorpicker.Name = "Colorpicker"
				Colorpicker.Parent = Section
				Colorpicker.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Colorpicker.ClipsDescendants = true
				Colorpicker.Size = UDim2.new(1, 0, 0, 32)

				UICorner.CornerRadius = UDim.new(0, 6)
				UICorner.Parent = Colorpicker

				Btn.Name = "Btn"
				Btn.Parent = Colorpicker
				Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Btn.BackgroundTransparency = 1.000
				Btn.Size = UDim2.new(1, 0, 0, 32)
				Btn.Font = Enum.Font.SourceSans
				Btn.Text = ""
				Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
				Btn.TextSize = 14.000

				Box.Name = "Box"
				Box.Parent = Btn
				Box.AnchorPoint = Vector2.new(1, 0.5)
				Box.BackgroundColor3 = preset
				Box.Position = UDim2.new(1, -8, 0.5, 0)
				Box.Size = UDim2.new(0, 21, 0, 21)

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = Box

				Colorpicker_2.Name = "Colorpicker"
				Colorpicker_2.Parent = Btn
				Colorpicker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Colorpicker_2.BackgroundTransparency = 1.000
				Colorpicker_2.Position = UDim2.new(0, 10, 0, 0)
				Colorpicker_2.Size = UDim2.new(0, 1, 0, 32)
				Colorpicker_2.Font = Enum.Font.Gotham
				Colorpicker_2.Text = text
				Colorpicker_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Colorpicker_2.TextSize = 14.000
				Colorpicker_2.TextXAlignment = Enum.TextXAlignment.Left

				Hue.Name = "Hue"
				Hue.Parent = Colorpicker
				Hue.AnchorPoint = Vector2.new(0.5, 0)
				Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hue.Position = UDim2.new(0.5, 117, 0, 33)
				Hue.Size = UDim2.new(0, 25, 0, 80)
				Hue.Visible = false

				HueCorner.CornerRadius = UDim.new(0, 3)
				HueCorner.Name = "HueCorner"
				HueCorner.Parent = Hue

				HueSelection.Name = "HueSelection"
				HueSelection.Parent = Hue
				HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
				HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HueSelection.BackgroundTransparency = 1.000
				HueSelection.Position = UDim2.new(0.1348387, 0, 0.885714293, 0)
				HueSelection.Size = UDim2.new(0, 18, 0, 18)
				HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"

				HueGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.09, Color3.fromRGB(232, 0, 248)), ColorSequenceKeypoint.new(0.23, Color3.fromRGB(18, 0, 222)), ColorSequenceKeypoint.new(0.44, Color3.fromRGB(1, 113, 165)), ColorSequenceKeypoint.new(0.58, Color3.fromRGB(83, 128, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(170, 17, 17))}
				HueGradient.Rotation = 270
				HueGradient.Name = "HueGradient"
				HueGradient.Parent = Hue

				Color.Name = "Color"
				Color.Parent = Colorpicker
				Color.AnchorPoint = Vector2.new(0.5, 0)
				Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
				Color.Position = UDim2.new(0.5, -27, 0, 33)
				Color.Size = UDim2.new(0, 246, 0, 80)
				Color.ZIndex = 10
				Color.Image = "rbxassetid://4155801252"
				Color.Visible = false

				ColorCorner.CornerRadius = UDim.new(0, 3)
				ColorCorner.Name = "ColorCorner"
				ColorCorner.Parent = Color

				ColorSelection.Name = "ColorSelection"
				ColorSelection.Parent = Color
				ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
				ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColorSelection.BackgroundTransparency = 1.000
				ColorSelection.Position = UDim2.new(0.878423631, 0, 0.161290318, 0)
				ColorSelection.Size = UDim2.new(0, 18, 0, 18)
				ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
				ColorSelection.ScaleType = Enum.ScaleType.Fit

				local function UpdateColorPicker()
					Box.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
					pcall(callback, Box.BackgroundColor3)
				end

				Btn.MouseButton1Click:Connect(function()
					colorpickertoggled = not colorpickertoggled
					TweenService:Create(Colorpicker,TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = colorpickertoggled and UDim2.new(1,0,0,120) or UDim2.new(1,0,0,32)}):Play()
					wait(.15)
					Colorpicker.Size = colorpickertoggled and UDim2.new(1,0,0,120) or UDim2.new(1,0,0,32)
					Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
					Hue.Visible, Color.Visible = colorpickertoggled, colorpickertoggled
				end)

				ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
				ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
				ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

				Box.BackgroundColor3 = preset
				Color.BackgroundColor3 = preset
				pcall(callback, Box.BackgroundColor3)

				local ColorInput;
				Color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
						ColorInput = RunService.RenderStepped:Connect(function()
							local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
							local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
							ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
							ColorS = ColorX
							ColorV = 1 - ColorY
							UpdateColorPicker()
						end)
					end
				end)

				Color.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end)

				local HueInput;
				Hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
						HueInput = RunService.RenderStepped:Connect(function()
							local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
							HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
							ColorH = 1 - HueY
							UpdateColorPicker(true)
						end)
					end
				end)

				Hue.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end)

				spawn(function()
					while wait() do
						pcall(function()
							Colorpicker.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Colorpicker
							Colorpicker_2.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				return cpkfunc
			end

			function Libfunc:Label(text)
				local LabelFunc = {}
				local Label = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				Label.Name = "Label"
				Label.Parent = Section
				Label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Label.ClipsDescendants = true
				Label.Size = UDim2.new(1, 0, 0, 32)

				Title.Name = "Title"
				Title.Parent = Label
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 10, 0, 0)
				Title.Selectable = true
				Title.Size = UDim2.new(0, 1, 0, 32)
				Title.Font = Enum.Font.Gotham
				Title.Text = text
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 6)
				UICorner.Parent = Label

				function LabelFunc:Refresh(tochange)
					Title.Text = tochange
				end    

				spawn(function()
					while wait() do
						pcall(function()
							Label.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Label
							Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				return LabelFunc
			end

			function Libfunc:Textbox(text, disappear, callback)
				local Textbox = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local Box = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")

				Textbox.Name = "Textbox"
				Textbox.Parent = Section
				Textbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Textbox.ClipsDescendants = true
				Textbox.Size = UDim2.new(1, 0, 0, 32)

				Title.Name = "Title"
				Title.Parent = Textbox
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 10, 0, 0)
				Title.Selectable = true
				Title.Size = UDim2.new(0, 1, 0, 32)
				Title.Font = Enum.Font.Gotham
				Title.Text = text
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0.0500000007, 0)
				UICorner.Parent = Textbox

				Box.Name = "Box"
				Box.Parent = Textbox
				Box.AnchorPoint = Vector2.new(1, 0.5)
				Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				Box.BorderSizePixel = 0
				Box.Position = UDim2.new(1, -10, 0.5, 0)
				Box.Size = UDim2.new(0, 0, 0, 22)
				Box.Font = Enum.Font.Gotham
				Box.Text = ""
				Box.TextColor3 = Color3.fromRGB(255, 255, 255)
				Box.TextSize = 14.000

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = Box

				Box.Changed:Connect(function()
					Box.Size = UDim2.new(0,Box.TextBounds.X + 16,0,22)
				end)
				Box.PlaceholderText = "                  "

				Textbox.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Box:CaptureFocus()
					end
				end)

				Box.FocusLost:Connect(function()
					local txt = Box.Text
					if disappear then
						Box.Text = ""
					end  
					return callback(txt)
				end)

				UserInputService.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Escape and Box:IsFocused() then
						Box:ReleaseFocus()
					end
				end)

				spawn(function()
					while wait() do
						pcall(function()
							Textbox.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Textbox
							Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							Box.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextboxFrame
							Box.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)
			end

			function Libfunc:Bind(text, presetbind, callback)
				local BindFunc = {}
				local Key = presetbind.Name
				local Bind = Instance.new("TextButton")
				local BText = Instance.new("TextLabel")
				local Title = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				Bind.Name = "Bind"
				Bind.Parent = Section
				Bind.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Bind.Size = UDim2.new(1, 0, 0, 32)
				Bind.AutoButtonColor = false
				Bind.Font = Enum.Font.SourceSans
				Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
				Bind.TextSize = 14.000
				Bind.TextTransparency = 1.000
				Bind.TextXAlignment = Enum.TextXAlignment.Left

				BText.Name = "BText"
				BText.Parent = Bind
				BText.AnchorPoint = Vector2.new(1, 0)
				BText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BText.BackgroundTransparency = 1.000
				BText.Position = UDim2.new(1, -10, 0, 0)
				BText.Selectable = true
				BText.Size = UDim2.new(0, 1, 0, 32)
				BText.Font = Enum.Font.Gotham
				BText.Text = presetbind.Name
				BText.TextColor3 = Color3.fromRGB(255, 255, 255)
				BText.TextSize = 14.000
				BText.TextXAlignment = Enum.TextXAlignment.Right

				Title.Name = "Title"
				Title.Parent = Bind
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 10, 0, 0)
				Title.Selectable = true
				Title.Size = UDim2.new(0, 1, 0, 32)
				Title.Font = Enum.Font.Gotham
				Title.Text = text
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0.0500000007, 0)
				UICorner.Parent = Bind

				local togglebind = false
				Bind.MouseButton1Click:Connect(function()
					BText.Text = "..."
					local inputwait = game:GetService("UserInputService").InputBegan:wait()
					togglebind = false
					if togglebind == false then
						if inputwait.KeyCode.Name ~= "Unknown" then
							BText.Text = inputwait.KeyCode.Name
							Key = inputwait.KeyCode.Name
							togglebind = true
						end
					end
				end)

				game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
					if not pressed then
						if current.KeyCode.Name == Key then
							callback(Key)
						end
					end
				end)

				spawn(function()
					while wait() do
						pcall(function()
							Bind.BackgroundColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].Bind
							Title.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
							BText.TextColor3 = SolarisLib.Themes[SolarisLib.Settings.Theme].TextColor
						end)
					end
				end)

				return BindFunc
			end
			return Libfunc
		end
		return SectionHold
	end
	return TabList
end

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local heartbeatConnection
local UseRage = false
local sliderValue = 20


local function startAutoParry()
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local ballsFolder = workspace:WaitForChild("Balls")
    local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
    local abilityButtonPress = replicatedStorage.Remotes.AbilityButtonPress

    print("Script successfully ran.")

    local function onCharacterAdded(newCharacter)
        character = newCharacter
    end
    localPlayer.CharacterAdded:Connect(onCharacterAdded)

    if character then
        print("Character found.")
    else
        print("Character not found.")
        return
    end
    

	local function chooseNewFocusedBall()
		local balls = ballsFolder:GetChildren()
		for _, ball in ipairs(balls) do
			if ball:GetAttribute("realBall") ~= nil and ball:GetAttribute("realBall") == true then
				focusedBall = ball
				print(focusedBall.Name)
				break
			elseif ball:GetAttribute("target") ~= nil then
				focusedBall = ball
				print(focusedBall.Name)
				break
			end
		end
		
		if focusedBall == nil then
			print("Debug: Could not find a ball that's the realBall or has a target.")
		end
		return focusedBall
	end


    chooseNewFocusedBall()

    local BASE_THRESHOLD = 0.15
    local VELOCITY_SCALING_FACTOR_FAST = 0.050
    local VELOCITY_SCALING_FACTOR_SLOW = 0.1

    local function getDynamicThreshold(ballVelocityMagnitude)
        if ballVelocityMagnitude > 60 then
            print("Going Fast!")
            return math.max(0.20, BASE_THRESHOLD - (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR_FAST))
        else
            return math.min(0.01, BASE_THRESHOLD + (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR_SLOW))
        end
    end

    local function timeUntilImpact(ballVelocity, distanceToPlayer, playerVelocity)
        local directionToPlayer = (character.HumanoidRootPart.Position - focusedBall.Position).Unit
        local velocityTowardsPlayer = ballVelocity:Dot(directionToPlayer) - playerVelocity:Dot(directionToPlayer)
        
        if velocityTowardsPlayer <= 0 then
            return math.huge
        end
        
        return (distanceToPlayer - sliderValue) / velocityTowardsPlayer
    end

    local function isWalkSpeedZero()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            return humanoid.WalkSpeed == 0
        end
        return false
    end


    local function checkBallDistance()
        if not character or not character:FindFirstChild("Highlight") then return end

        local charPos = character.PrimaryPart.Position
        local charVel = character.PrimaryPart.Velocity

        if focusedBall and not focusedBall.Parent then
            print("Focused ball lost parent. Choosing a new focused ball.")
            chooseNewFocusedBall()
        end
        if not focusedBall then 
            print("No focused ball.")
            chooseNewFocusedBall()
        end

        local ball = focusedBall
        local distanceToPlayer = (ball.Position - charPos).Magnitude
        local ballVelocityTowardsPlayer = ball.Velocity:Dot((charPos - ball.Position).Unit)
        
        if distanceToPlayer < 10 then
            parryButtonPress:Fire()
        end
        local isCheckingRage = false

        if timeUntilImpact(ball.Velocity, distanceToPlayer, charVel) < getDynamicThreshold(ballVelocityTowardsPlayer) then
            if character.Abilities["Raging Deflection"].Enabled and UseRage == true then
                if not isCheckingRage then
                    isCheckingRage = true
                    abilityButtonPress:Fire()
                    if not isWalkSpeedZero() then
                        parryButtonPress:Fire()
                    end
                    isCheckingRage = false
                end
            else
                parryButtonPress:Fire()
            end
        end
    end


    heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        checkBallDistance()
    end)
end

local function stopAutoParry()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

local win = SolarisLib:Window("SYNAPSE")
local Main = win:Tab("Main")
local Section1 = Main:Section("Main")
local Section2 = Main:Section("Server")

Section1:Toggle("Parry",true,function(vu)
	if vu then
		startAutoParry()
	else
		stopAutoParry()
	end
end)




Section2:Button("Rejoin Server", function()
	local ts = game:GetService("TeleportService") local p = game.Players.LocalPlayer ts:Teleport(game.PlaceId, p)
end)



return SolarisLib
