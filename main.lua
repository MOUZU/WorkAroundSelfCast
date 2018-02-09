

-- we're trying to avoid issues with selfcast by hooking the PallyPower method,
-- which is calling the CastSpell() function, and disabling and re-enabling the
-- CVar in our config.wtf file
hooked_PallyPowerBuffButton_OnClick = PallyPowerBuffButton_OnClick
function workaround_PallyPowerBuffButton_OnClick(btn, mousebtn)
    if GetCVar("autoSelfCast") then
        SetCVar("autoSelfCast",0)
        hooked_PallyPowerBuffButton_OnClick(btn, mousebtn)
        SetCVar("autoSelfCast",1)
    else
        hooked_PallyPowerBuffButton_OnClick(btn, mousebtn)
    end
end PallyPowerBuffButton_OnClick = workaround_PallyPowerBuffButton_OnClick