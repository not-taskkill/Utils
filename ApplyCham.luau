local ApplyCham = {}

local CoreGui = game:GetService("CoreGui")
local PARENT = nil

local Chams = {}

local function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

if get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	Main.Parent = hiddenUI()
	PARENT = Main
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	syn.protect_gui(Main)
	Main.Parent = CoreGui
	PARENT = Main
elseif CoreGui:FindFirstChild("RobloxGui") then
	PARENT = CoreGui.RobloxGui
else
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	Main.Parent = CoreGui
	PARENT = Main
end

local function toTable(v)
	if typeof(v) == "Instance" then
		return {v}
	elseif typeof(v) == "table" then
		return v
	else
		error("[ApplyCham]: invalid parameter (expected Instance or table)")
	end
end

function ApplyCham.new(Object, Color: Color3, Ancestry)
	assert(Object, "[ApplyCham]: Object for ApplyCham doenst exist.")
	assert(Color, "[ApplyCham]: Color for Cham is nil or invalid.")
	assert(Ancestry, "[ApplyCham]: Adornee for ApplyCham doenst exist.")

	local objects = toTable(Object)
	local ancestries = toTable(Ancestry)

	for _, obj in ipairs(objects) do
		local Cham = Instance.new("Highlight")
		Cham.Name = randomString()
		Cham.Enabled = true
		Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Cham.FillColor = Color
		Cham.OutlineColor = Color
		Cham.FillTransparency = 0.65
		Cham.OutlineTransparency = 0

		Cham.Parent = PARENT
		Cham.Adornee = obj

		table.insert(Chams, Cham)

		obj.AncestryChanged:Connect(function(_, newParent)
			local valid = false
			for _, a in ipairs(ancestries) do
				if newParent == a then
					valid = true
					break
				end
			end

			if not valid then
				table.remove(Chams, table.find(Chams, Cham))
				pcall(game.Destroy, Cham)
				return
			end
		end)
	end
end

function ApplyCham.clear()
	for _, cm in pairs(Chams) do
		pcall(game.Destroy, cm)
	end
	table.clear(Chams)
end

return ApplyCham
