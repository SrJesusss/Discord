SMODS.Rarity {
    key = "message",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.475,
    badge_colour = HEX('141e28'),
    loc_txt = {
        name = "Message"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}