
SMODS.Joker{ --Happy Tomato
    key = "happy_tomato",
    config = {
        extra = {
            moneyvar = 10
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
        x = 0,
        y = 1
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
            if to_big((card.ability.extra.moneyvar or 0)) >= to_big(4) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.moneyvar_value
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.moneyvar_value), colour = G.C.MONEY})
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.moneyvar = math.max(0, (card.ability.extra.moneyvar) - 2)
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            elseif to_big((card.ability.extra.moneyvar or 0)) <= to_big(2) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.moneyvar_value
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.moneyvar_value), colour = G.C.MONEY})
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.moneyvar = math.max(0, (card.ability.extra.moneyvar) - 2)
                            return true
                        end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local target_joker = card
                                
                                if target_joker then
                                    target_joker.getting_sliced = true
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                                end
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