SMODS.Joker{ --Alt Account
    key = "alt_account",
    config = {
        extra = {
            perishable = 0,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Alt Account',
        ['text'] = {
            [1] = 'When {C:attention}Boss Blind{} is defeated',
            [2] = 'creates a {C:dark_edition}Negative{} {C:blue}Perishable{}',
            [3] = 'copy of the {C:attention}Joker{} to the right'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.29
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
        return {vars = {}}
    end,

    
    calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint then
        return {
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
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                        copied_joker:set_edition("e_negative", true)
                        copied_joker:add_sticker('perishable', true)
                        copied_joker:add_to_deck()
                        G.jokers:emplace(copied_joker)
                        return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                return true
                end
            }
        end
    end
}