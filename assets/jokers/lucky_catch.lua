
SMODS.Joker{ --Lucky Catch
    key = "lucky_catch",
    config = {
        extra = {
            odds = 5
        }
    },
    loc_txt = {
        ['name'] = 'Lucky Catch',
        ['text'] = {
            [1] = '{C:green}#1# in #2#{} chance to add one',
            [2] = '{C:attention}Lucky{} card to the deck',
            [3] = 'every time a {C:attention}Lucky{} card',
            [4] = '{C:green}successfully{} triggers'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 0.95, 
        h = 95 * 0.5
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
        
        local info_queue_0 = G.P_CENTERS["m_lucky"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_lucky\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_discord_lucky_catch') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card.lucky_trigger then
                if SMODS.pseudorandom_probability(card, 'group_0_2ac42deb', 1, card.ability.extra.odds, 'j_discord_lucky_catch', false) then
                    local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                    local base_card = create_playing_card({
                        front = card_front,
                        center = G.P_CENTERS.m_lucky
                    }, G.discard, true, false, nil, true)
                    
                    
                    
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local new_card = copy_card(base_card, nil, nil, G.playing_card)
                    
                    new_card:add_to_deck()
                    
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(new_card)
                    table.insert(G.playing_cards, new_card)
                    
                    base_card:remove()
                    
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            new_card:start_materialize()
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Added Card!", colour = G.C.GREEN})
                end
            end
        end
    end
}