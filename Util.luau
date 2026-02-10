--[[
          ___________________________________
        //            really_ant.            \\
       //                                     \\
      //     Useful functions for developers.  \\
     //                                         \\
    //                really_ant.                \\
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
]]

local Util = {}
Util.Services = {}
setmetatable(Util.Services, {
	__index = function(tble, serv)
		if not rawget(tble, serv) then
			rawset(tble, serv, game:GetService(serv))
		end
		return rawget(tble, serv)
	end,

	__newindex = function()
		return error("Do not set values in this table!")
	end,

	__call = function()
		return error("Do not call this table!")
	end,

	__concat = function(val, tble)
		return `Ant's Utilities {val}`
	end,

	__tostring = function()
		return `Ant's Utilities`
	end,

	__metatable = function()
		return nil
	end
})

Util.lp = Util.Services.Players.LocalPlayer

function Util.GetChar(plr) -- Get Character
	plr = plr or Util.lp
	return plr.Character or plr.CharacterAdded:Wait()
end

function Util.GetCF(plr) -- get cframe
	plr = plr or Util.lp
	return Util.GetChar(plr):GetPivot()
end

function Util.SetCF(plr, CF) -- set cframe
	plr, CF = plr or Util.lp, CF or CFrame.new()
	return pcall(function()
		Util.GetChar(plr):PivotTo(CF)
	end)
end

function Util.RndmStr(val) -- random string
	val = val or 2
	local rand = ""
	for _=1, val do
		task.wait()
		rand = rand..utf8.char(math.random(27, 2000))
	end
	return rand
end

function Util.RndmPlr() -- random player
	local plrs = Util.Services.Players:GetPlayers()
	return plrs[math.random(1, #plrs)]
end

function Util.GetHum(plr) -- Get Humanoid
	plr = plr or Util.lp
	return Util.GetChar(plr):WaitForChild("Humanoid")
end

function Util.GetHRP(plr) -- Get HumanoidRootPart
	plr = plr or Util.lp
	return Util.GetChar(plr):WaitForChild("HumanoidRootPart")
end

function Util.SetVel(plr, vel) --Set Velocity
	plr, vel = plr or Util.lp, vel or Vector3.new()
	return pcall(function()
		Util.GetHRP(plr).Velocity = vel
	end)
end

-- Encrypt and Decrypt use a VERY BASIC SYSTEM and should NOT be relied upon for private matters.
function Util.Encrypt(msg)
	msg = msg or "PlasmaAdmin.xyz"
	local bytes = {}
	msg = msg:reverse()
	for _, letter in pairs(msg:split("")) do
		table.insert(bytes, string.byte(letter))
	end
	return bytes
end

function Util.Decrypt(bytes)
	bytes = bytes or {122, 121, 120, 46, 110, 105, 109, 100, 65, 97, 109, 115, 97, 108, 80}
	local msg = ""
	for _, byte in pairs(bytes) do
		msg = msg..string.char(byte)
	end
	return msg:reverse()
end

setmetatable(Util, {
	__index = function(tble, ind)
		if not rawget(tble, ind) then
			return tble
		end
		return rawget(tble, ind)
	end,

	__newindex = function(tble, k, data)
		rawset(tble, k, data)
		print("Added/Changed Function "..k)
	end,

	__concat = function(val, tble)
		return `{val} Ant's Utilities!`
	end,
	
	__tostring = function()
		return `Ant's Utilities`
	end,
})

print("Loaded "..Util)

return Util
