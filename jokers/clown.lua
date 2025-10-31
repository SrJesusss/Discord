SMODS.Joker{ --Clown
    key = "clown",
    config = {
        extra = {
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Clown',
        ['text'] = {
            [1] = 'Each {C:attention}Queen{} held in hand',
            [2] = 'earn {C:money}$5{} and destroy it'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.51
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
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        context.other_card.should_destroy = false
        if context.other_card:get_id() == 12 then
            context.other_card.should_destroy = true
            return {
                dollars = card.ability.extra.dollars,
                extra = {
                message = "Destroyed!",
                colour = G.C.RED
            }
        }
    end
end
end
}