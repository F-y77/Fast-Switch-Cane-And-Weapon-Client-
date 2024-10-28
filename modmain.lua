-- modmain.lua

-- 引入全局变量
local G = GLOBAL
local keybind_switch = G["KEY_"..GetModConfigData("switchkey")]
local keybind_staff = G["KEY_"..GetModConfigData("summonkey")]

local weapon_items = { "hambat", "spear", "nightsword" } --请往这里面添加你想要的武器名称代码 Please Add Your Weapon Name Code Here 
local staff_items = { "cane", "walking_stick", "orangestaff" } --请往这里面添加你想要的手杖名称代码 Please Add Your Staff Name Code Here

-- 判断当前是否在游戏中
local function IsInGameplay()
    return G.ThePlayer ~= nil and G.TheFrontEnd:GetActiveScreen().name == "HUD"
end

-- 从背包中获取指定的物品
local function GetItemFromInventory(item_list)
    local items = G.ThePlayer.replica.inventory:GetItems()
    local backpack = G.ThePlayer.replica.inventory:GetEquippedItem(G.EQUIPSLOTS.BODY)
    local packitems = backpack and backpack.replica.container and backpack.replica.container:GetItems() or nil
    local found_item = nil

    for _, item in pairs(items) do
        if G.table.contains(item_list, item.prefab) then
            found_item = item
            break
        end
    end

    if found_item ~= nil or packitems == nil then return found_item end

    for _, item in pairs(packitems) do
        if G.table.contains(item_list, item.prefab) then
            found_item = item
            break
        end
    end

    return found_item
end

-- 装备指定物品
local function EquipItem(player, item_list)
    if not IsInGameplay() then return end
    local item = GetItemFromInventory(item_list)
    if item == nil then return end

    local buffact = G.BufferedAction(player, nil, G.ACTIONS.EQUIP, item)
    if not G.TheWorld.ismastersim then
        local function cb()
            G.SendRPCToServer(G.RPC.ControllerUseItemOnSelfFromInvTile, G.ACTIONS.EQUIP.code, item)
        end
        if player.components.locomotor then
            buffact.preview_cb = cb
        else
            cb()
        end
    end
    player.components.playercontroller:DoAction(buffact)
end

-- 添加键盘按键事件处理，切换武器
G.TheInput:AddKeyDownHandler(keybind_switch, function()
    EquipItem(G.ThePlayer, weapon_items)
end)

-- 添加键盘按键事件处理，切换法杖
G.TheInput:AddKeyDownHandler(keybind_staff, function()
    EquipItem(G.ThePlayer, staff_items)
end)