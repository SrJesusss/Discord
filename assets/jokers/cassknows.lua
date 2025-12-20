
SMODS.Joker{ --Cassknows
    key = "cassknows",
    config = {
        extra = {
            glopvar = 0.1
        }
    },
    loc_txt = {
        ['name'] = 'Cassknows',
        ['text'] = {
            [1] = 'This Joker gains {C:glop}+0.1{} Glop',
            [2] = 'at end of round',
            [3] = '{C:inactive}(Currently{} {C:glop}+#1#{} {C:inactive}Glop){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 4
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.49
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    dependencies = {"potassium_re"},
    pools = { ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.glopvar}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                glop = card.ability.extra.glopvar
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.glopvar = (card.ability.extra.glopvar) + 0.1
                    return true
                end
            }
        end
    end
}