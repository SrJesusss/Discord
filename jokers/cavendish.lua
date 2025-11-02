SMODS.Joker{ --Cavendish
    key = "cavendish",
    config = {
        extra = {
            odds = 6,
            dm_me = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cavendish',
        ['text'] = {
            [1] = 'At end of round {C:green}#3# in #4#{} chance',
            [2] = 'to create a {C:blue}Discord{} {C:attention}Joker{}',
            [3] = '{C:inactive}(Must have room){}'
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_cavendish') 
        return {vars = {card.ability.extra.dm_me, card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        if true then
        if SMODS.pseudorandom_probability(card, 'group_0_23e2155f', 1, card.ability.extra.odds, 'j_discord_cavendish', false) then
                SMODS.calculate_effect({func = function()
                    
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'discord_dm_me' })
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
                    end}, card)
                end
            end
        end
    end
}