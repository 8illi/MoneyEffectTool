-- Money Effect Tool (Visual Only)
-- Put this LocalScript inside a Tool in StarterPack

local tool = script.Parent
local RunService = game:GetService("RunService")

local active = false
local connection
local parts = {}

local function startEffect(character)
	local hrp = character:WaitForChild("HumanoidRootPart")

	for i = 1, 40 do
		local money = Instance.new("Part")
		money.Size = Vector3.new(0.6, 0.3, 0.1)
		money.Material = Enum.Material.Neon
		money.Color = Color3.fromRGB(140, 255, 140)
		money.Anchored = true
		money.CanCollide = false
		money.Parent = workspace
		table.insert(parts, money)
	end

	local t = 0
	connection = RunService.RenderStepped:Connect(function(dt)
		t += dt * 2
		for i, p in ipairs(parts) do
			local a = t + (i / #parts) * math.pi * 2
			local x = 5 * math.sin(a)^3
			local z = 5 * (0.8 * math.cos(a) - 0.3 * math.cos(2*a))
			local y = math.sin(a) * 2
			p.Position = hrp.Position + Vector3.new(x, y + 2, z)
			p.Orientation += Vector3.new(0, 4, 0)
		end
	end)
end

local function stopEffect()
	if connection then connection:Disconnect() end
	for _, p in ipairs(parts) do
		if p then p:Destroy() end
	end
	table.clear(parts)
end

tool.Activated:Connect(function()
	local character = tool.Parent
	if not active then
		active = true
		startEffect(character)
	else
		active = false
		stopEffect()
	end
end)
