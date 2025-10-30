SMODS.Joker{ --Very Scary Jumpscare
    key = "very_scary_jumpscare",
    config = {
        extra = {
            odds = 5,
            odds2 = 10,
            dollars = 10
        }
    },
    loc_txt = {
        ['name'] = 'Very Scary Jumpscare',
        ['text'] = {
            [1] = 'Played {C:attention}face{} cards have a {C:green}#1# in #2#{}',
            [2] = 'chance to earn {C:money}$10{} when scored',
            [3] = '{C:green}#3# in #4#{} chance to destroy it'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.76
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_very_scary_jumpscare')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_discord_very_scary_jumpscare')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,

    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card:is_face() then
                if SMODS.pseudorandom_probability(card, 'group_0_64a5d223', 1, card.ability.extra.odds, 'j_discord_very_scary_jumpscare', false) then
                        SMODS.calculate_effect({dollars = card.ability.extra.dollars}, card)
                    end
                    if SMODS.pseudorandom_probability(card, 'group_1_0bda6fc3', 1, card.ability.extra.odds2, 'j_discord_very_scary_jumpscare', false) then
                        context.other_card.should_destroy = true
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                    end
                end
            end
        end
}