
SMODS.Joker{ --Zombieboy139
    key = "zombieboy139",
    config = {
        extra = {
            xmultvar = 0,
            xmult0 = 0.5,
            xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Zombieboy139',
        ['text'] = {
            [1] = 'Gives either {X:red,C:white}X0.5{} Mult or {X:red,C:white}X2{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 3
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.17
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
        
        return {vars = {card.ability.extra.xmultvar}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.xmultvar = pseudorandom('RANGE:1|2', 1, 2)
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big((card.ability.extra.xmultvar or 0)) == to_big(1) then
                return {
                    Xmult = 0.5
                }
            elseif to_big((card.ability.extra.xmultvar or 0)) == to_big(2) then
                return {
                    Xmult = 2
                }
            end
        end
    end
}