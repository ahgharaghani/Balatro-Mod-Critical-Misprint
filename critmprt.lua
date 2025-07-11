SMODS.Atlas {
    key = "crit_misprt",
    px = 255,
    py = 369,
    path = "criticalmisprint.png"
}

SMODS.Joker {
    key = "Critical Misprint",
    atlas = "crit_misprt",
    config = {
        extra = {
            mult = 0 -- initial value
        }
    },
    unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
	    -- calculation code goes in here
    end,
}