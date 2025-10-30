SMODS.Joker{ --Sillyz / Jimbo
    key = "sillyz_jimbo",
    config = {
        extra = {
            odds = 4,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Sillyz / Jimbo',
        ['text'] = {
            [1] = 'When a card is bought',
            [2] = '{C:green}#2# in #3#{} chance to create {C:attention}Joker{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.2
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
        
        local info_queue_0 = G.P_CENTERS["j_joker"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_joker\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_sillyz_jimbo') 
        return {vars = {card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.buying_card  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_1861d010', 1, card.ability.extra.odds, 'j_discord_sillyz_jimbo', false) then
                        SMODS.calculate_effect({func = function()
                            
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_joker' })
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