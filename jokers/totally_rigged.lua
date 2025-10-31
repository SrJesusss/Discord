SMODS.Joker{ --Totally Rigged
    key = "totally_rigged",
    config = {
        extra = {
            mod_probability = 6,
            blind_size = 2,
            numerator = 0
        }
    },
    loc_txt = {
        ['name'] = 'Totally Rigged',
        ['text'] = {
            [1] = '{X:attention,C:white}X2{} Blind size and',
            [2] = 'sextuple all {C:attention}listed{} {C:green}probabilities{}',
            [3] = '{C:inactive}(ex:{} {C:green}1 in 7{} {C:inactive}->{} {C:green}6 in 7{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.17
    },
    cost = 5,
    rarity = "discord_message",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["discord_dm_me"] = true },

    
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            local numerator, denominator = context.numerator, context.denominator
            numerator = numerator * (card.ability.extra.mod_probability)
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(card.ability.extra.blind_size).." Blind Size", colour = G.C.GREEN})
                    G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate()
                        return true
                        end
                    }
                end
            end
}