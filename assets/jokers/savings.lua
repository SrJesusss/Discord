
SMODS.Joker{ --Savings
    key = "savings",
    config = {
        extra = {
            currentmoney = 0
        }
    },
    loc_txt = {
        ['name'] = 'Savings',
        ['text'] = {
            [1] = 'At end of round',
            [2] = '{C:attention}takes{} all your money',
            [3] = 'and {C:attention}transfer{} it to',
            [4] = 'the {C:attention}sell value{} of this joker'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.48
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_food"] = true, ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {(G.GAME.dollars or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()local my_pos = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            my_pos = i
                            break
                        end
                    end
                    local target_card = G.jokers.cards[my_pos]
                    target_card.ability.extra_value = (card.ability.extra_value or 0) + G.GAME.dollars
                    target_card:set_cost()
                    return true
                end,
                message = "+"..tostring(G.GAME.dollars).." Sell Value",
                extra = {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars - G.GAME.dollars
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(G.GAME.dollars), colour = G.C.MONEY})
                        return true
                    end,
                    colour = G.C.MONEY
                }
            }
        end
    end
}