local _, Inomena = ...

Inomena.RegisterEvent('MERCHANT_SHOW', function()
	if(CanMerchantRepair()) then
		RepairAllItems()
	end
end)

Inomena.RegisterEvent('PLAYER_REGEN_ENABLED', function()
	UIErrorsFrame:AddMessage('- Combat', 1, 1, 1)
end)

Inomena.RegisterEvent('PLAYER_REGEN_DISABLED', function()
	UIErrorsFrame:AddMessage('+ Combat', 1, 1, 1)
end)

SLASH_TICKETGM1 = '/gm'
SlashCmdList.TICKETGM = ToggleHelpFrame

UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')

-- Disable combatlog
UIParent:UnregisterEvent('PLAYER_LOGIN')