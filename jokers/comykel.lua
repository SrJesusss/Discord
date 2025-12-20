
SMODS.Joker{ --Comykel
    key = "comykel",
    config = {
        extra = {
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Comykel',
        ['text'] = {
            [1] = '{C:green}#1# in #2#{} chance to all played {C:attention}Aces{} become',
            [2] = '{C:attention}Sealed{} cards when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.16
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_comykel') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                if SMODS.pseudorandom_probability(card, 'group_0_c0d66ebd', 1, card.ability.extra.odds, 'j_discord_comykel', false) then
                    local scored_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            
                            local random_seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                            if random_seal then
                                scored_card:set_seal(random_seal, true)
                            end
                            card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.ORANGE})
                            return true
                        end
                    }))
                    
                end
            end
        end
    end
}