SMODS.Joker{ --Cavo
    key = "cavo",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Cavo',
        ['text'] = {
            [1] = 'Destroy first discarded card'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.16
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_dm_me"] = true },

    
    calculate = function(self, card, context)
        if context.discard  and not context.blueprint then
            if context.other_card == context.full_hand[1] then
                return {
                    remove = true,
                    message = "Destroyed!"
                }
            end
        end
    end
}