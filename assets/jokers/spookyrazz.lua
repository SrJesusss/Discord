
SMODS.Joker{ --Spooky Razz
    key = "spookyrazz",
    config = {
        extra = {
            mult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Spooky Razz',
        ['text'] = {
            [1] = 'Played cards with {C:diamonds}Diamond{}, {C:hearts}Heart{}, {C:clubs}Club{} or',
            [2] = '{C:spades}Spade{} suit give {C:red}+3{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Hearts") or context.other_card:is_suit("Clubs") or context.other_card:is_suit("Spades")) then
                return {
                    mult = 3
                }
            end
        end
    end
}