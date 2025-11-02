SMODS.Joker{ --Emoticon
    key = "emoticon",
    config = {
        extra = {
            source_rank_type = "face_cards",
            target_rank = "A"
        }
    },
    loc_txt = {
        ['name'] = 'Emoticon',
        ['text'] = {
            [1] = '{C:attention}Face{} cards are considered {C:attention}Aces{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Combine ranks effect enabled
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Combine ranks effect disabled
    end
}


local card_get_id_ref = Card.get_id
function Card:get_id()
    local original_id = card_get_id_ref(self)
    if not original_id then return original_id end

    if next(SMODS.find_card("j_discord_emoticon")) then
        if original_id >= 11 and original_id <= 13 then return 14 end
    end
    return original_id
end
