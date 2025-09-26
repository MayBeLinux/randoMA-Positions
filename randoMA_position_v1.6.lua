 --[[

- RANDOMA POSITIONS V1.5
- Developement by LumiArt - Studio
- Create some randomm position in your show 



   ███╗   ███╗ █████╗ ██╗   ██╗██████╗ ███████╗██╗     ██╗███╗   ██╗██╗   ██╗
   ████╗ ████║██╔══██╗██║   ██║██╔══██╗██╔════╝██║     ██║████╗  ██║██║   ██║
   ██╔████╔██║███████║██║   ██║██████╔╝█████╗  ██║     ██║██╔██╗ ██║██║   ██║
   ██║╚██╔╝██║██╔══██║██║   ██║██╔═══╝ ██╔══╝  ██║     ██║██║╚██╗██║██║   ██║
   ██║ ╚═╝ ██║██║  ██║╚██████╔╝██║     ███████╗███████╗██║██║ ╚████║╚██████╔╝
   ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 


--]]

local pluginName = select(1, ...)
local componentName = select(2, ...)
local signalTable = select(3, ...)
local myHandle = select(4, ...)

local panMAX = 0
local panMIN = 0
local tiltMIN = 0
local tiltMAX = 0



function randommValues(panMAX , panMIN, tiltMAX, tiltMIN)

  if panMAX < panMIN then 
    panMIN , panMAX = panMAX, panMIN
    end
  if tiltMAX < tiltMIN then 
    tiltMIN , tiltMAX = tiltMAX, tiltMIN
  end
  local fixtures = SelectionCount()
  Printf("Fixtures Count  = %i" , fixtures)
  if fixtures == 0 then MessageBox({title = "No Selection Active" , message = "Error: No fixtures selected. Operation aborted." , commands = {{value = 1 , name = "OK" }} , timeout = 2000 }) end
    for  i = 1 , fixtures do 
      local numbersP = math.random(panMIN, panMAX)
      local numbersT = math.random(tiltMIN, tiltMAX)
      Cmd("Next") 
      Cmd("Attribute 'PAN' At " ..numbersP)
      Cmd("Attribute 'TILT' At " ..numbersT)
    end
    Cmd("Reset Selection MAtricks")
    end


function UI_MAIN(displayHandle)

local displayIndex = Obj.Index(GetFocusDisplay())
if displayIndex > 5 then
  displayIndex = 1
end

local colorTransparent = Root().ColorTheme.ColorGroups.Global.Transparent
local colorBackground = Root().ColorTheme.ColorGroups.Button.Background
local colorBackgroundPlease = Root().ColorTheme.ColorGroups.Button.BackgroundPlease
local colorPartlySelected = Root().ColorTheme.ColorGroups.Global.PartlySelected
local colorPartlySelectedPreset = Root().ColorTheme.ColorGroups.Global.PartlySelectedPreset
local saumonBackground = Root().ColorTheme.ColorGroups.Global.InvalidGridPosition
local display = GetDisplayByIndex(displayIndex)
local red = Root().ColorTheme.ColorGroups.Global.RedIndicator
local screenOverlay = display.ScreenOverlay


screenOverlay:ClearUIChildren()

local dialogWidth = 800
local baseInput = screenOverlay:Append("BaseInput")
baseInput.Name = "RandoMA Positions"
baseInput.H = "1080"
baseInput.W = dialogWidth
baseInput.MaxSize = string.format("%s,%s", display.W * 0.8, display.H)
baseInput.MinSize = string.format("%s,0", dialogWidth - 100)
baseInput.Columns = 1
baseInput.Rows = 2
baseInput[1][1].SizePolicy = "Fixed"
baseInput[1][1].Size = "60"
baseInput[1][2].SizePolicy = "Stretch"
baseInput.AutoClose = "No"
baseInput.CloseOnEscape = "Yes"


local titleBar = baseInput:Append("TitleBar")
titleBar.Columns = 2
titleBar.Rows = 1
titleBar.Anchors = "0,0"
titleBar[2][2].SizePolicy = "Fixed"
titleBar[2][2].Size = "50"
titleBar.Texture = "corner2"

