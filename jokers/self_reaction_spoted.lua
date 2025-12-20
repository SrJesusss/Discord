
SMODS.Joker{ --Self Reaction Spoted
    key = "self_reaction_spoted",
    config = {
        extra = {
            odds = 2,
            levels0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Self Reaction Spoted',
        ['text'] = {
            [1] = 'If played {C:attention}poker hand{} is a {C:attention}Pair{}',
            [2] = '{C:green}#1# in #2#{} chance to upgrade',
            [3] = 'level of random {C:attention}poker hand{}',
            [4] = '{s:0.75,C:inactive}(Credits to: Blue){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.51
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_self_reaction_spoted') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if context.scoring_name == "Pair" then
                if SMODS.pseudorandom_probability(card, 'group_0_d78cd5f2', 1, card.ability.extra.odds, 'j_discord_self_reaction_spoted', false) then
                    local available_hands = {}
                    for hand, value in pairs(G.GAME.hands) do
                        if value.visible and value.level >= to_big(1) then
                            table.insert(available_hands, hand)
                        end
                    end
                    local target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand')) or "High Card"
                    level_up_hand(card, target_hand, true, 1)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
                end
            end
        end
    end
}