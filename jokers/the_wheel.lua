
SMODS.Joker{ --The Wheel
    key = "the_wheel",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'The Wheel',
        ['text'] = {
            [1] = 'Creates {C:attention}The Fool{} when a {C:attention}#1#{} of',
            [2] = '{C:clubs}Clubs{} or {C:hearts}Hearts{} is destroyed,',
            [3] = '{s:0.9}rank changes at end of round{}',
            [4] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.6
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
        
        local info_queue_0 = G.P_CENTERS["c_fool"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_fool\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {localize((G.GAME.current_round.rankvar_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.rankvar_card = { rank = 'Ace', id = 14 }
    end,
    
    calculate = function(self, card, context)
        if context.remove_playing_cards  then
            if ((function()
                for k, removed_card in ipairs(context.removed) do
                    if removed_card:get_id() == 14 then
                        return true
                    end
                end
                return false
            end)() and (function()
                for k, removed_card in ipairs(context.removed) do
                    if removed_card:is_suit("Clubs") then
                        return true
                    end
                end
                return false
            end)() or (function()
                for k, removed_card in ipairs(context.removed) do
                    if removed_card:is_suit("Hearts") then
                        return true
                    end
                end
                return false
            end)()) then
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Tarot', key = 'c_fool'})                            
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
                    end
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if G.playing_cards then
                local valid_rankvar_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_rankvar_cards[#valid_rankvar_cards + 1] = v
                    end
                end
                if valid_rankvar_cards[1] then
                    local rankvar_card = pseudorandom_element(valid_rankvar_cards, pseudoseed('rankvar' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.rankvar_card.rank = rankvar_card.base.value
                    G.GAME.current_round.rankvar_card.id = rankvar_card.base.id
                end
            end
        end
    end
}