local titleBarIcon = titleBar:Append("TitleButton")
titleBarIcon.Text = "LumiArt Studio - RandoMA Position"
titleBarIcon.Texture = "corner1"
titleBarIcon.Anchors = "0,0"
titleBarIcon.Icon = "ball3d"

local titleBarCloseButton = titleBar:Append("CloseButton")
titleBarCloseButton.Anchors = "1,0"
titleBarCloseButton.Texture = "corner2"

local dlgFrame = baseInput:Append("DialogFrame")
dlgFrame.H = "100%"
dlgFrame.W = "100%"
dlgFrame.Columns = 1
dlgFrame.Rows = 10
dlgFrame.Anchors = {left = 0, right = 0, top = 1, bottom = 1};


dlgFrame[1][1].SizePolicy = "Fixed"
dlgFrame[1][1].Size = "120"


dlgFrame[1][2].SizePolicy = "Fixed"
dlgFrame[1][2].Size = "60"


dlgFrame[1][3].SizePolicy = "Fixed"
dlgFrame[1][3].Size = "60"


dlgFrame[1][4].SizePolicy = "Fixed"
dlgFrame[1][4].Size = "50"


dlgFrame[1][5].SizePolicy = "Fixed"
dlgFrame[1][5].Size = "60"


dlgFrame[1][6].SizePolicy = "Fixed"
dlgFrame[1][6].Size = "350"


dlgFrame[1][7].SizePolicy = "Fixed"
dlgFrame[1][7].Size = "30"

dlgFrame[1][8].SizePolicy = "Fixed"
dlgFrame[1][8].Size = "40"

dlgFrame[1][9].SizePolicy = "Fixed"
dlgFrame[1][9].Size = "70"

dlgFrame[1][10].SizePolicy = "Fixed"
dlgFrame[1][10].Size = "50"


local subTitle = dlgFrame:Append("UIObject")
subTitle.Text = "Radomize Positions \n This plugin creates random positions for any values (like pan/tilt). \n Open: fully random values, no limits. \n Blocked: sets min/max range to control the randomness."
subTitle.ContentDriven = "Yes"
subTitle.ContentWidth = "No"
subTitle.TextAutoAdjust = "No"
subTitle.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
subTitle.Padding = {left = 20, right = 20, top = 15, bottom = 15}
subTitle.Font = "Medium20"
subTitle.HasHover = "No"
subTitle.BackColor = saumonBackground
subTitle.TextColor = red


local openB = dlgFrame:Append("UILayoutGrid")
openB.Columns = 1
openB.Rows = 1
openB.Anchors = {left = 0, right = 0, top = 2, bottom = 2}
openB.Margin = {left = 80, right = 470, top = 0, bottom = 0}
local open = openB:Append("Button");
open.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
open.Textshadow = 1;
open.HasHover = "Yes";
open.Text = "Open";
open.Font = "Medium20";
open.TextalignmentH = "Centre";
open.PluginComponent = myHandle
open.Clicked = "openButton"
open.Texture = "corner15"


local blockedB = dlgFrame:Append("UILayoutGrid")
blockedB.Columns = 1
blockedB.Rows = 1
blockedB.Anchors = {left = 0 , right = 0, top = 2, bottom = 2}
blockedB.Margin = {left = 470, right = 80, top = 0, bottom =0}
local blocked = blockedB:Append("Button");
blocked.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
blocked.TextShadow = 1;
blocked.HasHover = "Yes";
blocked.Text = "Blocked";
blocked.Font = "Medium20";
blocked.TextalignmentH = "Centre";
blocked.PluginComponent = myHandle;
blocked.Clicked = "blockedButton"
blocked.Texture = "corner15"


local lineB = dlgFrame:Append("UILayoutGrid")
lineB.Columns = 1
lineB.Rows = 1
lineB.Anchors = {left = 0 , right = 0, top = 3, bottom = 3}
lineB.Margin = {left = 0, right = 0, top = 0, bottom = 0}
local line = lineB:Append("Button");
line.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
line.Margin = {left = 50, right = 50, top = 20, bottom = 0}
line.TextShadow = 1;
line.HasHover = "Yes";
line.Text = "";
line.Font = "Medium20";
line.TextalignmentH = "Centre";
line.PluginComponent = myHandle;
line.Clicked = "Clicked"
line.Texture = "treeview_horizontal"


