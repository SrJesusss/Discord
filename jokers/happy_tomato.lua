SMODS.Joker{ --Happy Tomato
    key = "happy_tomato",
    config = {
        extra = {
            moneyvar = 10,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Happy Tomato',
        ['text'] = {
            [1] = 'Earn {C:money}$#1#{} at end of round',
            [2] = 'and decreases by {C:money}$2{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.16
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_food"] = true, ["discord_dm_me"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.moneyvar}}
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
        if (card.ability.extra.moneyvar or 0) >= 4 then
            local moneyvar_value = card.ability.extra.moneyvar
            return {
                dollars = moneyvar_value,
                extra = {
                func = function()
                    card.ability.extra.moneyvar = math.max(0, (card.ability.extra.moneyvar) - 2)
                    return true
                    end,
                    colour = G.C.RED
                }
            }
        elseif (card.ability.extra.moneyvar or 0) <= 2 then
            local moneyvar_value = card.ability.extra.moneyvar
            return {
                dollars = moneyvar_value,
                extra = {
                func = function()
                    card.ability.extra.moneyvar = math.max(0, (card.ability.extra.moneyvar) - 2)
                    return true
                    end,
                    colour = G.C.RED,
                    extra = {
                    func = function()
                        card:start_dissolve()
                        return true
                        end,
                        colour = G.C.RED
                    }
                }
            }
        end
    end
end
}