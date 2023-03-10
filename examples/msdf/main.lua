local Crisp = require("crisp")

local font = Crisp.newSdfFont(48, 4, "examples/msdf/arial.fnt", "examples/msdf/arial.png")

function love.draw()
  local size = 16
  font:setSize(size)
  font:print("Hello MSDF!", 50, 50)
end
