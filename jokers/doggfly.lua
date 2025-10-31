SMODS.Joker{ --Dogg.fly
    key = "doggfly",
    config = {
        extra = {
            levels = 1
        }
    },
    loc_txt = {
        ['name'] = 'Dogg.fly',
        ['text'] = {
            [1] = 'Level up a random {C:attention}poker hand{} if the currently',
            [2] = 'played {C:attention}poker hand{} is a {C:attention}#1#{} of only {C:spades}Spades{},',
            [3] = '{s:0.9}poker hand and changes at end of round{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.25
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
        
        return {vars = {localize((G.GAME.current_round.handvar_hand or 'High Card'), 'poker_hands')}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.handvar_hand = 'Flush'
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (context.scoring_name == G.GAME.current_round.handvar_hand and (function()
                local allMatchSuit = true
                for i, c in ipairs(context.scoring_hand) do
                    if not (c:is_suit("Spades")) then
                        allMatchSuit = false
                        break
                    end
                end
                
                return allMatchSuit and #context.scoring_hand > 0
                end)()) then
                    local available_hands = {}
                    for hand, value in pairs(G.GAME.hands) do
                        if value.visible and value.level >= to_big(1) then
                            table.insert(available_hands, hand)
                        end
                    end
                    local target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand')) or "High Card"
                    return {
                        level_up = card.ability.extra.levels,
                        level_up_hand = target_hand,
                        message = localize('k_level_up_ex')
                    }
                end
            end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            local handvar_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if G.GAME.hands[handname].visible then
                    handvar_hands[#handvar_hands + 1] = handname
                end
            end
            if handvar_hands[1] then
                G.GAME.current_round.handvar_hand = pseudorandom_element(handvar_hands, pseudoseed('handvar' .. G.GAME.round_resets.ante))
            end
        end
    end
}