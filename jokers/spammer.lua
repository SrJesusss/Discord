SMODS.Joker{ --Spammer
    key = "spammer",
    config = {
        extra = {
            mult = 4,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Spammer',
        ['text'] = {
            [1] = '{C:red}+4{} Mult, when {C:attention}The Wall{} or {C:attention}Violet Vessel{}',
            [2] = 'is defeated creates {C:dark_edition}Negative{} {C:attention}Joker{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.97
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
        
        local info_queue_0 = G.P_CENTERS["e_negative"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_negative\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_1 = G.P_CENTERS["j_joker"]
        if info_queue_1 then
            info_queue[#info_queue + 1] = info_queue_1
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_joker\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
    if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
        if (G.GAME.blind.config.blind.key == "bl_wall" or G.GAME.blind.config.blind.key == "bl_final_vessel") then
            return {
                func = function()
                    
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_joker' })
                        if joker_card then
                            joker_card:set_edition("e_negative", true)
                            
                        end
                        
                        return true
                        end
                    }))
                    
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                    end
                    return true
                    end
                }
            end
        end
    end
}