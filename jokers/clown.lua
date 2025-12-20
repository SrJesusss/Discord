
SMODS.Joker{ --Clown
    key = "clown",
    config = {
        extra = {
            dollars0 = 1,
            dollars = 1
        }
    },
    loc_txt = {
        ['name'] = 'Clown',
        ['text'] = {
            [1] = 'Earn {C:money}$1{} when a card is {C:attention}bought{},',
            [2] = 'lose {C:money}$1{} when a card is {C:attention}sold{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.24
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    dependencies = {"kloun"},
    pools = { ["discord_dm_me"] = true },
    
    calculate = function(self, card, context)
        if context.selling_card  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars - 1
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(1), colour = G.C.MONEY})
                    return true
                end
            }
        end
        if context.buying_card  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 1
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}