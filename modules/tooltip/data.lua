local E, F, C = unpack(select(2, ...))

local SPELL = STAT_CATEGORY_SPELL
local ITEM = HELPFRAME_ITEM_TITLE
local INSTANCE = INSTANCE
local CURRENCY = CURRENCY
local MOUNT = MOUNT

local spellMatch = 'spell:(%d+)'
local itemMatch = 'item:(%d+)'
local currencyMatch = 'currency:(%d+)'

local lineFormat = '%s ' .. ID .. ': |cff93ccea%s|r'
local function AddLine(type, id)
	GameTooltip:AddLine(string.format(lineFormat, type, id or UNKNOWN))
	GameTooltip:Show()
end

hooksecurefunc(GameTooltip, 'SetAction', function(self)
	local _, _, spellID = self:GetSpell()
	if(spellID) then
		AddLine(SPELL, spellID)
	else
		local _, link = self:GetItem()
		if(link) then
			AddLine(ITEM, GetItemCreationContext(link))
		end
	end
end)

hooksecurefunc(GameTooltip, 'SetArtifactPowerByID', function(self, powerID)
	local info = C_ArtifactUI.GetPowerInfo(powerID)
	if(info and info.spellID) then
		AddLine(SPELL, info.spellID)
		AddLine(ARTIFACT_POWER, powerID)
	end
end)