local panTitle = dlgFrame:Append("UIObject")
panTitle.Text = " PAN Min and Max "
panTitle.ContentDriven = "No"
panTitle.ContentWidth = "No"
panTitle.TextAutoAdjust = "No"
panTitle.Anchors = {left =0, right = 0, top = 4, bottom = 4}
panTitle.Padding = {left = 0, right = 0, top = 0, bottom = 0}
panTitle.Margin = {left = 80, right = 470, top = 0, bottom = 0}
panTitle.Font = "Medium20"
panTitle.HasHover = "No"
panTitle.Texture = ""
panTitle.TextColor = saumonBackground


local tiltTitle = dlgFrame:Append("UIObject")
tiltTitle.Text = "TILT Min and Max "
tiltTitle.ContentDriven = "Yes"
tiltTitle.ContentWidth = "No"
tiltTitle.TextAutoAdjust = "Yes"
tiltTitle.Anchors =  {left = 0, right = 0, top = 4, bottom = 4}
tiltTitle.Padding = {left = 0, right = 0 , top = 0, bottom = 0}
tiltTitle.Margin = {left = 470, right = 80, top = 0, bottom = 0}
tiltTitle.Font = "Medium20"
tiltTitle.HasHover = "No"
tiltTitle.Texture = ""
tiltTitle.TextColor =  saumonBackground



local faderGrid = dlgFrame:Append("UILayoutGrid")
faderGrid.Columns = 4
faderGrid.Rows = 1 
faderGrid.Anchors = {left = 0, right = 0, top = 5, bottom = 5}
faderGrid.Margin = {left = 20, right = 20, top = 15, bottom = 15}
local fader1 = faderGrid:Append("UiFader")
fader1.Anchors = {left = 0, right = 0, top = 0, bottom = 0 }
fader1.Margin = {left = 20, right = 20, top = 0, bottom = 0}
fader1.Text = "Pan 'MIN' "
fader1.Changed = "panMinFaderChanged"
fader1.PluginComponent = myHandle
local myobject = ShowData().Masters.Playback[46]
local myproperty = 'NormedValue'
myobject[myproperty] = 50
fader1.Target = myobject


local fader2 = faderGrid:Append("UiFader")
fader2.Anchors = {left = 1, right = 1, top = 0, bottom = 0}
fader2.Margin = {left = 0, right = 40, top = 0, bottom = 0}
fader2.Text = "Pan 'MAX' "
fader2.Changed = "panMaxFaderChanged"
fader2.PluginComponent = myHandle
local myobject = ShowData().Masters.Playback[47]
local myproperty = 'NormedValue'
myobject[myproperty] = 50
fader2.Target = myobject


local fader3 = faderGrid:Append("UiFader")
fader3.Anchors = {left = 2, right = 2, top = 0, bottom = 0}
fader3.Margin = {left = 40, right = 0, top = 0, bottom = 0}
fader3.Text = "Tilt 'MIN' " 
fader3.Changed = "tiltMinFaderChanged"
fader3.PluginComponent = myHandle
local myobject = ShowData().Masters.Playback[48]
local myproperty = 'NormedValue'
myobject[myproperty] = 50
fader3.Target = myobject


local fader4 = faderGrid:Append("UiFader")
fader4.Anchors = {left = 3, right = 3, top = 0, bottom = 0}
fader4.Margin = {left = 20, right = 20, top = 0, bottom = 0}
fader4.Text = "Tilt 'MAX' " 
fader4.Changed = "tiltMaxFaderChanged"
fader4.PluginComponent = myHandle
local myobject = ShowData().Masters.Playback[49]
local myproperty = 'NormedValue'
myobject[myproperty] = 50
fader4.Target = myobject


local applyB = dlgFrame:Append("UILayoutGrid")
applyB.Columns = 1 
applyB.Rows = 1
applyB.Anchors = {left = 0, right = 0, top = 6, bottom = 6}
applyB.Margin = {left = 0, right = 0, top = 0, bottom = 0}
local applyButton2 = applyB:Append("Button");
applyButton2.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
applyButton2.Margin = {left = 300, right = 300, top = 0, bottom = 0}
applyButton2.Text = "Apply"
applyButton2.TextColor = saumonBackground
applyButton2.Clicked = "applyRandom"
applyButton2.PluginComponent = myHandle
applyButton2.TextalignmentH = "Centre"
applyButton2.Texture = "corner15"
applyButton2.Font = "Medium20"


