
SMODS.Joker{ --Spoiler Message
    key = "spoiler_message",
    config = {
        extra = {
            rounds = 0
        }
    },
    loc_txt = {
        ['name'] = 'Spoiler Message',
        ['text'] = {
            [1] = 'After {C:attention}2{} rounds, destroy',
            [2] = 'the Joker to the {C:attention}Left{} and',
            [3] = '{C:attention}Duplicate{} the Joker to the {C:attention}Right{}',
            [4] = '{C:inactive}(Removes{} {C:dark_edition}Edition{} {C:inactive}and{} {C:attention}Sticker{} {C:inactive}from copy){}',
            [5] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/2){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.17
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.rounds}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.rounds or 0)) < to_big(1) then
                return {
                    func = function()
                        card.ability.extra.rounds = (card.ability.extra.rounds) + 1
                        return true
                    end
                }
            elseif to_big((card.ability.extra.rounds or 0)) >= to_big(1) then
                return {
                    func = function()
                        card.ability.extra.rounds = 1
                        return true
                    end,
                    message = "Reset",
                    extra = {
                        func = function()
                            local my_pos = nil
                            for i = 1, #G.jokers.cards do
                                if G.jokers.cards[i] == card then
                                    my_pos = i
                                    break
                                end
                            end
                            local target_joker = nil
                            if my_pos and my_pos > 1 then
                                local joker = G.jokers.cards[my_pos - 1]
                                if not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                    target_joker = joker
                                end
                            end
                            
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
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local my_pos = nil
                                for i = 1, #G.jokers.cards do
                                    if G.jokers.cards[i] == card then
                                        my_pos = i
                                        break
                                    end
                                end
                                local target_joker = (my_pos and my_pos < #G.jokers.cards) and G.jokers.cards[my_pos + 1] or nil
                                
                                if target_joker then
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                                            
                                            copied_joker:add_to_deck()
                                            G.jokers:emplace(copied_joker)
                                            G.GAME.joker_buffer = 0
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                                end
                                return true
                            end,
                            colour = G.C.GREEN
                        }
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            if to_big(G.GAME.blind.name) == to_big("The Plant") then
                return {
                    message = "Spoiler message revealed!",
                    extra = {
                        func = function()
                            if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.GAME.blind:disable()
                                        play_sound('timpani')
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Fuck You The Plant", colour = G.C.GREEN})
                            end
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
    end
}