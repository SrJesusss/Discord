
SMODS.Joker{ --Agente Spia: Cavo
    key = "agente_spia_cavo",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Agente Spia: Cavo',
        ['text'] = {
            [1] = 'destroy {C:attention}first{} and {C:attention}last{}',
            [2] = 'played card when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and G.GAME.pool_flags.discord_cavo_bought
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if (context.other_card == context.scoring_hand[1] and context.other_card == context.scoring_hand[#context.scoring_hand]) then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
    end
}