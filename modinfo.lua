-- modinfo.lua

local language = "zh" -- "zh" for Chinese, "en" for English, "jp" for Japanese

local modinfo = {
    zh = {
        name = "自定义武器和手杖切换",
        description = [[
一个允许玩家按下R键切换到火腿棒、长矛或暗夜剑，并按下Shift键切换到步行手杖、吴迪的木手杖或懒人魔杖的模组。
本地模组，玩家可以自行设置想要的武器和手杖，满足不同的战斗需求。
]],
        switchkey_label = "切换武器快捷键",
        switchkey_hover = "按下此键切换到火腿棒、长矛或暗夜剑",
        summonkey_label = "切换手杖快捷键",
        summonkey_hover = "按下此键切换到步行手杖、吴迪的木手杖或懒人魔杖",
    },
    en = {
        name = "Custom Weapon and Staff Switcher",
        description = [[
A mod that allows players to switch to a Ham Bat, Spear, or Dark Sword by pressing the R key, and switch to a walking cane, Woody's wooden cane, or Lazy Explorer by pressing the Shift key.
Players can customize their desired weapons and staffs to meet different combat needs.
]],
        switchkey_label = "Switch Weapon Hotkey",
        switchkey_hover = "Press this key to switch to a Ham Bat, Spear, or Dark Sword",
        summonkey_label = "Switch Staff Hotkey",
        summonkey_hover = "Press this key to switch to a walking cane, Woody's wooden cane, or Lazy Explorer",
    },
    jp = {
        name = "カスタム武器と杖の切り替え",
        description = [[
Rキーを押すことでハムバット、槍、またはダークソードに切り替え、Shiftキーを押すことでウォーキングケイン、ウッディの木の杖、またはレイジーエクスプローラーに切り替えることができるMODです。
プレイヤーは自分の望む武器と杖をカスタマイズして、さまざまな戦闘ニーズに対応できます。
]],
        switchkey_label = "武器切り替えホットキー",
        switchkey_hover = "このキーを押してハムバット、槍、またはダークソードに切り替えます",
        summonkey_label = "杖切り替えホットキー",
        summonkey_hover = "このキーを押してウォーキングケイン、ウッディの木の杖、またはレイジーエクスプローラーに切り替えます",
    }
}

local selected_language = modinfo[language]

name = selected_language.name
description = selected_language.description
author = "77（https://steamcommunity.com/id/sweetf77)"
version = "1.0"
forumthread = "/"
icon_atlas = "modicon.xml"
icon = "modicon.tex"
client_only_mod = true  -- 设置为 true，表示这是一个客户端模组
all_clients_require_mod = false
server_only_mod = false  -- 设置为 false，表示这不是一个服务器专用模组
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
api_version = 10

local keys = {
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    "LSHIFT","LALT","LCTRL","TAB","BACKSPACE","PERIOD","SLASH","TILDE",
}

configuration_options = {
    {
        name = "switchkey",
        label = selected_language.switchkey_label,
        hover = selected_language.switchkey_hover,
        options = {
            --稍后填充
        },
        default = "R",
    },
    {
        name = "summonkey",
        label = selected_language.summonkey_label,
        hover = selected_language.summonkey_hover,
        options = {
            --稍后填充
        },
        default = "LSHIFT",
    },
}

local function filltable(tbl)
    for i = 1, #keys do
        tbl[i] = {description = keys[i], data = keys[i]}
    end
end

filltable(configuration_options[1].options)
filltable(configuration_options[2].options)
