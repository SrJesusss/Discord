SMODS.Joker{ --Glitchkat10
    key = "glitchkat10",
    config = {
        extra = {
            ante_value = 1
        }
    },
    loc_txt = {
        ['name'] = 'Glitchkat10',
        ['text'] = {
            [1] = 'Prevents Death if Chips scored are at',
            [2] = 'least {C:attention}50%{} of required Chips {C:attention}+1{} Ante'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.17
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
    if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
        if G.GAME.chips / G.GAME.blind.chips >= to_big(0.5) then
            return {
                saved = true,
                message = localize('k_saved_ex'),
                extra = {
                func = function()
                    local mod = card.ability.extra.ante_value
                    		ease_ante(mod)
                    		G.E_MANAGER:add_event(Event({
                    			func = function()
                        				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
                        				return true
                        			end,
                    		}))
                    return true
                    end,
                    message = "Ante +" .. card.ability.extra.ante_value,
                    colour = G.C.FILTER
                }
            }
        end
    end
end
}