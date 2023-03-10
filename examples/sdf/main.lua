local Crisp = require("crisp")

local font = Crisp.newSdfFont(48, 4, "examples/sdf/arial.fnt", "examples/sdf/arial.png")

function love.draw()
  font:print("Hello SDF!", 50, 50, 48)
end
