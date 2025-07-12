local function weightenedRandom(nmin, nmax, pmin, pmax)
    local r = math.random()
    --higher chance of 0.9 to gain a negative mult (between nmin to nmax)
    if r <= 0.9 then
        return math.random(nmin, nmax)
    --lesser chance of 0.1 to gain a positive high mult (between pmin to pmax)
    else
        return math.random(pmin, pmax)
    end
end

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
            pmax = 35,
            pmin = 30,
            nmax = -5,
            nmin = 0,
            intmult = 0 --initial value and the internal var used for local usage(to avoid interferance with mult var used globally by the framework)
        }
    },
    unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local r_mults ={}
        for i = card.ability.extra.nmax, card.ability.extra.nmin do
            r_mults[#r_mults + 1] = tostring(i)
        end
        for i = card.ability.extra.pmin, card.ability.extra.pmax do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        main_start = {
            { n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
  
    -- This event is useless right now and will remain in the source code for debugging reasons.
    local event
    event = Event {
        trigger = "after",
        blocking = false,
        blockable = false,
        pause_force = true,
        no_delete = true,
        timer = "UPTIME",
        delay = 0.5,
        func = function ()
            card.ability.extra.intmult = weightenedRandom(card.ability.extra.nmin, card.ability.extra.nmax, card.ability.extra.pmin, card.ability.extra.pmax)
            event.start_timer = false
            print(card.ability.extra.intmult)
        end
    }
    G.E_MANAGER:add_event(event)
    print(card.ability.extra.intmult)
        if context.joker_main then
            return {
                mult =  weightenedRandom(card.ability.extra.nmin, card.ability.extra.nmax, card.ability.extra.pmin, card.ability.extra.pmax)
            }
        end
    end,
}