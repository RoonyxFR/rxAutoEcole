ESX = nil 

CreateThread(function()
	while ESX == nil do
		TriggerEvent(ConfigAutoEcole.ESX, function(obj) ESX = obj end)
		Wait(0)
	end
end)

CreateThread(function()
	local direction = ConfigAutoEcole.PositionCode
	local bAutoEcole = AddBlipForCoord(direction.x, direction.y, direction.z)

	SetBlipSprite(bAutoEcole, 408)
	SetBlipColour(bAutoEcole, 4)
	SetBlipScale(bAutoEcole, 0.7)
	SetBlipAsShortRange(bAutoEcole, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString("Auto-école")
	EndTextCommandSetBlipName(bAutoEcole)
end)

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(100)
	end
end

CreateThread(function()
	LoadModel("mp_f_boatstaff_01")
	local ped = CreatePed(2, GetHashKey("mp_f_boatstaff_01"), ConfigAutoEcole.PositionCodePed.x, ConfigAutoEcole.PositionCodePed.y, ConfigAutoEcole.PositionCodePed.z, ConfigAutoEcole.PositionCodePed.h, 0, 0)
	FreezeEntityPosition(ped, 1)
	SetEntityInvincible(ped, true)
	SetEntityAsMissionEntity(ped, 1, 1)
	SetBlockingOfNonTemporaryEvents(ped, 1)
end)

function HelpNotif(msg)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

function Notification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end

-----------------------------------------------> Check Function <-----------------------------------------------

function checkLicence()
	ESX.TriggerServerCallback("rx:checkLicense", function(codeCheck)
		code = codeCheck
	end, GetPlayerServerId(PlayerId()), "dmv")
	ESX.TriggerServerCallback("rx:checkLicense", function(voitureCheck)
		voiture = voitureCheck
	end, GetPlayerServerId(PlayerId()), "drive")
	ESX.TriggerServerCallback("rx:checkLicense", function(codeCheck)
		moto = codeCheck
	end, GetPlayerServerId(PlayerId()), "drive_bike")
	ESX.TriggerServerCallback("rx:checkLicense", function(codeCheck)
		camion = codeCheck
	end, GetPlayerServerId(PlayerId()), "drive_truck")
end

-----------------------------------------------> Camera Function <-----------------------------------------------

function setAnimation(coords)
	cinemaMode = true
	TaskGoStraightToCoord(PlayerPedId(), coords, 1.0, 8000, 265.25466, 5)
	cinemaMode = false
end

setCameraCreator = function(camType)
	if camType == 1 then
		cam1 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
		SetCamActive(cam1, true)
		PointCamAtEntity(cam1, PlayerPedId(), 0, 0, 0, 1)
		SetCamParams(cam1, 207.9422, -1397.077, 31.48354, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
		SetCamFov(cam1, 60.0)
		RenderScriptCams(1, 0, 0, 1, 1)
	elseif camType == 2 then
		cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
		SetCamActive(cam2, true)
		PointCamAtEntity(cam2, PlayerPedId(), 0, 0, 0, 1)
		SetCamParams(cam2, 209.308, -1380.983, 31.08352, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
		SetCamFov(cam2, 60.0)
		RenderScriptCams(1, 0, 0, 1, 1)
	end
end

destroyCam = function(type)
	if type == 1 then
		DestroyCam(cam2, false)
		RenderScriptCams(false, true, 1500, false, false)
	end
end

-----------------------------------------------> Animation Function <-----------------------------------------------

function openExamenMenu(id)
	code_menu = false
	RageUI.CloseAll()
	FreezeEntityPosition(PlayerPedId(), false)
	SetPlayerControl(PlayerId(), false)
	DoScreenFadeOut(1700)
	Wait(2000)
	setCameraCreator(1)
	setAnimation(vector3(212.677, -1393.804, 30.58))
	DoScreenFadeIn(1700)
	Wait(2500)
	setAnimation(vector3(203.6876, -1389.413, 30.58353))
	Wait(4500)
	DoScreenFadeOut(1700)
	Wait(2000)
	setCameraCreator(2)
	SetEntityCoords(PlayerPedId(), 204.8867, -1387.542, 30.58353)
	setAnimation(vector3(208.8857, -1382.833, 30.58353))
	Wait(1000)
	DoScreenFadeIn(1700)
	Wait(1500)
	DoScreenFadeOut(1700)
	Wait(3500)
	SetEntityHeading(PlayerPedId(), 338.0)
	CodeExamenMenu()
	Wait(500)
	DoScreenFadeIn(1700)
end

-----------------------------------------------> Trigger pour le server <--------------------------------------------------

RegisterNetEvent("rx:startExamen")
AddEventHandler("rx:startExamen", function(id)
	openExamenMenu(PlayerId())
end)

RegisterNetEvent("rx:startPermis")
AddEventHandler("rx:startPermis", function(type)
	StartDriveTest(type)
end)

-----------------------------------------------> Timer Function <--------------------------------------------------

timer_active = false

CreateThread(function()
	while true do
		local interval = 500
		if timer_active then
			interval = 0
			if ConfigAutoEcole.timer > 0 then
				ConfigAutoEcole.timer = ConfigAutoEcole.timer - 1
				RageUI.Text({ message = (("Il vous restes ~r~%s~s~ secondes."):format(ConfigAutoEcole.timer)), time_display = 1100 })
				Wait(1000)
			end
			if ConfigAutoEcole.timer == 0 then
				Notification("[~r~Échoué~s~] vous avez mit trop de temps à remplir l'examen")
				DoScreenFadeOut(1700)
				Wait(2000)
				interval = 500
				timer_active = false
				ConfigAutoEcole.timer = 180
				examen_menu = false
				RageUI.CloseAll()
				SetPlayerControl(PlayerId(), true)
				destroyCam(1)
				SetEntityCoords(PlayerPedId(), vector3(202.1189, -1392.098, 30.61905))
				SetEntityHeading(PlayerPedId(), 321.98852539063)
				Wait(1000)
				DoScreenFadeIn(1700)
			end
		else
			interval = 500
		end
		Wait(interval)
	end
end)