local line2B = dlgFrame:Append("UILayoutGrid")
line2B.Columns = 1
line2B.Rows = 1
line2B.Anchors = {left = 0 , right = 0, top = 7, bottom = 7}
line2B.Margin = {left = 0, right = 0, top = -40, bottom = 0}
local line2 = line2B:Append("Button");
line2.Anchors = {left = 0, right = 0, top = 0, bottom = 0}
line2.Margin = {left = 50, right = 50, top = 60, bottom = 0}
line2.TextShadow = 1;
line2.HasHover = "Yes";
line2.Text = "";
line2.Font = "Medium20";
line2.TextalignmentH = "Centre";
line2.PluginComponent = myHandle;
line2.Clicked = "Clicked"
line2.Texture = "treeview_horizontal"


local input1Icon = dlgFrame:Append("UILayoutGrid")
input1Icon.Columns = 2
input1Icon.Rows = 1
input1Icon.Anchors = { left = 0, right = 0, top = 8, bottom = 8}
input1Icon.Margin = {left = 0, right = 0, top = 30, bottom = 0}


local inputEdit = input1Icon:Append("Button")
inputEdit.Icon = "object_datapool"
inputEdit.Margin = {left = 320, right = 360, top = 0, bottom = 0}
inputEdit.Text = ""
inputEdit.HasHover = "No";
inputEdit.Padding = "5,5"
inputEdit.Texture = ""


local inputLineEdit = input1Icon:Append("LineEdit")  
inputLineEdit.Margin = { left = 0 , right = 10, top = 0, bottom = 0}
inputLineEdit.Anchors = {left = 1, right = 1, top = 0, bottom = 0}
inputLineEdit.Prompt = "Preset 2.  "
inputLineEdit.TextAutoAdjust = "Yes"
inputLineEdit.Filter = "0123456789"
inputLineEdit.VkPluginName = "TextInputNumOnly"
inputLineEdit.Content = ""
inputLineEdit.MaxTextLength = 3
inputLineEdit.HideFocusFrame = "Yes"
inputLineEdit.PluginComponent = myHandle
inputLineEdit.TextChanged = "OnInput1TextChanged"
inputLineEdit.Texture = "corner15"


local okButton = dlgFrame:Append("UILayoutGrid")
okButton.Columns = 1 
okButton.Rows = 1    
okButton.Anchors = { left = 0, right = 0, top = 8, bottom = 8}
okButton.Margin = {left = 0, right = 0, top = 30, bottom = 0}


local okB = okButton:Append("Button")
okB.Anchors = { left = 0, right = 0, top = 0, bottom = 0} 
okB.Margin = { left = 160, right = 430, top = 0, bottom = 0}
okB.Textshadow = 1;
okB.HasHover = "Yes";
okB.Text = "Store Preset";
okB.Font = "Medium20";
okB.TextalignmentH = "Centre";
okB.PluginComponent = myHandle
okB.Clicked = "storePreset"
okB.Texture = "corner15"


local buttonGrid = dlgFrame:Append("UILayoutGrid")
buttonGrid.Columns = 2
buttonGrid.Rows = 1
buttonGrid.Anchors = { left = 0, right = 0, top = 9, bottom = 9}
buttonGrid.Margin = {left = 0, right = 0, top = 115, bottom = -115}


local applyButton = buttonGrid:Append("Button");
applyButton.Anchors = {left = 0, right = 0, top = 0, bottom = 0};
applyButton.Textshadow = 1;
applyButton.HasHover = "Yes";
applyButton.Text = "Apply";
applyButton.Font = "Medium20";
applyButton.TextalignmentH = "Centre";
applyButton.PluginComponent = myHandle;
applyButton.Clicked = "ApplyButtonClicked";



