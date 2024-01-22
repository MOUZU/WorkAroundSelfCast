-- We're trying to avoid issues with selfcast by hooking methods for addons which require autoSelfCast to be disabled
-- If the CVar is set, we unset it, run the original method, and reset it after we're done
-- If the CVar is not set, we simply call the original method

local function HookIt(functionName, infoName)
	local hooked = _G[functionName]
	if hooked ~= nil then
		local function workaround(a1, a2)
			if GetCVar("autoSelfCast") == "1" then
				SetCVar("autoSelfCast", "0")
				hooked(a1, a2)
				SetCVar("autoSelfCast", "1")
			else
				hooked(a1, a2)
			end
		end
		_G[functionName] = workaround
		return true
	end
	return false
end

WorkaroundSelfCastFrame = CreateFrame("Frame")
WorkaroundSelfCastFrame:RegisterEvent("ADDON_LOADED")
WorkaroundSelfCastFrame:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == "WorkAroundSelfCast" then
		local enabled = {}
		if HookIt("Dcr_Clean") then table.insert(enabled, "Decursive") end
	  if HookIt("PallyPowerBuffButton_OnClick") then table.insert(enabled, "Pally Power") end
		if getn(enabled) == 0 then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00a86bWorkAroundSelfCast|r is not enabled for any addons")
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff00a86bWorkAroundSelfCast|r is enabled for: " .. table.concat(enabled, ", "))
		end
  end
end)
