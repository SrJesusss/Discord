
SMODS.Joker{ --Blue
    key = "blue",
    config = {
        extra = {
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Blue',
        ['text'] = {
            [1] = 'Played card {C:clubs}Club{} suit give',
            [2] = '{X:red,C:white}X1.5{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.28
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
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                return {
                    Xmult = 1.5
                }
            end
        end
    end
}