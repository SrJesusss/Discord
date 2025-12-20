
SMODS.Joker{ --AutoMod
    key = "automod",
    config = {
        extra = {
            levels0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'AutoMod',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected, if',
            [2] = 'theres {C:attention}5{} or more {C:attention}Jokers{}',
            [3] = '{C:attention}destroy{} a random Joker',
            [4] = 'and upgrade level of your',
            [5] = 'most played {C:attention}poker hand{}'
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
        h = 95 * 0.77
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
            if to_big(#G.jokers.cards) >= to_big(5) then
                local temp_played = 0
                local temp_order = math.huge
                local target_hand
                for hand, value in pairs(G.GAME.hands) do 
                    if value.played > temp_played and value.visible then
                        temp_played = value.played
                        temp_order = value.order
                        target_hand = hand
                    elseif value.played == temp_played and value.visible then
                        if value.order < temp_order then
                            temp_order = value.order
                            target_hand = hand
                        end
                    end
                end
                
                level_up_hand(card, target_hand, true, 1)
                return {
                    func = function()
                        local destructable_jokers = {}
                        for i, joker in ipairs(G.jokers.cards) do
                            if joker ~= card and not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                table.insert(destructable_jokers, joker)
                            end
                        end
                        local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end,
                    extra = {
                        message = localize('k_level_up_ex'),
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}