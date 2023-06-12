-- Name: Project ESCAPE
-- Description:
-- Type: Mission

-- Scenario
-- @script scenario_71_projectESCAPE

-- TODO: Update staff handbook with functionality in this script
-- TODO: Update staff handbook mission assignment text to match this

-- ##########################################################################
-- ## GM MENU ##
-- ##########################################################################
function gmMainMenu()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Rescue JJ +"),gmRescueJJ)
    addGMFunction(_("buttonGM", "Waves +"),gmWaves)
    addGMFunction(_("buttonGM", "Retrieve Data +"),gmRetrieveData)
    addGMFunction(_("buttonGM", "Enemy Commands +"),gmEnemyCommands)
    addGMFunction(_("buttonGM", "Modify Trainee Ship +"),gmModifyShip)
    addGMFunction(_("buttonGM", "End Scenario +"),gmEndScenario)
end

--- Rescue JJ GM Commands
-- TODO: remove options from this menu after they're used
function gmRescueJJ()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Rescue JJ -"),gmMainMenu)
    addGMFunction(_("buttonGM", "1) Destroy JJ's Ship"),gmRescueJJ1)
    addGMFunction(_("buttonGM", "2) We're Good"),gmRescueJJ2)
    addGMFunction(_("buttonGM", "3) Air Running Out"),gmRescueJJ3)
    addGMFunction(_("buttonGM", "4) Suffocating"),gmRescueJJ4)
    addGMFunction(_("buttonGM", "5) JJ Dead, Extract"),gmRescueJJ5)
    addGMFunction(_("buttonGM", "5) JJ Alive, Extract"),gmRescueJJ6)
    addGMFunction(_("buttonGM", "Set Mission"),gmSetRescueJJ)
    addGMFunction(_("buttonGM", "Clear Mission"),gmClearRescueJJ)
end

--- Waves GM Commands
-- TODO: remove options from this menu after they're used
function gmWaves()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Waves -"),gmMainMenu)
    addGMFunction(_("buttonGM", "Set Mission"),gmSetWaves)
    addGMFunction(_("buttonGM", "Clear Mission"),gmClearWaves)
    -- TODO: add steps for mission
end

--- Retrieve Data GM Commands
-- TODO: remove options from this menu after they're used
function gmRetrieveData()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Retrieve Data -"),gmMainMenu)
    addGMFunction(_("buttonGM", "Set Mission"),gmSetRetrieveData)
    addGMFunction(_("buttonGM", "Clear Mission"),gmClearRetrieveData)
    -- TODO: add steps for mission
end

--- Provides commands for spawning and removing enemies as-needed in any scenario
function gmEnemyCommands()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Enemy Commands -"),gmMainMenu)
    addGMFunction(_("buttonGM", "Spawn Tier 1 Enemies"),gmSpawnT1)
    addGMFunction(_("buttonGM", "Spawn Tier 2 Enemies"),gmSpawnT2)
    addGMFunction(_("buttonGM", "Spawn Tier 3 Enemies"),gmSpawnT3)
    addGMFunction(_("buttonGM", "Spawn Overwhelming Enemies"),gmSpawnAll)
    addGMFunction(_("buttonGM", "Remove All Enemies"),gmRemoveAll)
end

-- function gmModifyShip()
--     clearGMFunctions() -- Clear the menu
--     addGMFunction(_("buttonGM", "Modify Trainee Ship -"),gmMainMenu)
--     addGMFunction(_("buttonGM", "Reset Hull"),gmResetHull)
--     addGMFunction(_("buttonGM", "Reset Energy"),gmResetEnergy)
--     addGMFunction(_("buttonGM", "Fill Weapon Supply"),gmResetWeapons)
--     addGMFunction(_("buttonGM", "Reset Probe Supply"),gmResetProbes)
--     -- TODO: Remove weapons button
-- end

-- function gmEndScenario()
--     clearGMFunctions() -- Clear the menu
--     addGMFunction(_("buttonGM", "End Scenario -"),gmMainMenu)
--     addGMFunction(_("buttonGM", "Victory"),gmVictory)
--     addGMFunction(_("buttonGM", "Defeat"),gmDefeat)
--     -- TODO: Setup victory/defeat message in a way that DOES NOT end scenario
-- end

