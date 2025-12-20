
SMODS.Joker{ --Minecraft Player
    key = "minecraft_player",
    config = {
        extra = {
            mult0 = 64
        }
    },
    loc_txt = {
        ['name'] = 'Minecraft Player',
        ['text'] = {
            [1] = '{C:red}+64{} Mult if played hand has',
            [2] = 'exactly {C:attention}4{} scoring cards'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 1
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
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(#context.scoring_hand) == to_big(4) then
                return {
                    mult = 64
                }
            end
        end
    end
}