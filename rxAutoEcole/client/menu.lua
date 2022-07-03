code_menu = false
local menu_code = RageUI.CreateMenu("rxAutoEcole", "Options disponibles :")
menu_code.Closed = function()
    code_menu = false
    FreezeEntityPosition(PlayerPedId(), false)
end

function PermisCodeMenu()
    if code_menu then
        code_menu = false
        RageUI.Visible(menu_code, false)
        return
    else
        code_menu = true
        checkLicence()
        menu_code.Controls.Back.Enabled = true
        RageUI.Visible(menu_code, true)

        CreateThread(function()
            while code_menu do
                Wait(1)

                RageUI.IsVisible(menu_code, function()

                    RageUI.Separator("~b~↓↓~w~  Auto-école  ~b~↓↓~w~")
                    RageUI.Line()

                    if not code then
                        RageUI.Button('Effectuer le code de la route', nil, {RightLabel = ("~g~%s$~s~ →→"):format(ConfigAutoEcole.PrixCode)}, true, {
                            onSelected = function()
                                TriggerServerEvent('rx:BuyLicense', ConfigAutoEcole.PrixCode)
                            end
                        })
                    else
                        if not voiture then
                            RageUI.Button("Permis de voiture", nil, {RightLabel = ("~g~%s$~s~ →→"):format(ConfigAutoEcole.PrixPermisVoiture)}, true, {
                                onSelected = function()
                                    TriggerServerEvent('rx:BuyPermis', ConfigAutoEcole.PrixPermisVoiture, 'drive')
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    code_menu = false
                                    RageUI.CloseAll()
                                end
                            })
                        else
                            RageUI.Button("Permis de voiture", nil, {RightLabel = "~g~Réussi~s~"}, true, {
                            })
                        end

                        if not moto then
                            RageUI.Button("Permis de moto", nil, {RightLabel = ("~g~%s$~s~ →→"):format(ConfigAutoEcole.PrixPermisMoto)}, true, {
                                onSelected = function()
                                    TriggerServerEvent('rx:BuyPermis', ConfigAutoEcole.PrixPermisMoto, 'drive_bike')
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    code_menu = false
                                    RageUI.CloseAll()
                                end
                            })
                        else
                            RageUI.Button("Permis de moto", nil, {RightLabel = "~g~Réussi~s~"}, true, {
                            })
                        end

                        if not camion then
                            RageUI.Button("Permis de camion", nil, {RightLabel = ("~g~%s$~s~ →→"):format(ConfigAutoEcole.PrixPermisCamion)}, true, {
                                onSelected = function()
                                    TriggerServerEvent('rx:BuyPermis', ConfigAutoEcole.PrixPermisCamion, 'drive_truck')
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    code_menu = false
                                    RageUI.CloseAll()
                                end
                            })
                        else
                            RageUI.Button("Permis de camion", nil, {RightLabel = "~g~Réussi~s~"}, true, {
                            })
                        end
                    end
                end)
            end
        end)
    end
end

local ErreurPermis = 0
examen_menu = false
local menu_examen = RageUI.CreateMenu("rxAutoEcole", "Examen :")
local menu_examen_1 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_2 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_3 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_4 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_5 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_6 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_7 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_8 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_9 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_10 = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Réponses disponibles :")
local menu_examen_final = RageUI.CreateSubMenu(menu_examen, "rxAutoEcole", "Résultat du code :")
menu_examen.Closable = false
menu_examen.Closed = function()
    examen_menu = false
end

