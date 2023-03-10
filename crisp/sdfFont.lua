local PATH = string.sub(..., 1, string.len(...) - string.len("crisp.sdfFont"))

local SdfShader = love.graphics.newShader(PATH .. "crisp/sdfShader.glsl")

---@class Crisp.SdfFont
---
---@field private _font love.Font
---
---@field private _createdSize integer
---@field private _distanceRange integer
---
---@field private _size number
---@field private _scale number
local SdfFont = {}
local mt = { __index = SdfFont }

---@param size integer
---@param distanceRange integer
---@param fileName string
---@param imageFileName string
---@return Crisp.SdfFont
function SdfFont.new(size, distanceRange, fileName, imageFileName)
	local sdfFont = setmetatable({
		_font = love.graphics.newFont(fileName, imageFileName),

		_createdSize   = size,
		_distanceRange = distanceRange,

		_size = size,
		_scale = 1,
	}, mt)

	sdfFont:_updateScale()

	return sdfFont
end

---comment
---@return self
---@private
function SdfFont:_updateScale()
	self._scale = self._size / self._createdSize
	return self
end

---comment
---@param size any
---@return self
function SdfFont:setSize(size)
	self._size = size
	self:_updateScale()

	return self
end

---comment
---@return number
---@nodiscard
function SdfFont:getSize()
	return self._size
end

---comment
---@return number
---@nodiscard
function SdfFont:getAscent()
	return self._font:getAscent() * self._scale
end

---comment
---@return number
---@nodiscard
function SdfFont:getBaseline()
	return self._font:getBaseline() * self._scale
end

---comment
---@return number
---@nodiscard
function SdfFont:getDescent()
	return self._font:getDescent() * self._scale
end

---comment
---@return number
---@nodiscard
function SdfFont:getHeight()
	return self._font:getHeight() * self._scale
end

---comment
---@param leftchar any
---@param rightchar any
---@return number
---@nodiscard
function SdfFont:getKerning(leftchar, rightchar)
	return self._font:getKerning(leftchar, rightchar) * self._scale
end

---comment
---@return number
---@nodiscard
function SdfFont:getLineHeight()
	return self._font:getLineHeight()
end

---comment
---@param height any
---@return self
function SdfFont:setLineHeight(height)
	self._font:setLineHeight(height)
	return self
end

---comment
---@param text any
---@return number
---@nodiscard
function SdfFont:getWidth(text)
	return self._font:getWidth(text) * self._scale
end

---comment
---@param text any
---@param wraplimit any
---@return number
---@return table
---@nodiscard
function SdfFont:getWrap(text, wraplimit)
	local width, wrappedtext = self._font:getWrap(text, wraplimit / self._scale)
	return width * self._scale, wrappedtext
end

---comment
---@param text any
---@param ... unknown
---@return boolean
---@nodiscard
function SdfFont:hasGlyphs(text, ...)
	return self._font:hasGlyphs(text, ...)
end

---Draws text on screen
---@param text string|table The text to draw
---@param x number The position to draw the text (x-axis)
---@param y number The position to draw the text (y-axis)
---@param r? number Orientation (radians)
---@param ox? number Origin offset (x-axis)
---@param oy? number Origin offset (y-axis)
---@param kx? number Shearing factor (x-axis)
---@param ky? number Shearing factor (y-axis)
---@return self
function SdfFont:print(text, x, y, r, ox, oy, kx, ky)
	love.graphics.push("all")

	SdfShader:send("screenPxRange", self._distanceRange * self._scale)

	love.graphics.setFont(self._font)
	love.graphics.setShader(SdfShader)
	love.graphics.print(text, x, y, r, self._scale, self._scale, ox, oy, kx, ky)

	love.graphics.pop()

	return self
end

---Draws text on screen
---@param text string|table The text to draw
---@param x number The position to draw the text (x-axis)
---@param y number The position to draw the text (y-axis)
---@param limit number Wrap the line after this many horizontal pixels.
---@param align love.AlignMode The alignment
---@param r? number Orientation (radians)
---@param ox? number Origin offset (x-axis)
---@param oy? number Origin offset (y-axis)
---@param kx? number Shearing factor (x-axis)
---@param ky? number Shearing factor (y-axis)
---@return self
function SdfFont:printf(text, x, y, limit, align, r, ox, oy, kx, ky)
	love.graphics.push("all")

	SdfShader:send("screenPxRange", self._distanceRange * self._scale)

	love.graphics.setFont(self._font)
	love.graphics.setShader(SdfShader)
	love.graphics.printf(text, x, y, limit / self._scale, align, r, self._scale, self._scale, ox, oy, kx, ky)

	love.graphics.pop()

	return self
end

return SdfFont
