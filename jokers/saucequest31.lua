SMODS.Joker{ --Saucequest31
    key = "saucequest31",
    config = {
        extra = {
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Saucequest31',
        ['text'] = {
            [1] = 'When {C:attention}Boss Blind{} is defeated, create',
            [2] = 'a {C:uncommon}Uncommon{} {C:attention}Joker{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.29
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

    
    calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
        return {
            func = function()
                
                local created_joker = false
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    created_joker = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Uncommon' })
                        if joker_card then
                            
                            
                        end
                        G.GAME.joker_buffer = 0
                        return true
                        end
                    }))
                end
                if created_joker then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                end
                return true
                end
            }
        end
    end
}