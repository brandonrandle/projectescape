-- Name: Project ESCAPE Mission 1 - Rescue JJ
-- Description:
-- Type: Mission

-- Scenario
-- @script scenario_71_rescueJJ

-- ##########################################################################
-- ## GM MENU ##
-- ##########################################################################
function gmMainMenu()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Mission Commands +"),gmMissionCommands)
    addGMFunction(_("buttonGM", "Enemy Commands +"),gmEnemyCommands)
    addGMFunction(_("buttonGM", "Modify Trainee Ship +"),gmModifyShip)
    addGMFunction(_("buttonGM", "End Scenario +"),gmEndScenario)
end

--- Provides commands specific to the scenario for GM use
-- TODO: remove options from this menu after they're used
function gmMissionCommands()
    clearGMFunctions() -- Clear the menu
    addGMFunction(_("buttonGM", "Mission Commands -"),gmMainMenu)
    addGMFunction(_("buttonGM", "1) Destroy JJ's Ship"),gmMission1)
    addGMFunction(_("buttonGM", "2) We're Good"),gmMission2)
    addGMFunction(_("buttonGM", "3) Air Running Out"),gmMission3)
    addGMFunction(_("buttonGM", "4) Suffocating"),gmMission4)
    addGMFunction(_("buttonGM", "5) JJ Dead, Extract"),gmMission5)
    addGMFunction(_("buttonGM", "6) JJ Alive, Extract"),gmMission6)
end

-- function gmEnemyCommands()
--     clearGMFunctions() -- Clear the menu
--     addGMFunction(_("buttonGM", "Enemy Commands -"),gmMainMenu)
--     addGMFunction(_("buttonGM", "Spawn Tier 1 Enemies"),gmSpawnT1)
--     addGMFunction(_("buttonGM", "Spawn Tier 2 Enemies"),gmSpawnT2)
--     addGMFunction(_("buttonGM", "Spawn Tier 3 Enemies"),gmSpawnT3)
--     addGMFunction(_("buttonGM", "Spawn Overwhelming Enemies"),gmSpawnAll)
--     addGMFunction(_("buttonGM", "Remove All Enemies"),gmRemoveAll)
-- end

-- function gmModifyShip()
--     clearGMFunctions() -- Clear the menu
--     addGMFunction(_("buttonGM", "Modify Trainee Ship -"),gmMainMenu)
--     addGMFunction(_("buttonGM", "Reset Hull"),gmResetHull)
--     addGMFunction(_("buttonGM", "Reset Energy"),gmResetEnergy)
--     addGMFunction(_("buttonGM", "Reset Weapon Supply"),gmResetWeapons)
--     addGMFunction(_("buttonGM", "Reset Probe Supply"),gmResetProbes)
-- end

-- function gmEndScenario()
--     clearGMFunctions() -- Clear the menu
--     addGMFunction(_("buttonGM", "End Scenario -"),gmMainMenu)
--     addGMFunction(_("buttonGM", "Victory"),gmVictory)
--     addGMFunction(_("buttonGM", "Defeat"),gmDefeat)
-- end

-- ##########################################################################
-- ## GM Mission Commands ##
-- ##########################################################################
--- 1) Destroy JJ's Ship
--
-- Do this when trainees get nearby or sit around waiting too long
function gmMission1()
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
function gmMission2()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

end

-- 3) Air Running out
-- ~1 minute later; a leak has sprung
function gmMission3()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

end

-- 4) Suffocating
-- After 1-3 minutes to heighten stress, they'll die soon
function gmMission4()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

end

-- 5) JJ Dead, Extract
-- After 5-6 minutes. Let them fly back to base if there's time, then end scenario
function gmMission5()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

end

    -- lifepod = lifepod + delta
    -- if not lifepod:isValid() then
    --     -- Escape pod picked up, stop the lifepod
    --     if lifepod > 60 * 5 then
    --         -- If he spends more than 5 minutes in the escape pod, the diplomat died.
    --         jjj_alive = false
    --         mission_state = missionRT4Died
    --         central_command:sendCommsMessage(
    --             trainee,
    --             _("incCall", [[J.J. Johnson seems to have suffocated. This is a great loss for our cause of peace.

-- Please deliver his body back to Research-1. We will arrange for you to take over his mission.]])
    --         )
    --     else

-- 6) JJ Alive, Extract
function gmMission6()
    -- Clear and reset the menu
    clearGMFunctions()
    gmMainMenu()

end
    --         -- Diplomat lives, drop him off at Orion-5.
    --         jjj_alive = true
    --         mission_state = missionRT4PickedUp
    --         central_command:sendCommsMessage(
    --             trainee,
    --             _("incCall", [[Just received message that Sir Johnson is safely aboard your ship! Great job!

-- Please deliver the diplomat to Orion-5 in sector G3. Do this by docking with the station.]])
    --         )

-- ##########################################################################
-- ## GM Enemy Commands ##
-- ##########################################################################

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

    -- Create the main ship for the trainees.
    trainee = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis")
    trainee:setPosition(22400, 18200):setCallSign("J.E. Thompson")
    allowNewPlayerShips(false)

    -- Create all the stations
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
