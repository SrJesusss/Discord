
SMODS.Joker{ --Fully Grown User
    key = "fully_grown_user",
    config = {
        extra = {
            chipsvar = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fully Grown User',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+18{} Chips when each',
            [2] = 'played {C:attention}face{} card is scored',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.2
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    dependencies = {"romlatro"},
    pools = { ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chipsvar}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.chipsvar = (card.ability.extra.chipsvar) + 18
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chipsvar
            }
        end
    end
}