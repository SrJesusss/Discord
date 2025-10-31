SMODS.Joker{ --Underage User
    key = "underage_user",
    config = {
        extra = {
            chips = 8
        }
    },
    loc_txt = {
        ['name'] = 'Underage User',
        ['text'] = {
            [1] = 'Each {C:attention}Wee Joker{} give {C:blue}+8{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.31
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_dm_me"] = true },

    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["j_wee"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_wee\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    
    calculate = function(self, card, context)
        if context.other_joker  then
            if (function()
                return context.other_joker.config.center.key == "j_wee"
                end)() then
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
        end
}