
SMODS.Joker{ --Ragebaiter
    key = "ragebaiter",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ragebaiter',
        ['text'] = {
            [1] = 'Creates {C:attention}Popcorn{} when {C:attention}0{} hands remaining',
            [2] = '{C:inactive}(Must have room){}'
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
        h = 95 * 0.65
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
        
        local info_queue_0 = G.P_CENTERS["j_popcorn"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_popcorn\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(G.GAME.current_round.hands_left) == to_big(1) then
                local created_joker = false
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    created_joker = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_popcorn' })
                            if joker_card then
                                
                                
                            end
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                end
                return {
                    message = created_joker and localize('k_plus_joker') or nil
                }
            end
        end
    end
}