
SMODS.Back {
    key = 'blurple_deck',
    pos = { x = 0, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Blurple Deck',
        text = {
            [1] = 'Start run with {C:attention}52{} {C:clubs}Clubs{} in deck'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Spades' then
                        assert(SMODS.change_base(v, 'Clubs'))
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Hearts' then
                        assert(SMODS.change_base(v, 'Clubs'))
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Diamonds' then
                        assert(SMODS.change_base(v, 'Clubs'))
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end
}