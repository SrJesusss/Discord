SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {19,27,25,21,7,35,13,24,15,18,17,10,2,34,33,28,20,32,14,5,6,4,16,3,26,30,1,9,12,37,8,31,29,11,23,36,22}

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #jokerIndexList do
        local file_name = files[jokerIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end

local function load_rarities_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("rarities.lua"))()
end

load_rarities_file()
load_jokers_folder()
SMODS.ObjectType({
    key = "discord_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true,
        ["j_discord_hacked_user"] = true,
        ["j_discord_happy_tomato"] = true,
        ["j_discord_savings"] = true
    },
})

SMODS.ObjectType({
    key = "discord_dm_me",
    cards = {
        ["j_discord_abelsketch"] = true,
        ["j_discord_alt_account"] = true,
        ["j_discord_blue"] = true,
        ["j_discord_bonethy"] = true,
        ["j_discord_cavendish"] = true,
        ["j_discord_cavo"] = true,
        ["j_discord_clown"] = true,
        ["j_discord_comykel"] = true,
        ["j_discord_doggfly"] = true,
        ["j_discord_emoticon"] = true,
        ["j_discord_fercorn"] = true,
        ["j_discord_glitchkat10"] = true,
        ["j_discord_hacked_user"] = true,
        ["j_discord_half_a_dima"] = true,
        ["j_discord_happy_tomato"] = true,
        ["j_discord_kassandra"] = true,
        ["j_discord_lucky_catch"] = true,
        ["j_discord_moderator"] = true,
        ["j_discord_nitro_basic"] = true,
        ["j_discord_potential_dangerous_download"] = true,
        ["j_discord_ragebaiter"] = true,
        ["j_discord_red_theme"] = true,
        ["j_discord_saucequest31"] = true,
        ["j_discord_savings"] = true,
        ["j_discord_self_reaction_spoted"] = true,
        ["j_discord_sillyz_jimbo"] = true,
        ["j_discord_spammer"] = true,
        ["j_discord_spoiler_message"] = true,
        ["j_discord_spooky_razz"] = true,
        ["j_discord_ssarahh"] = true,
        ["j_discord_stefwuzhere"] = true,
        ["j_discord_the_wheel_of_misfortune"] = true,
        ["j_discord_totally_rigged"] = true,
        ["j_discord_underage_user"] = true,
        ["j_discord_very_scary_jumpscare"] = true,
        ["j_discord_waffle"] = true,
        ["j_discord_zombieboy139"] = true
    },
})