hooksecurefunc(GameTooltip, 'SetAuctionItem', function(self, type, index)
	local link = GetAuctionItemLink(type, index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetAuctionSellItem', function(self)
	local _, link = self:GetItem()
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetBackpackToken', function(self, index)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	local _, _, _, currencyID = GetBackpackCurrencyInfo(index)
	AddLine(CURRENCY, currencyID)
end)

hooksecurefunc(GameTooltip, 'SetBagItem', function(self, container, slot)
	local itemID = GetContainerItemID(container, slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetBuybackItem', function(self, slot)
	local link = GetBuybackItemLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetCurrencyByID', function(self, currencyID)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	AddLine(CURRENCY, currencyID)
end)

hooksecurefunc(GameTooltip, 'SetCurrencyToken', function(self, listIndex)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	local link = GetCurrencyListLink(listIndex)
	if(link) then
		AddLine(CURRENCY, string.match(link, currencyMatch))
	end
end)

hooksecurefunc(GameTooltip, 'SetCurrencyTokenByID', function(self, currencyID)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	AddLine(CURRENCY, currencyID)
end)

hooksecurefunc(GameTooltip, 'SetExistingSocketGem', function(self, slot)
	local link = GetExistingSocketLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetGuildBankItem', function(self, tab, slot)
	local link = GetGuildBankItemLink(tab, slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetHeirloomByItemID', function(self, itemID)
	AddLine(ITEM, itemID)
end)

hooksecurefunc(GameTooltip, 'SetHyperlink', function(self, link)
	local itemID = GetItemInfoFromHyperlink(link)
	if(itemID) then
		AddLine(ITEM, itemID)
	else
		local spellID = string.match(link, spellMatch)
		if(spellID) then
			AddLine(SPELL, spellID)
		end
	end
end)

hooksecurefunc(GameTooltip, 'SetInboxItem', function(self, index, slot)
	local link = GetInboxItemLink(index, slot or 1)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetInventoryItem', function(self, unit, slot)
	local itemID = GetInventoryItemID(unit, slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetItemByID', function(self, itemID)
	AddLine(ITEM, itemID)
end)

hooksecurefunc(GameTooltip, 'SetLFGDungeonReward', function(self, dungeonID, index)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	local _, _, _, _, rewardType, rewardID = GetLFGDungeonRewardInfo(dungeonID, index)
	if(rewardType == 'currency') then
		AddLine(CURRENCY, rewardID)
	elseif(link) then
		AddLine(ITEM, GetItemCreationContext(GetLFGDungeonRewardLink(dungeonID, index)))
	end
end)

hooksecurefunc(GameTooltip, 'SetLFGDungeonShortageReward', function(self, dungeonID, shortage, index)
	local link = GetLFGDungeonShortageRewardLink(dungeonID, shortage, index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetLootCurrency', function(self, slot)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	local link = GetLootSlotLink(slot)
	if(link) then
		AddLine(CURRENCY, string.match(link, currencyMatch))
	end
end)

hooksecurefunc(GameTooltip, 'SetLootItem', function(self, slot)
	local link = GetLootSlotLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetLootRollItem', function(self, index)
	local link = GetLootRollItemLink(index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetMerchantCostItem', function(self, index, currencyIndex)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	local _, _, link = GetMerchantItemCostItem(index, currencyIndex)
	if(link) then
		local itemID = GetItemInfoFromHyperlink(link)
		if(itemID) then
			AddLine(ITEM, itemID)
		else
			AddLine(CURRENCY, string.match(link, currencyMatch))
		end
	end
end)

hooksecurefunc(GameTooltip, 'SetMerchantItem', function(self, slot)
	local link = GetMerchantItemLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetMountBySpellID', function(self, spellID)
	AddLine(SPELL, spellID)

	for _, mountID in next, C_MountJournal.GetMountIDs() do
		local _, listSpellID = C_MountJournal.GetMountInfoByID(mountID)
		if(spellID == listSpellID) then
			return AddLine(MOUNT, mountID)
		end
	end
end)

hooksecurefunc(GameTooltip, 'SetPetAction', function(self)
	local _, _, spellID = self:GetSpell()
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetPvpTalent', function(self, id, isInspect, _, inspectUnit, classID)
	local _, _, _, _, _, spellID = GetPvpTalentInfoByID(id, nil, isInspect, inspectUnit)
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestCurrency', function(self, type, index)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	AddLine(CURRENCY, GetQuestCurrencyID(type, index))
end)

hooksecurefunc(GameTooltip, 'SetQuestItem', function(self, type, index)
	local _, itemID = GetQuestItemInfo(type, index)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestLogCurrency', function(self, type, index)
	-- https://www.townlong-yak.com/framexml/beta/CurrencyContainer.lua
	if(type == 'reward') then
		local _, _, _, currencyID = GetQuestLogRewardCurrencyInfo(index)
		AddLine(CURRENCY, currencyID)
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestLogItem', function(self, type, index)
	local link = GetQuestLogItemLink(type, index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestLogRewardSpell', function(self)
	local _, _, spellID = self:GetSpell()
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestLogSpecialItem', function(self, questIndex)
	local link = GetQuestLogSpecialItemInfo(questIndex)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetQuestRewardSpell', function(self)
	local _, _, spellID = self:GetSpell()
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetRecipeReagentItem', function(self, spellID, index)
	local link = C_TradeSkillUI.GetRecipeReagentItemLink(spellID, index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetRecipeResultItem', function(self, spellID)
	AddLine(SPELL, spellID)
end)

hooksecurefunc(GameTooltip, 'SetSendMailItem', function(self, slot)
	local link = GetSendMailItemLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetShapeshift', function(self, index)
	local _, _, _, _, spellID = GetShapeshiftFormInfo(index)
	AddLine(SPELL, spellID)
end)

hooksecurefunc(GameTooltip, 'SetSocketGem', function(self, slot)
	local link = GetNewSocketLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetSpellBookItem', function(self, slot, bookType)
	local _, spellID = GetSpellBookItemInfo(slot, bookType)
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetSpellByID', function(self, spellID)
	AddLine(SPELL, spellID)
end)

hooksecurefunc(GameTooltip, 'SetTalent', function(self, spellID, isInspect, talentGroup)
	AddLine(SPELL, spellID)
end)

hooksecurefunc(GameTooltip, 'SetTotem', function(self, index)
	local _, name = GetTotemInfo(index)
	local _, _, _, _, _, _, spellID = GetSpellInfo(name)
	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)

hooksecurefunc(GameTooltip, 'SetToyByItemID', function(self, itemID)
	AddLine(ITEM, itemID)
end)

hooksecurefunc(GameTooltip, 'SetTradePlayerItem', function(self, slot)
	local link = GetTradePlayerItemLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetTradeTargetItem', function(self, slot)
	local link = GetTradeTargetItemLink(slot)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetTrainerService', function(self, index)
	local _, _, spellID = self:GetSpell()
	if(spellID) then
		AddLine(SPELL, spellID)
	end

	local link = GetTrainerServiceItemLink(index)
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetTransmogrifyItem', function(self, slot)
	local itemID = GetInventoryItemID('player', slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetUpgradeItem', function(self)
	local _, link = self:GetItem()
	if(link) then
		AddLine(ITEM, GetItemCreationContext(link))
	end
end)

hooksecurefunc(GameTooltip, 'SetVoidDepositItem', function(self, slot)
	local itemID = GetVoidTransferDepositInfo(slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetVoidItem', function(self, page, slot)
	local itemID = GetVoidItemInfo(page, slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetVoidWithdrawalItem', function(self, slot)
	local itemID = GetVoidTransferWithdrawalInfo(slot)
	if(itemID) then
		AddLine(ITEM, itemID)
	end
end)

hooksecurefunc(GameTooltip, 'SetUnitAura', function(self, unit, index, filter)
	local spellID, _
	if(C.BfA) then
		_, _, _, _, _, _, _, _, _, spellID = UnitAura(unit, index, filter)
	else
		_, _, _, _, _, _, _, _, _, _, spellID = UnitAura(unit, index, filter)
	end

	if(spellID) then
		AddLine(SPELL, spellID)
	end
end)
