
SMODS.Joker{ --Roleplayer
    key = "roleplayer",
    config = {
        extra = {
            xmultvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Roleplayer',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.1{} Mult per scoring',
            [2] = '{C:attention}Enhanced{} or {C:attention}Sealed face card{} played',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.24
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_dm_me"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmultvar}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (context.other_card:is_face() and (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then
                        return true
                    end
                end
                return false
            end)() or context.other_card.seal ~= nil) then
                card.ability.extra.xmultvar = (card.ability.extra.xmultvar) + 0.1
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmultvar
            }
        end
    end
}