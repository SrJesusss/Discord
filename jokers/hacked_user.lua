SMODS.Joker{ --Hacked user
    key = "hacked_user",
    config = {
        extra = {
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hacked user',
        ['text'] = {
            [1] = 'When {C:attention}Boss Blind{} is defeated',
            [2] = 'creates {C:attention}Cavendish{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.37
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_food"] = true, ["discord_dm_me"] = true },
    in_pool = function(self, args)
          return (
          not args 
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and G.GAME.pool_flags.discord_potential_dangerous_download_bought
      end,

    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["j_cavendish"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_cavendish\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
        return {
            func = function()
                
                local created_joker = false
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    created_joker = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_cavendish' })
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
end
}