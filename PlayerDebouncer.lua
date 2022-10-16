local Players = game:GetService("Players")

local PlayerDebouncer = {}

PlayerDebouncer.Players = {}


function PlayerDebouncer.CheckTouchingParts(part, debounceId, duration, callback)
	local touchingParts = part:GetTouchingParts()
	if #touchingParts > 0 then
		for _, partTouched in pairs(touchingParts) do
			PlayerDebouncer.HandleTouch(partTouched, debounceId, part, duration, callback)
		end
	end
end


function PlayerDebouncer.CheckPlayer(player, debounceId, part, duration, callback)
	if not player and typeof(player) ~= "Instance" then
		local msg = "No player found!"
		warn(msg)
		return
	end
	local playerUserId = player.UserId
	local playerDebounces = PlayerDebouncer.Players[playerUserId]
	local debounceOnTable = false
	if #playerDebounces > 0 then
		for _, dbId in pairs(playerDebounces) do
			if debounceId == dbId then
				debounceOnTable = true
			end
		end
	end
	if debounceOnTable == false then
		table.insert(playerDebounces, debounceId)
		task.delay(duration, function()
			local dbIdIndex = table.find(playerDebounces, debounceId)
			if dbIdIndex then
				table.remove(playerDebounces, dbIdIndex)
				PlayerDebouncer.CheckTouchingParts(part, debounceId, duration, callback)
			end
		end)
	end
	return debounceOnTable
end


function PlayerDebouncer.HandleTouch(partTouched, debounceId, part, duration, callback)
	local partParent = partTouched.Parent
	local humanoid = partParent:FindFirstChild("Humanoid")
	if humanoid then
		local character = partParent
		local player = Players:GetPlayerFromCharacter(character)
		if not player then
			local msg = "Player not found!"
			warn(msg)
			return
		end
		local isOnTable = PlayerDebouncer.CheckPlayer(player, debounceId, part, duration, callback)
		if isOnTable == false then
			-- character and humanoid
			callback(character, humanoid)
		end
		return false
	end
end


function PlayerDebouncer.AddPlayer(player)
	if not player and typeof(player) ~= "Instance" then
		local msg = "No player found!"
		warn(msg)
		return
	end
	local playerUserId = player.UserId
	PlayerDebouncer.Players[playerUserId] = {}
end


function PlayerDebouncer.RemovePlayer(player)
	if not player and typeof(player) ~= "Instance" then
		local msg = "No player found!"
		warn(msg)
		return
	end
	local playerUserId = player.UserId
	PlayerDebouncer.Players[playerUserId] = nil
end


return PlayerDebouncer