-- ##########################################################################
-- ## GM RescueJJ Commands ##
-- ##########################################################################
--- 1) Destroy JJ's Ship
--
-- Do this when trainees get nearby or sit around waiting too long
function gmRescueJJ1()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    -- Destroy JJ Johnson's ship and activate the enemies on-site
    jj_transport:destroy()
    exuari_guard1:orderRoaming()
    exuari_guard2:orderRoaming()

    -- Spawn the life pod
    lifepod = SupplyDrop()
    lifepod:setFaction("Human Navy")
    lifepod:setPosition(3750, 31250)
    lifepod:setDescriptions(
        _("scienceDescription-lifepod", "Life Pod"),
        _("scienceDescription-lifepod", "JJ Johnson and his crew in Life Pod")
    )
    lifepod:setScanningParameters(1,1)

    -- Notify the trainees
    central_command:sendCommsMessage(trainee,
        _("incCall", "JJ Johnson's ship has been attacked and destroyed, but "
        .. "not before it launched an escape pod. \n Life signs are detected "
        .. "in the pod. Please retrieve the pod to see if JJ Johnson "
        .. "survived. His death would be a great blow to the region's peace "
        .. "negotiations.")
    )
end
-- 2) We're Good
-- Do this shortly after the capsule ejects
function gmRescueJJ2()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    jj_transport:sendCommsMessage(trainee,
        _("incCall", "Greetings crew of the J.E. Thompson, this is JJ Johnson. "
        .. "Thank you for responding to our signal. My crew and I managed to launch "
        .. "in an escape pod before our ship was destroyed - we should be able to "
        .. "hold out until you can pick us up. We will stand by until then!")
    )

end

-- 3) Air Running out
-- ~1 minute later; a leak has sprung
function gmRescueJJ3()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    jj_transport:sendCommsMessage(trainee,
        _("incCall", "J.E. Thompson, come in! My crew has discovered that we "
        .. "took some damage during the launch; we are losing air rapidly and have "
        .. "no way to replenish it. I'm not sure how long we have, but please "
        .. "hurry!")
    )

end

-- 4) Suffocating
-- After 1-3 minutes to heighten stress, they'll die soon
function gmRescueJJ4()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    jj_transport:sendCommsMessage(trainee,
        _("incCall", "J.E. Thompson, mayday, mayday, our crew is starting to "
        .. "faint from the lack of air; we need you ASAP!")
    )

end

-- 5) JJ Dead, Extract
-- After 5-6 minutes. Let them fly back to base if there's time, then end scenario
function gmRescueJJ5()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    central_command:sendCommsMessage(trainee,
        _("incCall", "J.E. Thompson, this is Central Command. We've lost JJ "
        .. "Johnson and his crew. This is a great tragedy not only for their "
        .. "families and friends but also for our nation's peace as a whole. Return "
        .. "to command for debriefing.")
    )

end

-- 6) JJ Alive, Extract
function gmRescueJJ6()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

    central_command:sendCommsMessage(trainee,
        _("incCall", "J.E. Thompson, this is Central Command. Great work "
        .. "retrieving JJ Johnson safely! Return him to command and report for your "
        .. "debriefing.")
    )

end

function gmSetRescueJJ()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Setup comms log

    -- Create the main ship for the trainees.
    trainee = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis")
    trainee:setPosition(22400, 18200):setCallSign("J.E. Thompson")

    trainee:addToShipLog("mission text", "white")

    -- Create JJ Johnson's ship
    -- We create a ship rather than go straight to just having an escape pod so
    -- if the trainees probe the area they can see his ship.
    jj_transport = CpuShip()
    jj_transport:setTemplate("Flavia")
    jj_transport:setFaction("Human Navy")
    jj_transport:setPosition(3750, 31250)
    jj_transport:setCallSign("RT-4")
    jj_transport:setCommsScript("")
    jj_transport:setHull(1):setShieldsMax(1, 1)

    -- Small Exuari strike team, guarding RT-4 in the nebula at G5.
    exuari_guard1 = CpuShip()
    exuari_guard1:setTemplate("Adder MK5")
    exuari_guard1:setFaction("Exuari")
    exuari_guard1:setPosition(3550, 31250)
    exuari_guard1:setRotation(0)

    exuari_guard2 = CpuShip()
    exuari_guard2:setTemplate("Adder MK5")
    exuari_guard2:setFaction("Exuari")
    exuari_guard2:setPosition(3950, 31250)
    exuari_guard2:setRotation(180)

    -- Set orders
    jj_transport:orderIdle()
    exuari_RT4_guard1:orderIdle()
    exuari_RT4_guard2:orderIdle()
