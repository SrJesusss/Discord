SMODS.Joker{ --Fercorn
    key = "fercorn",
    config = {
        extra = {
            skippedblinds = 0,
            ante_value = 1
        }
    },
    loc_txt = {
        ['name'] = 'Fercorn',
        ['text'] = {
            [1] = 'When {C:attention}3{} Blinds are skipped {C:attention}-1{} Ante',
            [2] = '{C:inactive}(Currently{} {C:attention}#1#{} {C:inactive}Blinds skipped){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 3
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

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.skippedblinds}}
    end,

    
    calculate = function(self, card, context)
        if context.skip_blind  and not context.blueprint then
            if (card.ability.extra.skippedblinds or 0) < 2 then
                return {
                    func = function()
                        card.ability.extra.skippedblinds = (card.ability.extra.skippedblinds) + 1
                        return true
                        end
                    }
                elseif (card.ability.extra.skippedblinds or 0) >= 2 then
                    return {
                        func = function()
                            card.ability.extra.skippedblinds = 0
                            return true
                            end,
                            extra = {
                            func = function()
                                local mod = -card.ability.extra.ante_value
                                		ease_ante(mod)
                                		G.E_MANAGER:add_event(Event({
                                			func = function()
                                    				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
                                    				return true
                                    			end,
                                		}))
                                return true
                                end,
                                message = "Ante -" .. card.ability.extra.ante_value,
                                colour = G.C.FILTER
                            }
                        }
                    end
                end
            end
}