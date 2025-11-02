SMODS.Joker{ --Half a Dima
    key = "half_a_dima",
    config = {
        extra = {
            odds = 3,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Half a Dima',
        ['text'] = {
            [1] = 'When a {C:attention}Booster Pack{} is skipped',
            [2] = '{C:green}#2# in #3#{} chance to create {C:attention}Red Card{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.16
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
        
        local info_queue_0 = G.P_CENTERS["j_red_card"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_red_card\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_half_a_dima') 
        return {vars = {card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.skipping_booster  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_dcd02fe1', 1, card.ability.extra.odds, 'j_discord_half_a_dima', false) then
                        SMODS.calculate_effect({func = function()
                            
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_red_card' })
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