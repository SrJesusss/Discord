SMODS.Joker{ --Potential Dangerous Download
    key = "potential_dangerous_download",
    config = {
        extra = {
            respect = 0,
            potential_dangerous_download_bought = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Potential Dangerous Download',
        ['text'] = {
            [1] = 'When a {C:attention}Boss Blind{} is defeated',
            [2] = 'creates {C:attention}Gros Michel{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
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
    pools = { ["discord_dm_me"] = true },

    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["j_gros_michel"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_gros_michel\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            func = function()
                
                local created_joker = false
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    created_joker = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_gros_michel' })
                        if joker_card then
                            
                            
                        end
                        G.GAME.joker_buffer = 0
                        return true
                        end
                    }))
                end
                if created_joker then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                end
                return true
                end
            }
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  and not context.blueprint then
            G.GAME.pool_flags.discord_potential_dangerous_download_bought = true
        end
    end
}