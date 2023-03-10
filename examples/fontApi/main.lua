local Crisp = require("crisp")

local font = Crisp.newSdfFont(48, 4, "examples/msdf/arial.fnt", "examples/msdf/arial.png")

font:setSize(96)
print(font:getSize()) -- 96
print(font:getHeight()) -- 104
print(font:hasGlyphs("a")) -- true
print(font:getKerning("l", "b")) -- 0
print(font:getWrap("Lorem ipsum dolor sit amet, consectetur adipiscing elit", 300)) -- 274, table

local function drawFontInfo(text, x, y, size)
  font:setSize(size)
  local ascent = font:getAscent()
  local baseline = font:getBaseline()
  local descent = font:getDescent()
  local width = font:getWidth(text)

  love.graphics.setColor(1, 1, 1)
  font:print(text, x, y)

  -- love.graphics.setColor(1, 0, 0, 0.5)
  -- love.graphics.line(x, y + ascent, x + width, y + ascent)

  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.line(x, y + baseline, x + width, y + baseline)

  -- love.graphics.setColor(0, 0, 1, 1)
  -- love.graphics.line(x, y + baseline + descent, x + width, y + baseline + descent)
  --  love.graphics.line(x, y + descent, x + width, y + descent)
end

function love.draw()
    drawFontInfo("Hello World!", 10, 10, 48)
    drawFontInfo("Hello World!", 10, 60, 96)
    drawFontInfo("Hello World!", 10, 160, 120)

    font:setSize(24)
    font:setLineHeight(1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(10, 400, 310, 400)
    font:printf("Lorem ipsum dolor sit amet, consectetur adipiscing elit", 10, 400, 300, "center")
end
