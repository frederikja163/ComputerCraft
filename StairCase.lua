if not turtle then
  printError("Requires a Turtle")
  return
end

local tArgs = { ... }
if #tArgs ~= 2 then
  local programName = arg[0] or fs.getName(shell.getRunningProgram())
  print('Usage: ' .. programName .. ' <stair-height> <depth>')
end

local stairHeight = tonumber(tArgs[1])
if  stairHeight == nil or stairHeight < 1 then
  print("StairCase depth must be positive")
  return
end

local depth = tonumber(tArgs[2])
if depth == nil or depth < 1 then
  print("StairCase depth must be positive")
  return
end

function digFrontAndBack()
  turtle.dig()
  turtle.turnRight()
  turtle.turnRight()
  turtle.dig()
end

function tryDigForward()
  turtle.dig()
  return turtle.forward()
end

function tryDigUp()
  turtle.digUp()
  return turtle.up()
end

function step()
  if not tryDigForward() then
    return false
  end
  turtle.digDown()
  if turtle.detectDown() then
    return false
  end
  for _ = 1,stairHeight do
    if not tryDigUp() then
      return false
    end
  end
  for _ = 1,stairHeight + 1 do
    turtle.turnLeft()
    digFrontAndBack()
    turtle.down()
  end
  if math.fmod(stairHeight, 2) == 0 then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end
end

for i = 1, depth do
  if not step() then
    print("Stopping stair case")
    return
  end
end
