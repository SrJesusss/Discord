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

local jokerIndexList = {21,29,27,23,9,38,15,26,17,8,20,19,12,3,37,36,30,22,35,16,6,7,2,5,18,4,28,32,1,11,14,40,10,33,31,13,25,39,34,24}

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
        ["j_discord_chicken_sandwich"] = true,
        ["j_discord_hacked_user"] = true,
        ["j_discord_happy_tomato"] = true,
        ["j_discord_savings"] = true
    },
})

SMODS.ObjectType({
    key = "discord_dm_me",
    cards = {
        ["j_discord_abelsketch"] = true,
        ["j_discord_agente_spia_cavo"] = true,
        ["j_discord_alt_account"] = true,
        ["j_discord_blue"] = true,
        ["j_discord_bonethy"] = true,
        ["j_discord_cavendish"] = true,
        ["j_discord_cavo"] = true,
        ["j_discord_chicken_sandwich"] = true,
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
        ["j_discord_spookyrazz"] = true,
        ["j_discord_ssarahh"] = true,
        ["j_discord_stefwuzhere"] = true,
        ["j_discord_superbread"] = true,
        ["j_discord_the_wheel_of_misfortune"] = true,
        ["j_discord_totally_rigged"] = true,
        ["j_discord_underage_user"] = true,
        ["j_discord_very_scary_jumpscare"] = true,
        ["j_discord_waffle"] = true,
        ["j_discord_zombieboy139"] = true
    },
})
