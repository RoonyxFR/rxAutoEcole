ConfigAutoEcole = {}

ConfigAutoEcole = {
    ESX = 'esx:getSharedObject',                                                    -- Définir ESX
    PositionCode = { x = 214.7519, y = -1398.438, z = 30.58354 },                   -- Position du code
    PositionCodePed = { x = 214.0132, y = -1399.648, z = 29.69364, h = 330.0},      -- Position du ped
    PrixCode = 800,                                                                 -- Prix du code
    PrixPermisVoiture = 2500,                                                       -- Prix du permis de voiture
    PrixPermisMoto = 2300,                                                          -- Prix du permis de moto
    PrixPermisCamion = 2800,                                                        -- Prix du permis de camion
    timer = 180,                                                                    -- temps en seconde
    -- Si vous modifiez le timer, veuillez modifier aussi les lignes suivantes :
    -- client/function.lua à la ligne 164
    -- client/menu.lua à la ligne 124
}


ConfigAutoEcole.MaxErrors       = 5
ConfigAutoEcole.SpeedMultiplier = 3.6

ConfigAutoEcole.VehicleModels = {
    drive       = 'sultan',
    drive_bike  = 'bati',
    drive_truck = 'mule3'
}

ConfigAutoEcole.SpeedLimits = {
    residence = 50,
    town      = 80,
    freeway   = 120
}

ConfigAutoEcole.Zones = {

    VehicleSpawnPoint = {
        Pos   = {x = 249.409, y = -1407.230, z = 30.4094, h = 317.0},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

}

ConfigAutoEcole.CheckPoints = {

    {
        Pos = {x = 255.139, y = -1400.731, z = 29.537},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText(("Allez vers le prochain passage! Vitesse limite: ~y~%s~s~ km/h"):format(ConfigAutoEcole.SpeedLimits['residence']), 5000)
        end
    },

    {
        Pos = {x = 271.874, y = -1370.574, z = 30.932},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText("Allez vers le prochain passage!", 5000)
        end
    },

    {
        Pos = {x = 234.907, y = -1345.385, z = 29.542},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            Citizen.CreateThread(function()
                DrawMissionText("Faite rapidement un ~r~stop~s~ pour le piéton qui ~y~traverse", 5000)
                PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
                FreezeEntityPosition(vehicle, true)
                Citizen.Wait(4000)

                FreezeEntityPosition(vehicle, false)
                DrawMissionText("~g~Bien!~s~ continuons!", 5000)
            end)
        end
    },

    {
        Pos = {x = 217.821, y = -1410.520, z = 28.292},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            setCurrentZoneType('town')

            Citizen.CreateThread(function()
                DrawMissionText(("Marquer rapidement un ~r~stop~s~ et regardez à votre ~y~gauche~s~. Vitesse limite: ~y~%s~s~ km/h"):format(ConfigAutoEcole.SpeedLimits['town']), 5000)
                PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
                FreezeEntityPosition(vehicle, true)
                Citizen.Wait(6000)

                FreezeEntityPosition(vehicle, false)
                DrawMissionText("~g~Bien!~s~ prenez à ~y~droite~s~ et suivez votre file", 5000)
            end)
        end
    },

    {
        Pos = {x = 179.1223, y = -1402.097, z = 27.7344},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText("Marquez le stop pour laisser passer les véhicules!", 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(6000)
            FreezeEntityPosition(vehicle, false)
        end
    },

    {
        Pos = {x = 116.9352, y = -1356.415, z = 27.66045},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText("Allez vers le prochain passage!", 5000)
        end
    },

    {
        Pos = {x = 116.9352, y = -1356.415, z = 27.66045},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText("Prenez sur la droite, attention vous allez arrivez sur l'autoroute", 5000)
        end
    },

    {
        Pos = {x = 174.3761, y = -1242.414, z = 36.70127},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            setCurrentZoneType('freeway')

            DrawMissionText(("Il est temps d'aller sur la rocade! Vitesse limite: ~y~%s~s~ km/h"):format(ConfigAutoEcole.SpeedLimits['freeway']), 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
        end
    },

    {
        Pos = {x = 633.1151, y = -1242.858, z = 39.84327},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText("Vous sortez de l'autoroute, réduisez votre vitesse à 80 km/h", 5000)
        end
    },

    {
        Pos = {x = 776.1666, y = -1239.46, z = 26.13107},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            setCurrentZoneType('town')
            DrawMissionText(("Entrée en ville, attention à votre vitesse! Vitesse limite: ~y~%s~s~ km/h"):format(ConfigAutoEcole.SpeedLimits['town']), 5000)
        end
    },

    {
        Pos = {x = 781.301, y = -1026.195, z = 24.605},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Marquez le stop pour laisser passer les véhicules!', 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(6000)
            FreezeEntityPosition(vehicle, false)
            DrawMissionText('Bien, prenez à gauche!', 5000)
        end
    },

    {
        Pos = {x = 413.946, y = -1040.06, z = 27.80036},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Allez vers le prochain passage!', 5000)
        end
    },

    {
        Pos = {x = 408.4836, y = -877.0377, z = 27.7428},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Marquez le stop pour laisser passer les véhicules!', 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(6000)
            FreezeEntityPosition(vehicle, false)
            DrawMissionText('Bien, prenez à gauche!', 5000)
        end
    },

    {
        Pos = {x = 313.4638, y = -855.0764, z = 27.73656},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Marquez le stop pour laisser passer les véhicules!', 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
            FreezeEntityPosition(vehicle, true)
            Citizen.Wait(6000)
            FreezeEntityPosition(vehicle, false)
            DrawMissionText('Bien, continuer tous droit!', 5000)
        end
    },

    {
        Pos = {x = 198.3179, y = -827.3132, z = 29.39257},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Allez vers le prochain passage!', 5000)
        end
    },

    {
        Pos = {x = 81.75273, y = -1336.236, z = 27.73565},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Allez vers le prochain passage!', 5000)
        end
    },

    {
        Pos = {x = 222.5009, y = -1439.918, z = 27.73374},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            DrawMissionText('Allez vers le prochain passage!', 5000)
        end
    },

    {
        Pos = {x = 235.283, y = -1398.329, z = 28.921},
        Action = function(playerPed, vehicle, setCurrentZoneType)
            ESX.Game.DeleteVehicle(vehicle)
        end
    }

}

