SMODS.Joker{ --Red Theme
    key = "red_theme",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Red Theme',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.3{} Mult when any',
            [2] = '{C:attention}Booster Pack{} is skipped',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 3
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.21
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
        
        return {vars = {card.ability.extra.xmultvar}}
    end,

    
    calculate = function(self, card, context)
        if context.skipping_booster  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.3
                    return true
                    end
                }
            end
            if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.xmultvar
                }
            end
        end
}