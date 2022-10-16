# player-debouncer

sample usage <br>
```
local debounceId = laserPart.Name
local DEBOUNCE_DURATION = 3
LaserPart.Touched:Connect(function(partTouched)
    -- params are (part that touched, unique id for this part, part listening for touches, duration of debounce, callback function)
		PlayerDebouncer.HandleTouch(partTouched, debounceId, LaserPart, DEBOUNCE_DURATION, function(character, humanoid)
		  self:damagePlayer(character, humanoid)
	  end)
end)

```