end

function gmClearRescueJJ()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Reset player ship
    -- TODO: Clear JJ, pod, enemy ships, etc.
    -- TODO: Clear comms log
end

-- ##########################################################################
-- ## Waves ##
-- ##########################################################################

function gmSetWaves()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Spawn ships to defend
    -- TODO: Setup comms log
end

function gmClearWaves()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Reset player ship
    -- TODO: Clear ships to defend, enemies, etc.
    -- TODO: Clear comms log
end

-- ##########################################################################
-- ## Retrieve Data ##
-- ##########################################################################

function gmSetRetrieveData()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Spawn satellite station
    -- TODO: Setup comms log
end

function gmClearRetrieveData()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
    -- TODO: Reset player ship
    -- TODO: Clear satellite station, enemies, etc.
    -- TODO: Clear comms log
end

-- ##########################################################################
-- ## GM Enemy Commands ##
-- ##########################################################################

--- Spawns easy difficulty enemies at random edge of trainee ship's radar
function gmSpawnT1()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
end

--- Spawns medium difficulty enemies at random edge of trainee ship's radar
function gmSpawnT2()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
end

--- Spawns hard difficulty enemies at random edge of trainee ship's radar
function gmSpawnT3()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
end

--- Spawns an obscene number of enemies all around trainee ship
function gmSpawnAll()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
end

--- Removes all enemies from the map
function gmRemoveAll()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()
end

-- ##########################################################################
-- ## GM Modify Trainee Ship ##
-- ##########################################################################

-- ##########################################################################
-- ## GM End Scenario ##
-- ##########################################################################

--- Runs when the scenario starts
-- Sets up initial game state, creating ships, stations, environment, etc.
function init()
    -- Setup GM menu
    gmMainMenu()

    -- Create the command station
    central_command = SpaceStation():setTemplate("Small Station"):setFaction("Human Navy")
    central_command:setPosition(23500, 16100):setCallSign("Central Command")

    -- Nebula that hide the enemy station.
    Nebula():setPosition(-43300, 2200)
    Nebula():setPosition(-34000, -700)
    Nebula():setPosition(-32000, -10000)
    Nebula():setPosition(-24000, -14300)
    Nebula():setPosition(-28600, -21900)

    -- Random nebulae in the system
    Nebula():setPosition(-8000, -38300)
    Nebula():setPosition(24000, -30700)
    Nebula():setPosition(42300, 3100)
    Nebula():setPosition(49200, 10700)
    Nebula():setPosition(3750, 31250)
    Nebula():setPosition(-39500, 18700)

    -- Create 50 Asteroids
    placeRandom(Asteroid, 50, -7500, -10000, -12500, 30000, 2000)
    placeRandom(VisualAsteroid, 50, -7500, -10000, -12500, 30000, 2000)

end


--- Runs during game loop
-- Victory conditions handled manually by GM, so nothing monitored here so far.
-- TODO: Can we setup a timer that shows to the GM elapsed time?
function update(delta)
    -- Intentionally blank
end

--- Return the distance between two objects.
function distance(obj1, obj2)
    local x1, y1 = obj1:getPosition()
    local x2, y2 = obj2:getPosition()
    local xd, yd = (x1 - x2), (y1 - y2)
    return math.sqrt(xd * xd + yd * yd)
end

--- Place objects randomly in a rough line
-- Distribute a `number` of random `object_type` objects in a line from point
-- x1,y1 to x2,y2, with a random distance up to `random_amount` between them.
function placeRandom(object_type, number, x1, y1, x2, y2, random_amount)
    for n = 1, number do
        local f = random(0, 1)
        local x = x1 + (x2 - x1) * f
        local y = y1 + (y2 - y1) * f

        local r = random(0, 360)
        local distance = random(0, random_amount)
        x = x + math.cos(r / 180 * math.pi) * distance
        y = y + math.sin(r / 180 * math.pi) * distance

        object_type():setPosition(x, y)
    end
end

-- vim:foldmethod=manual
