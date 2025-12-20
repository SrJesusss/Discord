
SMODS.Joker{ --Liar
    key = "liar",
    config = {
        extra = {
            levels0 = 1,
            discards0 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Liar',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected, upgrade level of a',
            [2] = 'random {C:attention}poker hand{} and {C:attention}lose all discards{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            local available_hands = {}
            for hand, value in pairs(G.GAME.hands) do
                if value.visible and value.level >= to_big(1) then
                    table.insert(available_hands, hand)
                end
            end
            local target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand')) or "High Card"
            level_up_hand(card, target_hand, true, 1)
            return {
                message = localize('k_level_up_ex'),
                extra = {
                    
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to "..tostring(0).." Discards", colour = G.C.BLUE})
                        G.GAME.current_round.discards_left = 0
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
    end
}