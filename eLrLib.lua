local elr = {}

local UserInputService = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new

local uistate = true
local Utility = {}
local Objects = {}

function elr:DraggingEnabled(frame, parent)

    parent = parent or frame
    
    -- stolen from wally or kiriot, kek, Kavo
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    -- stolen from Kavo
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local SettingsT = {

}

function elr:ToggleUI()
    UserInputService.InputBegan:Connect(function (Input)
        if Input.KeyCode == Enum.KeyCode.RightControl and uistate == true then
            uistate = false
            game:GetService("CoreGui").eLriver.Enabled = false
        else
            if Input.KeyCode == Enum.KeyCode.RightControl and uistate == false then
                uistate = true
                game:GetService("CoreGui").eLriver.Enabled = true
            end
        end
    end)
end

function elr:CreateWindow(elrName)
    elrName = elrName or "Library"
    table.insert(elr, elrName)
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == elrName then
            v:Destroy()
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local eLrHub = Instance.new("TextLabel")
    local GameName = Instance.new("TextLabel")
    local TopCorner = Instance.new("UICorner")
    local TabSide = Instance.new("Frame")
    local SideCorner = Instance.new("UICorner")
    local TabFrames = Instance.new("Frame")
    local TabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local pagesBG = Instance.new("Frame")
    local BGCorner = Instance.new("UICorner")

    
    elr:DraggingEnabled(TopBar, Main)
    elr:ToggleUI()

    ScreenGui.Name = "eLriver"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.275999993, 0, 0.228289142, 0)
    Main.Size = UDim2.new(0, 600, 0, 360)

    MainCorner.CornerRadius = UDim.new(0, 5)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.Size = UDim2.new(0, 600, 0, 30)
    TopBar.ZIndex = 500

    eLrHub.Name = "eLr Hub"
    eLrHub.Parent = TopBar
    eLrHub.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    eLrHub.BorderSizePixel = 0
    eLrHub.Position = UDim2.new(0, 10, 0.200000003, -5)
    eLrHub.Size = UDim2.new(0, 65, 0, 30)
    eLrHub.Font = Enum.Font.GothamBold
    eLrHub.Text = "eLr Hub"
    eLrHub.TextColor3 = Color3.fromRGB(255, 130, 192)
    eLrHub.TextSize = 16.000
    eLrHub.TextWrapped = true
    eLrHub.TextXAlignment = Enum.TextXAlignment.Left

    GameName.Name = "Game Name"
    GameName.Parent = TopBar
    GameName.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    GameName.BorderSizePixel = 0
    GameName.Position = UDim2.new(0.126833498, 0, 0, 0)
    GameName.Size = UDim2.new(0, 420, 0, 30)
    GameName.Font = Enum.Font.GothamBold
    GameName.Text = elrName
    GameName.TextColor3 = Color3.fromRGB(226, 226, 226)
    GameName.TextSize = 16.000
    GameName.TextXAlignment = Enum.TextXAlignment.Left

    TopCorner.CornerRadius = UDim.new(0, 5)
    TopCorner.Name = "TopCorner"
    TopCorner.Parent = TopBar

    TabSide.Name = "TabSide"
    TabSide.Parent = Main
    TabSide.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    TabSide.BorderSizePixel = 0
    TabSide.Position = UDim2.new(0, 5, 0, 30)
    TabSide.Size = UDim2.new(0, 190, 0, 325)

    SideCorner.CornerRadius = UDim.new(0, 5)
    SideCorner.Name = "SideCorner"
    SideCorner.Parent = TabSide

    TabFrames.Name = "TabFrames"
    TabFrames.Parent = TabSide
    TabFrames.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    TabFrames.BorderSizePixel = 0
    TabFrames.Position = UDim2.new(0, 20, 0, 10)
    TabFrames.Size = UDim2.new(0, 165, 0, 315)

    TabListing.Name = "TabListing"
    TabListing.Parent = TabFrames
    TabListing.SortOrder = Enum.SortOrder.LayoutOrder
    TabListing.Padding = UDim.new(0, 2)

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0, 200, 0, 30)
    pages.Size = UDim2.new(0, 395, 0, 325)
    
    Pages.Name = "Pages"
    Pages.Parent = pages

    pagesBG.Name = "pagesBG"
    pagesBG.Parent = pages
    pagesBG.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    pagesBG.BorderSizePixel = 0
    pagesBG.Size = UDim2.new(0, 395, 0, 325)
    
    BGCorner.CornerRadius = UDim.new(0, 5)
    BGCorner.Name = "BGCorner"
    BGCorner.Parent = pagesBG
    
    local Tabs = {}

    local first = true

    function Tabs:CreateTab(tabName)
        tabName = tabName or "Tab"
        local TabButton = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local PageListing = Instance.new("UIListLayout")
        local TabName = Instance.new("TextLabel")
        
        local function UpdateSize()
            local cS = PageListing.AbsoluteContentSize

            game.TweenService:Create(Page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
        end

        Page.Name = "Page"
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
        Page.BorderSizePixel = 0
        Page.Position = UDim2.new(0, 5, 0, 30)
        Page.Size = UDim2.new(0, 385, 0, 295)
        Page.ScrollBarThickness = 5
        Page.Visible = false
        Page.ZIndex = 2

        PageListing.Name = "PageListing"
        PageListing.Parent = Page
        PageListing.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageListing.SortOrder = Enum.SortOrder.LayoutOrder
        PageListing.Padding = UDim.new(0, 5)

        TabName.Name = tabName.."TabName"
        TabName.Parent = Pages
        TabName.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
        TabName.BorderSizePixel = 0
        TabName.Position = UDim2.new(0, 5, 0, 0)
        TabName.Size = UDim2.new(0, 325, 0, 30)
        TabName.ZIndex = 50
        TabName.Font = Enum.Font.GothamBold
        TabName.Text = tabName
        TabName.TextColor3 = Color3.fromRGB(226, 226, 226)
        TabName.TextSize = 16.000
        TabName.TextStrokeColor3 = Color3.fromRGB(43, 43, 43)
        TabName.TextXAlignment = Enum.TextXAlignment.Left
        TabName.Visible = false

        TabButton.Name = tabName.."TabButton"
        TabButton.Parent = TabFrames
        TabButton.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 165, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(226, 226, 226)
        TabButton.TextSize = 16.000
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.BackgroundTransparency = 1

        if first then
            first = false
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
            TabName.Visible = true
            UpdateSize()
        else
            Page.Visible = false
            TabButton.BackgroundTransparency = 1
            TabName.Visible = false
        end
        table.insert(Tabs, tabName)

        UpdateSize()
        Page.ChildAdded:Connect(UpdateSize)
        Page.ChildRemoved:Connect(UpdateSize)

        TabButton.MouseButton1Click:Connect(function ()
            UpdateSize()
            for i,v in next, Pages:GetChildren() do
                v.Visible = false
            end
            Page.Visible = true
            for i,v in next, Pages:GetChildren() do
                if v:IsA("TextLabel") and v.Text == tabName then
                    v.Visible = false
                end
            end
            TabName.Visible = true
        end)

        local Sections = {}
        local focusing = false

        function Sections:CreateSection(sectName)
            sectName = sectName or "Section"
            local sectionFunctions = {}
            local modules = {}
            local sectionFrame = Instance.new("Frame")
            local sectionListing = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sectionName = Instance.new("TextLabel")
            local sectioninners = Instance.new("ScrollingFrame")
            local sectionElListing = Instance.new("UIListLayout")

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = Page
            sectionFrame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Position = UDim2.new(0, 10, 0, 10)
            sectionFrame.Size = UDim2.new(0, 360, 0, 580)

            sectionListing.Name = "sectionListing"
            sectionListing.Parent = sectionFrame
            sectionListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionListing.Padding = UDim.new(0, 5)

            for i,v in pairs(sectioninners:GetChildren()) do
                while wait() do
                    if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("ScrollingFrame") then
                        function size(pro)
                            if pro == "Size" then
                                UpdateSize()
                                updateSectionFrame()
                            end
                        end
                        v.Changed:Connect(size)
                    end
                end
            end
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = Color3.fromRGB(112, 57, 84)
            sectionHead.BackgroundTransparency = 1.000
            sectionHead.BorderSizePixel = 0
            sectionHead.Size = UDim2.new(0, 360, 0, 30)

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
            sectionName.BackgroundTransparency = 1.000
            sectionName.BorderColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BorderSizePixel = 0
            sectionName.Size = UDim2.new(0, 360, 0, 30)
            sectionName.Font = Enum.Font.GothamBold
            sectionName.Text = sectName
            sectionName.TextColor3 = Color3.fromRGB(226, 226, 226)
            sectionName.TextSize = 16.000

            sectioninners.Name = "sectioninners"
            sectioninners.Parent = sectionFrame
            sectioninners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectioninners.BackgroundTransparency = 1.000
            sectioninners.BorderSizePixel = 0
            sectioninners.Size = UDim2.new(1, 0, 0, 30)
            sectioninners.Active = true
            sectioninners.CanvasSize = UDim2.new(0, 0, 0, 0)
            sectioninners.ScrollBarThickness = 0

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectioninners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 5)

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectioninners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionListing.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
            updateSectionFrame()
            UpdateSize()

                local Elements = {}

                function Elements:CreateButton(btnName, callback)
                    local ButtonFunction = {}
                    btnName = btnName or "Button"
                    callback = callback or function ()  end

                    local ButtonText = Instance.new("TextButton")
                    local BtnCorner = Instance.new("UICorner")
                    local BtnName = Instance.new("TextLabel")

                    table.insert(modules, btnName)

                    ButtonText.Name = btnName
                    ButtonText.Parent = sectioninners
                    ButtonText.BackgroundColor3 = Color3.fromRGB(131, 67, 99)
                    ButtonText.ClipsDescendants = true
                    ButtonText.Size = UDim2.new(0, 350, 0, 25)
                    ButtonText.AutoButtonColor = false
                    ButtonText.Font = Enum.Font.SourceSans
                    ButtonText.Text = ""
                    ButtonText.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ButtonText.TextSize = 14.000

                    BtnCorner.CornerRadius = UDim.new(0, 5)
                    BtnCorner.Parent = ButtonText

                    BtnName.Name = "BtnName"
                    BtnName.Parent = ButtonText
                    BtnName.BackgroundColor3 = Color3.fromRGB(131, 67, 99)
                    BtnName.BorderSizePixel = 0
                    BtnName.Position = UDim2.new(0, 10, 0, 0)
                    BtnName.Size = UDim2.new(0, 310, 0, 25)
                    BtnName.ZIndex = 14
                    BtnName.Font = Enum.Font.GothamBold
                    BtnName.Text = btnName
                    BtnName.TextColor3 = Color3.fromRGB(226, 226, 226)
                    BtnName.TextSize = 16.000
                    BtnName.TextXAlignment = Enum.TextXAlignment.Left

                    updateSectionFrame()
                                    UpdateSize()

                    local ms = game.Players.LocalPlayer:GetMouse()

                    local btn = ButtonText

                    btn.MouseButton1Click:Connect(function ()
                        callback()
                    end)

                    function ButtonFunction:UpdateButton(newtitle)
                        BtnName.Text = newtitle
                    end
                    return ButtonFunction
                end
                
                function Elements:CreateToggle(toggleName, callback)
                    local TogFunction = {}
                    toggleName = toggleName or "Toggle"
                    callback = callback or function ()  end
                    local toggled = false
                    table.insert(SettingsT, toggleName)

                    local toggleElement = Instance.new("TextButton")
                    local tgleCorner = Instance.new("UICorner")
                    local tgleName = Instance.new("TextLabel")
                    local ToggleDisable = Instance.new("Frame")
                    local Boarder = Instance.new("Frame")
                    local ToggleEnabled = Instance.new("Frame")
                    local Boarder_2 = Instance.new("Frame")
                    local Toggled = Instance.new("Frame")

                    toggleElement.Name = "toggleElement"
                    toggleElement.Parent = sectioninners
                    toggleElement.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    toggleElement.BorderSizePixel = 0
                    toggleElement.Size = UDim2.new(0, 350, 0, 30)
                    toggleElement.AutoButtonColor = false
                    toggleElement.Font = Enum.Font.SourceSans
                    toggleElement.Text = ""
                    toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleElement.TextSize = 14.000

                    tgleCorner.CornerRadius = UDim.new(0, 5)
                    tgleCorner.Name = "tgleCorner"
                    tgleCorner.Parent = toggleElement

                    tgleName.Name = "tgleName"
                    tgleName.Parent = toggleElement
                    tgleName.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    tgleName.BorderSizePixel = 0
                    tgleName.Position = UDim2.new(0, 10, 0, 0)
                    tgleName.Size = UDim2.new(0, 290, 0, 30)
                    tgleName.ZIndex = 14
                    tgleName.Font = Enum.Font.GothamBold
                    tgleName.Text = toggleName
                    tgleName.TextColor3 = Color3.fromRGB(226, 226, 226)
                    tgleName.TextSize = 16.000
                    tgleName.TextXAlignment = Enum.TextXAlignment.Left

                    ToggleDisable.Name = "ToggleDisable"
                    ToggleDisable.Parent = toggleElement
                    ToggleDisable.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    ToggleDisable.BackgroundTransparency = 1.000
                    ToggleDisable.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleDisable.BorderSizePixel = 2
                    ToggleDisable.Position = UDim2.new(0, 320, 0, 7)
                    ToggleDisable.Size = UDim2.new(0, 15, 0, 15)
                    ToggleDisable.ZIndex = 12
                    ToggleDisable.Visible = true

                    Boarder.Name = "Boarder"
                    Boarder.Parent = ToggleDisable
                    Boarder.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    Boarder.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Boarder.BorderSizePixel = 2
                    Boarder.Size = UDim2.new(0, 15, 0, 15)
                    Boarder.ZIndex = 12

                    ToggleEnabled.Name = "ToggleEnable"
                    ToggleEnabled.Parent = toggleElement
                    ToggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleEnabled.BackgroundTransparency = 1.000
                    ToggleEnabled.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleEnabled.BorderSizePixel = 0
                    ToggleEnabled.Position = UDim2.new(0, 320, 0, 7)
                    ToggleEnabled.Size = UDim2.new(0, 13, 0, 13)
                    ToggleEnabled.ZIndex = 13
                    ToggleEnabled.Visible = false

                    Boarder_2.Name = "Boarder"
                    Boarder_2.Parent = ToggleEnabled
                    Boarder_2.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    Boarder_2.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Boarder_2.BorderSizePixel = 2
                    Boarder_2.Size = UDim2.new(0, 15, 0, 15)
                    Boarder_2.ZIndex = 12

                    Toggled.Name = "Toggled"
                    Toggled.Parent = ToggleEnabled
                    Toggled.BackgroundColor3 = Color3.fromRGB(255, 130, 192)
                    Toggled.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Toggled.BorderSizePixel = 0
                    Toggled.Position = UDim2.new(0, 1, 0, 1)
                    Toggled.Size = UDim2.new(0, 13, 0, 13)
                    Toggled.ZIndex = 13

                    local ms = game.Players.LocalPlayer:GetMouse()

                    local btn = toggleElement
                    local img = ToggleEnabled

                            updateSectionFrame()
                UpdateSize()

                    btn.MouseButton1Click:Connect(function ()
                        if toggled == false then
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                Visible = true
                            }):Play()
                        else
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                Visible = false
                            }):Play()
                        end
                        toggled = not toggled
                        pcall(callback, toggled)
                    end)
                    function TogFunction:UpdateToggle(newtitle, isTogOn)
                        isTogOn = isTogOn or toggle
                        if newtitle ~= nil then
                            tgleName.Text = newtitle
                        end
                        if isTogOn then
                            toggled = true
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 0
                            }):Play()
                            pcall(callback, toggled)
                        else
                            toggled = false
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 1
                            }):Play()
                            pcall(callback, toggled)
                        end
                    end
                    return TogFunction
                end

                function Elements:CreateToggleinfo(togName, toginfo, textsize, callback)
                    local ToginfoFunction = {}
                    togName = togName or "Toggle"
                    toginfo = toginfo or "Toggleinfo"
                    if not textsize then
                        textsize = 12.000
                    else
                        textsize = textsize or "textsize"
                    end
                    callback = callback or function ()  end
                    local toggled = false
                    table.insert(SettingsT, togName)

                    local toginfoElement = Instance.new("TextButton")
                    local tgleCorner = Instance.new("UICorner")
                    local ToggleDisable = Instance.new("Frame")
                    local Boarder = Instance.new("Frame")
                    local ToggleEnable = Instance.new("Frame")
                    local Boarder_2 = Instance.new("Frame")
                    local Toggled = Instance.new("Frame")
                    local textFrame = Instance.new("Frame")
                    local info = Instance.new("TextLabel")
                    local tgleName = Instance.new("TextLabel")

                    toginfoElement.Name = "toginfoElement"
                    toginfoElement.Parent = sectioninners
                    toginfoElement.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    toginfoElement.BorderSizePixel = 0
                    toginfoElement.Position = UDim2.new(0, 0, 0.558558583, 0)
                    toginfoElement.Size = UDim2.new(0, 350, 0, 65)
                    toginfoElement.AutoButtonColor = false
                    toginfoElement.Font = Enum.Font.SourceSans
                    toginfoElement.Text = ""
                    toginfoElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toginfoElement.TextSize = 14.000

                    tgleCorner.CornerRadius = UDim.new(0, 5)
                    tgleCorner.Name = "tgleCorner"
                    tgleCorner.Parent = toginfoElement

                    ToggleDisable.Name = "ToggleDisable"
                    ToggleDisable.Parent = toginfoElement
                    ToggleDisable.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    ToggleDisable.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleDisable.BorderSizePixel = 2
                    ToggleDisable.Position = UDim2.new(0, 320, 0, 26)
                    ToggleDisable.Size = UDim2.new(0, 15, 0, 15)
                    ToggleDisable.ZIndex = 12
                    ToggleDisable.Visible = true

                    Boarder.Name = "Boarder"
                    Boarder.Parent = ToggleDisable
                    Boarder.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    Boarder.BackgroundTransparency = 1.000
                    Boarder.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Boarder.BorderSizePixel = 2
                    Boarder.Size = UDim2.new(0, 15, 0, 15)
                    Boarder.Visible = false
                    Boarder.ZIndex = 12

                    ToggleEnable.Name = "ToggleEnable"
                    ToggleEnable.Parent = toginfoElement
                    ToggleEnable.BackgroundColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleEnable.BackgroundTransparency = 1.000
                    ToggleEnable.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    ToggleEnable.BorderSizePixel = 0
                    ToggleEnable.Position = UDim2.new(0, 320, 0, 26)
                    ToggleEnable.Size = UDim2.new(0, 13, 0, 13)
                    ToggleEnable.ZIndex = 13
                    ToggleEnable.Visible = false

                    Boarder_2.Name = "Boarder"
                    Boarder_2.Parent = ToggleEnable
                    Boarder_2.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    Boarder_2.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Boarder_2.BorderSizePixel = 2
                    Boarder_2.Size = UDim2.new(0, 15, 0, 15)
                    Boarder_2.ZIndex = 12

                    Toggled.Name = "Toggled"
                    Toggled.Parent = ToggleEnable
                    Toggled.BackgroundColor3 = Color3.fromRGB(255, 130, 192)
                    Toggled.BorderColor3 = Color3.fromRGB(255, 130, 192)
                    Toggled.BorderSizePixel = 0
                    Toggled.Position = UDim2.new(0, 1, 0, 1)
                    Toggled.Size = UDim2.new(0, 13, 0, 13)
                    Toggled.ZIndex = 13

                    textFrame.Name = "textFrame"
                    textFrame.Parent = toginfoElement
                    textFrame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    textFrame.BorderSizePixel = 0
                    textFrame.Position = UDim2.new(0, 15, 0, 0)
                    textFrame.Size = UDim2.new(0, 295, 0, 65)

                    info.Name = "info"
                    info.Parent = textFrame
                    info.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    info.BorderSizePixel = 0
                    info.Position = UDim2.new(0, 0, 0, 20)
                    info.Size = UDim2.new(0, 300, 0, 45)
                    info.Font = Enum.Font.GothamBold
                    info.Text = toginfo
                    info.TextColor3 = Color3.fromRGB(159, 159, 159)
                    info.TextSize = 12.000
                    info.TextWrapped = true
                    info.TextXAlignment = Enum.TextXAlignment.Left

                    tgleName.Name = "tgleName"
                    tgleName.Parent = toginfoElement
                    tgleName.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    tgleName.BorderSizePixel = 0
                    tgleName.Position = UDim2.new(0, 10, 0, 0)
                    tgleName.Size = UDim2.new(0, 300, 0, 30)
                    tgleName.ZIndex = 14
                    tgleName.Font = Enum.Font.GothamBold
                    tgleName.Text = togName
                    tgleName.TextColor3 = Color3.fromRGB(226, 226, 226)
                    tgleName.TextSize = 16.000
                    tgleName.TextXAlignment = Enum.TextXAlignment.Left

                    local btn = toginfoElement
                    local img = ToggleEnable

                            updateSectionFrame()
                UpdateSize()

                    btn.MouseButton1Click:Connect(function ()
                        if toggled == false then
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                Visible = true
                            }):Play()
                        else
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                Visible = false
                            }):Play()
                        end
                        toggled = not toggled
                        pcall(callback, toggled)
                    end)
                    function ToginfoFunction:UpdateToggle(newtitle, isTogOn)
                        isTogOn = isTogOn or toggle
                        if newtitle ~= nil then
                            tgleName.Text = newtitle
                        end
                        if isTogOn then
                            toggled = true
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 0
                            }):Play()
                            pcall(callback, toggled)
                        else
                            toggled = false
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 1
                            }):Play()
                            pcall(callback, toggled)
                        end
                    end
                    return ToginfoFunction
                end

                function Elements:CreateSlider(slidName, maxvalue, minvalue, callback)
                    slidName = slidName or "Slider"
                    maxvalue = maxvalue or 500
                    minvalue = minvalue or 16
                    startVal = startVal or 0
                    callback = callback or function ()  end

                    local sliderElement = Instance.new("TextButton")
                    local sliderCorner = Instance.new("UICorner")
                    local sdName = Instance.new("TextLabel")
                    local SlideBtn = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local UIListLayout = Instance.new("UIListLayout")
                    local Slideliner = Instance.new("Frame")
                    local UICorner_2 = Instance.new("UICorner")
                    local Val = Instance.new("TextBox")
                    local UICorner_3 = Instance.new("UICorner")

                    sliderElement.Name = "sliderElement"
                    sliderElement.Parent = sectioninners
                    sliderElement.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    sliderElement.Size = UDim2.new(0, 350, 0, 55)
                    sliderElement.AutoButtonColor = false
                    sliderElement.Font = Enum.Font.SourceSans
                    sliderElement.Text = ""
                    sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                    sliderElement.TextSize = 14.000

                    sliderCorner.CornerRadius = UDim.new(0, 5)
                    sliderCorner.Parent = sliderElement

                    sdName.Name = "sdName"
                    sdName.Parent = sliderElement
                    sdName.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    sdName.BorderSizePixel = 0
                    sdName.Position = UDim2.new(0, 10, 0, 0)
                    sdName.Size = UDim2.new(0, 205, 0, 25)
                    sdName.ZIndex = 14
                    sdName.Font = Enum.Font.GothamBold
                    sdName.Text = slidName
                    sdName.TextColor3 = Color3.fromRGB(226, 226, 226)
                    sdName.TextSize = 16.000
                    sdName.TextXAlignment = Enum.TextXAlignment.Left

                    SlideBtn.Name = "SlideBtn"
                    SlideBtn.Parent = sliderElement
                    SlideBtn.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
                    SlideBtn.Position = UDim2.new(0, 5, 0, 40)
                    SlideBtn.Size = UDim2.new(0, 340, 0, 5)
                    SlideBtn.AutoButtonColor = false
                    SlideBtn.Font = Enum.Font.SourceSans
                    SlideBtn.Text = ""
                    SlideBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    SlideBtn.TextSize = 14.000

                    UICorner.CornerRadius = UDim.new(0, 5)
                    UICorner.Parent = SlideBtn

                    UIListLayout.Parent = SlideBtn
                    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    Slideliner.Name = "Slideliner"
                    Slideliner.Parent = SlideBtn
                    Slideliner.BackgroundColor3 = Color3.fromRGB(255, 130, 192)
                    Slideliner.Position = UDim2.new(0, 5, 0, 40)
                    Slideliner.Size = UDim2.new(0, 0, 0, 5)

                    UICorner_2.CornerRadius = UDim.new(0, 5)
                    UICorner_2.Parent = Slideliner

                    Val.Name = "Val"
                    Val.Parent = sliderElement
                    Val.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
                    Val.BorderSizePixel = 0
                    Val.Position = UDim2.new(0, 215, 0, 6)
                    Val.Size = UDim2.new(0, 130, 0, 25)
                    Val.ZIndex = 4
                    Val.Font = Enum.Font.GothamBold
                    Val.PlaceholderColor3 = Color3.fromRGB(226, 226, 226)
                    Val.Text = minvalue
                    Val.TextColor3 = Color3.fromRGB(226, 226, 226)
                    Val.TextSize = 14.000

                    UICorner_3.CornerRadius = UDim.new(0, 5)
                    UICorner_3.Parent = Val

                                updateSectionFrame()
                    UpdateSize()

                    local mouse = game:GetService("Players").LocalPlayer:GetMouse();

                    local ms = game.Players.LocalPlayer:GetMouse()
                    local uis = game:GetService("UserInputService")
                    local btn = sliderElement
                    
                    local Value
                    local enterbox
                    Val.FocusLost:Connect(function (enterPressed)
                        if not enterPressed then
                            return
                        else
                            callback(Val.Text)
                        end
                    end)
                    SlideBtn.MouseButton1Down:Connect(function ()
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 340) * Slideliner.AbsoluteSize.X) + tonumber(minvalue)) or 0
                        pcall(function()
                            callback(Value)
                        end)
                        Slideliner:TweenSize(UDim2.new(0, math.clamp(mouse.X - Slideliner.AbsolutePosition.X, 0, 340), 0, 5), "InOut", "Linear", 0.05, true)
                        moveconnection = mouse.Move:Connect(function()
                            Val.Text = Value
                            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 340) * Slideliner.AbsoluteSize.X) + tonumber(minvalue))
                            pcall(function()
                                callback(Value)
                            end)
                            Slideliner:TweenSize(UDim2.new(0, math.clamp(mouse.X - Slideliner.AbsolutePosition.X, 0, 340), 0, 5), "InOut", "Linear", 0.05, true)
                        end)
                        releaseconnection = uis.InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 340) * Slideliner.AbsoluteSize.X) + tonumber(minvalue))
                                pcall(function()
                                    callback(Value)
                                end)
                                Val.Text = Value
                                Slideliner:TweenSize(UDim2.new(0, math.clamp(mouse.X - Slideliner.AbsolutePosition.X, 0, 340), 0, 5), "InOut", "Linear", 0.05, true)
                                    moveconnection:Disconnect()
                                        releaseconnection:Disconnect()
                            end
                        end)
                    end)
                end

                function Elements:CreateDropdown(ddName, list, callback)
                    local DropFunction = {}
                    ddName = ddName or "Dropdown"
                    list = list or {}
                    callback = callback or function ()  end

                    local opened = false
                    local DropYSize = 25


                    local dropFrame = Instance.new("ScrollingFrame")
                    local UIListLayout_2 = Instance.new("UIListLayout")
                    local dropOpen = Instance.new("TextButton")
                    local UICorner_4 = Instance.new("UICorner")
                    local dropName = Instance.new("TextLabel")
                    local arrow = Instance.new("TextButton")

                    local ms = game.Players.LocalPlayer:GetMouse()

                    dropFrame.Name = "dropFrame"
                    dropFrame.Parent = sectioninners
                    dropFrame.Active = true
                    dropFrame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                    dropFrame.BorderSizePixel = 0
                    dropFrame.Size = UDim2.new(0, 350, 0, 25)
                    dropFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
                    dropFrame.ScrollBarThickness = 5

                    local btn = dropOpen

                    dropOpen.Name = "dropOpen"
                    dropOpen.Parent = dropFrame
                    dropOpen.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
                    dropOpen.BorderSizePixel = 0
                    dropOpen.Size = UDim2.new(0, 350, 0, 25)
                    dropOpen.AutoButtonColor = false
                    dropOpen.Font = Enum.Font.SourceSans
                    dropOpen.Text = ""
                    dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
                    dropOpen.TextSize = 14.000
                    dropOpen.ClipsDescendants = true
                    dropOpen.MouseButton1Click:Connect(function ()
                        if opened then
                            opened = false -- when dropdown is already opened
                            dropFrame:TweenSize(UDim2.new(0, 350, 0, 25), "InOut", "Linear", 0.08)
                            dropFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            arrow.Rotation = 0
                        else
                            opened = true -- when dropdown is not open yet
                            dropFrame:TweenSize(UDim2.new(0, 350, 0, 180), "InOut", "Linear", 0.08, true)
                            local absoluteContentSize = UIListLayout_2.AbsoluteContentSize
                            dropFrame.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSize.Y)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            arrow.Rotation = 90
                        end
                    end)

                    dropName.Name = "dropName"
                    dropName.Parent = dropOpen
                    dropName.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
                    dropName.BorderSizePixel = 0
                    dropName.Position = UDim2.new(0, 10, 0, 0)
                    dropName.Size = UDim2.new(0, 310, 0, 25)
                    dropName.ZIndex = 14
                    dropName.Font = Enum.Font.GothamBold
                    dropName.Text = ddName
                    dropName.TextColor3 = Color3.fromRGB(226, 226, 226)
                    dropName.TextSize = 16.000
                    dropName.TextXAlignment = Enum.TextXAlignment.Left

                    arrow.Name = "arrow"
                    arrow.Parent = dropOpen
                    arrow.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
                    arrow.BorderSizePixel = 0
                    arrow.Position = UDim2.new(0, 320, 0, 0)
                    arrow.Rotation = 0
                    arrow.Size = UDim2.new(0, 23, 0, 25)
                    arrow.AutoButtonColor = false
                    arrow.Font = Enum.Font.GothamBold
                    arrow.Text = ">"
                    arrow.TextColor3 = Color3.fromRGB(255, 130, 192)
                    arrow.TextSize = 20.000

                    UICorner_4.CornerRadius = UDim.new(0, 5)
                    UICorner_4.Parent = dropOpen

                    UIListLayout_2.Parent = dropFrame
                    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout_2.Padding = UDim.new(0, 2)
                    
                    updateSectionFrame()
                    UpdateSize()

                    for i,v in next, list do
                        local thingselect = Instance.new("TextButton")

                        DropYSize = DropYSize + 25
                        thingselect.Name = "thingselect"
                        thingselect.Parent = dropFrame
                        thingselect.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
                        thingselect.BorderSizePixel = 0
                        thingselect.Position = UDim2.new(0.0833333358, 0, 0, 0)
                        thingselect.Size = UDim2.new(0, 350, 0, 25)
                        thingselect.ZIndex = 2
                        thingselect.AutoButtonColor = false
                        thingselect.Font = Enum.Font.GothamBold
                        thingselect.Text = "        "..v
                        thingselect.TextColor3 = Color3.fromRGB(226, 226, 226)
                        thingselect.TextSize = 14.000
                        thingselect.TextXAlignment = Enum.TextXAlignment.Left
                        thingselect.ClipsDescendants = true
                        thingselect.MouseButton1Click:Connect(function ()
                            opened = false
                            callback(v)
                            dropName.Text = v
                            dropFrame:TweenSize(UDim2.new(0, 350,0, 25), "InOut", "Linear", 0.08)
                            dropFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                        end)
                    end
                    return DropFunction
                end
            return Elements
        end
        return Sections
    end
    return Tabs
end
return elr


