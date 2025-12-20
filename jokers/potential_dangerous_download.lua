
SMODS.Joker{ --Potential Dangerous Download
    key = "potential_dangerous_download",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Potential Dangerous Download',
        ['text'] = {
            [1] = 'Creates {C:dark_edition}Negative{} {C:attention}Cryptid{}',
            [2] = 'at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.46
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    dependencies = {"Cryptid"},
    pools = { ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["e_negative"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_negative\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_1 = G.P_CENTERS["c_cryptid"]
        if info_queue_1 then
            info_queue[#info_queue + 1] = info_queue_1
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_cryptid\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                func = function()
                    
                    for i = 1, 1 do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                end
                                
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Spectral', edition = 'e_negative', key = 'c_cryptid'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end
            }
        end
    end
}