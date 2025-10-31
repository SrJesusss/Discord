SMODS.Rarity {
    key = "message",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.475,
    badge_colour = HEX('000000'),
    loc_txt = {
        name = "Message"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
