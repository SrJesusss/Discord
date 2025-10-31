SMODS.Joker{ --StefWuzHere
    key = "stefwuzhere",
    config = {
        extra = {
            chips = 1,
            mult = 1
        }
    },
    loc_txt = {
        ['name'] = 'StefWuzHere',
        ['text'] = {
            [1] = 'When a card is played and scores',
            [2] = 'give {C:blue}+1{} Chips and {C:red}+1{} Mult'
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
        h = 95 * 0.2
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
            return {
                chips = card.ability.extra.chips,
                extra = {
                mult = card.ability.extra.mult
            }
        }
    end
end
}