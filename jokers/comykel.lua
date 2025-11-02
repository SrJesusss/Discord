SMODS.Joker{ --Comykel
    key = "comykel",
    config = {
        extra = {
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Comykel',
        ['text'] = {
            [1] = 'When a card with {C:attention}Ace{} rank is played',
            [2] = 'and scores {C:green}#1# in #2#{} chance',
            [3] = 'to give a random {C:enhanced}Seal{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_comykel') 
        return {vars = {new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                if SMODS.pseudorandom_probability(card, 'group_0_c0d66ebd', 1, card.ability.extra.odds, 'j_discord_comykel', false) then
                    local random_seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                    if random_seal then
                        context.other_card:set_seal(random_seal, true)
                    end
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
                    end
                end
            end
        end
}