function CodeExamenMenu()
    if examen_menu then
        examen_menu = false
        RageUI.Visible(menu_examen, false)
        return
    else
        examen_menu = true
        menu_examen.Controls.Back.Enabled = false
        RageUI.Visible(menu_examen, true)

        CreateThread(function()
            while examen_menu do
                Wait(1)

                RageUI.IsVisible(menu_examen, function()

                    RageUI.Separator("~b~↓↓~w~  Auto-école  ~b~↓↓~w~")
                    RageUI.Line()

                    RageUI.Button('Commencer le code de la route', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = 0
                            ConfigAutoEcole.timer = 180
                            timer_active = true
                            Notification(("[~y~Information~s~] Vous commencez votre code de la route, vous avez ~g~%s minutes~s~."):format(ConfigAutoEcole.timer/60))
                        end
                    }, menu_examen_1)
                end)

                RageUI.IsVisible(menu_examen_1, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Quelle est la vitesse adaptée en ville :")
                    RageUI.Line()

                    RageUI.Button('50 km/h', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_2)

                    RageUI.Button('70 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_2)

                    RageUI.Button('90 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_2)
                end)

                RageUI.IsVisible(menu_examen_2, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Avant chaque changement de file :")
                    RageUI.Line()

                    RageUI.Button('Vérifiez vos rétroviseurs', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_3)

                    RageUI.Button('Vérifiez vos angles morts', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_3)

                    RageUI.Button('Signalez vos intentions', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_3)

                    RageUI.Button('Tout cela', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_3)
                end)

                RageUI.IsVisible(menu_examen_3, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Quelle est le taux d'alcoolémie maximale :")
                    RageUI.Line()

                    RageUI.Button('0.3%', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_4)

                    RageUI.Button('0.5%', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_4)

                    RageUI.Button('1.0%', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_4)
                end)

                RageUI.IsVisible(menu_examen_4, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("À quel moment vous pouvez passer au feu :")
                    RageUI.Line()

                    RageUI.Button('Quand il est vert', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_5)

                    RageUI.Button('Quand il n\'y a personne sur l\'intersection', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_5)

                    RageUI.Button('Vert et/ou rouge et que je tourne à droite', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_5)
                end)

                RageUI.IsVisible(menu_examen_5, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Vous êtes dépassé il est important de pas :")
                    RageUI.Line()

                    RageUI.Button('Vérifiez vos rétroviseurs', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_6)

                    RageUI.Button('Augmenter votre vitesse', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_6)

                    RageUI.Button('Regarder les autres conducteurs', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_6)
                end)

                RageUI.IsVisible(menu_examen_6, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Quelle est la vitesse adaptée sur l'autoroute :")
                    RageUI.Line()

                    RageUI.Button('90 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_7)

                    RageUI.Button('110 km/h', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_7)

                    RageUI.Button('130 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_7)
                end)

                RageUI.IsVisible(menu_examen_7, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("En cas de voyant moteur allumé :")
                    RageUI.Line()

                    RageUI.Button("Je m'arrête directement", nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_8)

                    RageUI.Button('Je passe au garage au plus vite', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_8)

                    RageUI.Button('Je continue sans inquiétude', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_8)

                    RageUI.Button("Je saute de ma voiture, risque d'explosion", nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_8)
                end)

                RageUI.IsVisible(menu_examen_8, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Quelle est la distance de sécurité :")
                    RageUI.Line()

                    RageUI.Button('10m sur autoroute et 2m en ville', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_9)

                    RageUI.Button('5m sur autoroute et 1m en ville', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_9)

                    RageUI.Button('15m sur autoroute et 4m en ville', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_9)
                end)

                RageUI.IsVisible(menu_examen_9, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Vitesse adaptée en zone résidentielle :")
                    RageUI.Line()

                    RageUI.Button('15 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_10)

                    RageUI.Button('30 km/h', nil, {RightLabel = ("→→")}, true, {
                    }, menu_examen_10)

                    RageUI.Button('40 km/h', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            ErreurPermis = ErreurPermis + 1
                        end
                    }, menu_examen_10)
                end)

                RageUI.IsVisible(menu_examen_10, function()

                    RageUI.Separator("Question :")
                    RageUI.Separator("Lorsque les secours sont en alerte :")
                    RageUI.Line()

                    RageUI.Button('Je dégage la voix au plus vite', nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            timer_active = false
                            if ErreurPermis >= 3 then
                                Notification(("[~r~Échoué~s~] Vous avez fait ~r~%s~s~ erreurs."):format(ErreurPermis))
                            else
                                Notification(("[~g~Réussi~s~] Félicitaion, vous avez eu ~r~%s~s~ erreurs."):format(ErreurPermis))
                                TriggerServerEvent('rx:addLicense', 'dmv')
                            end
                        end
                    }, menu_examen_final)

                    RageUI.Button("Je m'arrête au millieu de la route", nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            timer_active = false
                            ErreurPermis = ErreurPermis + 1
                            if ErreurPermis >= 3 then
                                Notification(("[~r~Échoué~s~] Vous avez fait ~r~%s~s~ erreurs."):format(ErreurPermis))
                            else
                                Notification(("[~g~Réussi~s~] Félicitaion, vous avez eu ~r~%s~s~ erreurs."):format(ErreurPermis))
                                TriggerServerEvent('rx:addLicense', 'dmv')
                            end
                        end
                    }, menu_examen_final)

                    RageUI.Button("J'accèlere", nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            timer_active = false
                            ErreurPermis = ErreurPermis + 1
                            if ErreurPermis >= 3 then
                                Notification(("[~r~Échoué~s~] Vous avez fait ~r~%s~s~ erreurs."):format(ErreurPermis))
                            else
                                Notification(("[~g~Réussi~s~] Félicitaion, vous avez eu ~r~%s~s~ erreurs."):format(ErreurPermis))
                                TriggerServerEvent('rx:addLicense', 'dmv')
                            end
                        end
                    }, menu_examen_final)
                end)

                RageUI.IsVisible(menu_examen_final, function()

                    if ErreurPermis >= 3 then
                        RageUI.Separator("Résultat : ~r~Échoué")
                        RageUI.Separator("Vous avez eu ~r~"..ErreurPermis.."~s~ erreurs.")
                    else
                        RageUI.Separator("Résultat : ~g~Réussi")
                        if ErreurPermis == 0 then
                            RageUI.Separator("Vous avez eu ~g~"..ErreurPermis.."~s~ erreurs.")
                        else
                            RageUI.Separator("Vous avez eu ~r~"..ErreurPermis.."~s~ erreurs.")
                        end
                    end
                    RageUI.Line()

                    RageUI.CentralButton("~g~Fermer l'examen", nil, {RightLabel = ("→→")}, true, {
                        onSelected = function()
                            DoScreenFadeOut(1700)
                            Wait(2000)
                            examen_menu = false
                            RageUI.CloseAll()
                            SetPlayerControl(PlayerId(), true)
                            destroyCam(1)
                            SetEntityCoords(PlayerPedId(), vector3(202.1189, -1392.098, 30.61905))
                            SetEntityHeading(PlayerPedId(), 321.98852539063)
                            Wait(1000)
                            DoScreenFadeIn(1700)
                        end
                    })
                end)
            end
        end)
    end
end

CreateThread(function()
    while true do
        local interval = 500
        local pCoords = GetEntityCoords(PlayerPedId(), false)
        local distance = Vdist(pCoords.x, pCoords.y, pCoords.z, ConfigAutoEcole.PositionCode.x, ConfigAutoEcole.PositionCode.y, ConfigAutoEcole.PositionCode.z)

        if distance < 5.0 then
            interval = 0
            DrawMarker(21, ConfigAutoEcole.PositionCode.x, ConfigAutoEcole.PositionCode.y, ConfigAutoEcole.PositionCode.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            if distance < 1.5 then
                HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour parler à la secrétaire.")
                if IsControlJustPressed(1, 51) then
                    code_menu = false
                    PermisCodeMenu()
                    FreezeEntityPosition(PlayerPedId(), true)
                end
            end
        end
        Wait(interval)
    end
end)