local cancelButton = buttonGrid:Append("Button");
cancelButton.Anchors = {left = 1, right = 1, top = 0, bottom = 0};
cancelButton.Textshadow = 1;
cancelButton.HasHover = "Yes";
cancelButton.Text = "Cancel";
cancelButton.Font = "Medium20";
cancelButton.TextalignmentH = "Centre";
cancelButton.PluginComponent = myHandle;
cancelButton.Clicked = "CancelButtonClicked";

---------------------------------------------------------------------------------------SIGNAL TABLES------------------------------------------------------------------------------------

    signalTable.CancelButtonClicked = function(caller)
    MessageBox({title = "Cancel - Abandonned" , message = "Random position generation was cancelled by the user." , commands = {{value = 1 , name = "OK" }} , timeout = 2000 })
    Obj.Delete(screenOverlay, Obj.Index(baseInput))
  end

  signalTable.ApplyButtonClicked = function(caller)
    Obj.Delete(screenOverlay, Obj.Index(baseInput))
    Echo("Application 'RandoMA Positions'  Be Terminated with Sucefully" )
    Printf("Application 'RandoMA Positions' Be Terminated with Sucefully")
    Cmd("ClearAll")
  end

signalTable.OnInput1TextChanged = function(caller)
    numberPreset = caller.Content
end

signalTable.storePreset = function(caller)
  if numberPreset == nil or SelectionCount() == 0 then
    MessageBox({title = "Value Empty" , message = "Please enter a value before storing the preset." , commands = {{value = 1 , name = "OK" }} , timeout = 2000 })

  else
  Cmd("Store Preset 2."..numberPreset)
  MessageBox({title = "Value Empty" , message = "The preset 2." ..numberPreset.. " was stored succefully "  , commands = {{value = 1 , name = "OK" }} , timeout = 2000 })

  end
end

signalTable.openButton = function(caller)
  Cmd("Grid 'Linearize' 'Numerical'")
  randommValues(315, -315, 135, -135)
end

signalTable.blockedButton = function(caller)
   Cmd("Attribute 'PAN' At default")
   Cmd("Attribute 'TILT' At default")
   Cmd("Grid 'Linearize' 'Numerical'")

    signalTable.tiltMaxFaderChanged = function(tiltMax)
      local raw = tostring(tiltMax.Value):gsub("%%", ""):gsub(",", "."):match("%S+")
      local floatValue = tonumber(raw)
      if not floatValue then return 0 end
      local mapped = (floatValue - 50) / 50 * 255
      local mappedValues = math.floor(mapped + 0.5)
      Cmd("Attribute 'TILT' At " ..mappedValues)
      tiltMaxValue = mappedValues
    end

    signalTable.tiltMinFaderChanged = function(tiltMin)
      local raw = tostring(tiltMin.Value):gsub("%%", ""):gsub(",", "."):match("%S+")
      local floatValue = tonumber(raw)
      if not floatValue then return 0 end
      local mapped = (floatValue - 50) / 50 * 255
      local mappedValues = math.floor(mapped + 0.5)
      Cmd("Attribute 'TILT' At " ..mappedValues)
      tiltMinValue = mappedValues
    end

    signalTable.panMaxFaderChanged = function(panMax)
      local raw = tostring(panMax.Value):gsub("%%", ""):gsub(",", "."):match("%S+")
      local floatValue = tonumber(raw)
      if not floatValue then return 0 end
      local mapped = (floatValue - 50) / 50 * 255
      local mappedValues =  math.floor(mapped + 0.5)
      Cmd("Attribute 'PAN' At " ..mappedValues)
      panMaxValue = mappedValues
    end

    signalTable.panMinFaderChanged = function(panMin)
      local raw = tostring(panMin.Value):gsub("%%", ""):gsub(",", "."):match("%S+")
      local floatValue = tonumber(raw)
      if not floatValue then return 0 end
      local mapped = (floatValue - 50) / 50 * 255
      local mappedValues =  math.floor(mapped + 0.5)
      Cmd("Attribute 'PAN' At " ..mappedValues)
      panMinValue = mappedValues
    end

        signalTable.applyRandom = function(applyRandomm)
          randommValues(panMinValue , panMaxValue , tiltMaxValue, tiltMinValue)
        end
      end
    end

    return UI_MAIN