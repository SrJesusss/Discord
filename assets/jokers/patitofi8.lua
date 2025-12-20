
SMODS.Joker{ --Jesus
    key = "patitofi8",
    config = {
        extra = {
            xmult0 = 8
        }
    },
    loc_txt = {
        ['name'] = 'Jesus',
        ['text'] = {
            [1] = '{X:red,C:white}X8{} Mult if played poker hand is a',
            [2] = '{C:attention}Flush{} of {C:diamonds}Diamonds{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 4
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.21
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
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (context.scoring_name == "Flush" and (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Diamonds") then
                        count = count + 1
                    end
                end
                return count == #context.scoring_hand
            end)()) then
                return {
                    Xmult = 8
                }
            end
        end
    end
}