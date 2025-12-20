
SMODS.Joker{ --Totally Rigged
    key = "totally_rigged",
    config = {
        extra = {
            mod_probability0 = 6,
            blind_size0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Totally Rigged',
        ['text'] = {
            [1] = '{X:attention,C:white}X2{} Blind size, sextuples',
            [2] = 'all {C:attention}listed{} {C:green}probabilities{}',
            [3] = '{C:inactive}(ex:{} {C:green}1 in 7{} {C:inactive}->{} {C:green}6 in 7{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
            numerator = numerator * (6)
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
        if context.setting_blind  and not context.blueprint then
            return {
                
                func = function()
                    if G.GAME.blind.in_blind then
                        
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(2).." Blind Size", colour = G.C.GREEN})
                        G.GAME.blind.chips = G.GAME.blind.chips * 2
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate()
                        return true
                    end
                end
            }
        end
    end
}