
SMODS.Joker{ --Cavo
    key = "cavo",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Cavo',
        ['text'] = {
            [1] = 'destroy {C:attention}first{} and {C:attention}last{}',
            [2] = 'card discarded',
            [3] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.16
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
        if context.discard  and not context.blueprint then
            if (context.other_card == context.full_hand[1] or context.other_card == context.full_hand[#context.full_hand]) then
                return {
                    remove = true,
                    message = "Destroyed!"
                }
            end
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "cavo_bought", colour = G.C.BLUE})
                    G.GAME.pool_flags.discord_cavo_bought = true
                    return true
                end
            }))
        end
    end
}