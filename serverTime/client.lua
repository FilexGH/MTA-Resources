local devScreenW, devScreenH = 1280, 800 -- Developer Screen W/H
local ScreenW, ScreenH = guiGetScreenSize()
local newScale = dxGetFontHeight(ScreenW / 16000, "default")
local hourDifference = nil
local minuteDifference = nil
local secondDifference = nil
local theResource = getThisResource()
local position = "topRight" -- position by default
local dimensions = {
  topRight = {
    left = 1100 / devScreenW * ScreenW,
    top = 10 / devScreenH * ScreenH,
    right = 1270 / devScreenW * ScreenW,
    bottom = 26 / devScreenH * ScreenH,
    visible = true
  },
  bottomRight = {
    left = 1100 / devScreenW * ScreenW,
    top = 1530 / devScreenH * ScreenH,
    right = 1310 / devScreenW * ScreenW,
    bottom = 26 / devScreenH * ScreenH,
    visible = true
  },
  bottomLeft = {
    left = 8 / devScreenW * ScreenW,
    top = 1500 / devScreenH * ScreenH,
    right = 230 / devScreenW * ScreenW,
    bottom = 26 / devScreenH * ScreenH,
    visible = true
  }
}

function triggerDataSending()
  triggerServerEvent("data:sending", getLocalPlayer())
  local visibilityFile = fileExists("clockInvisible")
  local cornerPositionFile = fileExists("cornerPosition")
  -- checks visibility
  if visibilityFile then
    removeEventHandler("onClientRender", getRootElement(), drawTime)
    for _index, visibleValue in pairs(dimensions) do 
      visibleValue["visible"] = false
    end 
  end
  -- check position file and gets data from it or creates one with the default position data
  if cornerPositionFile then 
    cornerPositionFile = fileOpen("cornerPosition")
    position = fileRead(cornerPositionFile, fileGetSize(cornerPositionFile))
    iprint(position)
    fileClose(cornerPositionFile)
  else 
    cornerPositionFile = fileCreate ("cornerPosition" )
    fileWrite(cornerPositionFile,position)
    fileClose(cornerPositionFile)
  end 
end
addEventHandler("onClientResourceStart", getResourceRootElement(theResource), triggerDataSending)

function calculateDifference(serverHours, serverMinutes, serverSeconds)
  local localTime = getRealTime()
  hourDifference = serverHours - localTime.hour
  minuteDifference = serverMinutes - localTime.minute
  secondDifference = serverSeconds - localTime.second
end
addEvent("calculate:difference", true)
addEventHandler("calculate:difference", getRootElement(), calculateDifference)

-- this was set to fix the time law
function returnTimeText()
  local localTime = getRealTime()
  local hours = localTime.hour + hourDifference
  local minutes = localTime.minute + minuteDifference
  local seconds = localTime.second + secondDifference
  if seconds > 59 then
    minutes = minutes + 1
    seconds = seconds - 60
  elseif seconds < 0 then
    minutes = minutes - 1
    seconds = seconds + 60
  end

  if minutes > 59 then
    hours = hours + 1
    minutes = minutes - 60
  elseif minutes < 0 then
    hours = hours - 1
    minutes = minutes + 60
  end

  if hours > 23 then
    hours = hours - 24
  elseif hours < 0 then
    hours = hours + 24
  end
  local time = string.format("%02d:%02d:%02d", hours, minutes, seconds)
  text = "Server Time " .. time
  return text
end

function drawTime()
  if hourDifference == nil then
    return
  else
    local text = returnTimeText()
    dxDrawText(
      text,
      dimensions[position]["left"] + 1,
      dimensions[position]["top"] + 1,
      dimensions[position]["right"] + 1,
      dimensions[position]["bottom"] + 1,
      tocolor(0, 0, 0, 255),
      newScale,
      "default",
      "center",
      "center",
      false,
      true,
      true,
      false,
      false
    )
    dxDrawText(
      text,
      dimensions[position]["left"],
      dimensions[position]["top"],
      dimensions[position]["right"],
      dimensions[position]["bottom"],
      tocolor(255, 255, 255, 255),
      newScale,
      "default",
      "center",
      "center",
      false,
      true,
      true,
      false,
      false
    )
  end
end

addEventHandler("onClientRender", getRootElement(), drawTime)
function hideOrShow()
  if (dimensions[position]["visible"] == true) then
    removeEventHandler("onClientRender", getRootElement(), drawTime)
    dimensions[position]["visible"] = false
    local file = fileCreate("clockInvisible")
    fileClose(file)
  elseif (dimensions[position]["visible"] == false) then
    addEventHandler("onClientRender", getRootElement(), drawTime)
    dimensions[position]["visible"] = true
    fileDelete("clockInvisible")
  end
end
addCommandHandler("clock", hideOrShow)

function writeInFile(position)
  local file = fileOpen("cornerPosition")
  fileWrite(file, position)
  fileClose(file)
end

function changeCorner(_, corner)
  if corner == "topright" then
    position = "topRight"
    writeInFile(position)
  elseif corner == "bottomleft" then
    position = "bottomLeft"
    writeInFile(position)
  elseif corner == "bottomright" then
    position = "bottomRight"
    writeInFile(position)
  end
end
addCommandHandler("clockPosition", changeCorner)
