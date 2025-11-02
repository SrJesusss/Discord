SMODS.Joker{ --The Wheel of Misfortune
    key = "the_wheel_of_misfortune",
    config = {
        extra = {
            odds = 4,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Wheel of Misfortune',
        ['text'] = {
            [1] = 'When {C:attention}Wheel of Fortune{} is used and fails',
            [2] = '{C:green}#2# in #3#{} chance to create {C:attention}Wheel of Fortune{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
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
        
        local info_queue_0 = G.P_CENTERS["c_wheel_of_fortune"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_wheel_of_fortune\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_the_wheel_of_misfortune') 
        return {vars = {card.ability.extra.n, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.pseudorandom_result  then
            if (context.identifier == "wheel_of_fortune" and not context.result) then
                if SMODS.pseudorandom_probability(card, 'group_0_c63c03ac', 1, card.ability.extra.odds, 'j_discord_the_wheel_of_misfortune', false) then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nope!", colour = G.C.PURPLE})
                        SMODS.calculate_effect({func = function()
                            
                            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Tarot', key = 'c_wheel_of_fortune'})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                    end
                                }))
                            end
                            delay(0.6)
                            
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                            end
                            return true
                            end}, card)
                        end
                    end
                end
            end
}