;===============================================================================
;LSPD Keybinder
Version := 1.6
;===============================================================================
#SingleInstance, Force
#NoEnv 
#IfWinActive, ahk_exe gta_sa.exe

IfExist update.bat
{
FileDelete update.bat
}

UrlDownloadToFile http://80.252.107.195/LSPD_Keybinder/Version.txt, version.txt

FileRead, NewestVersion, version.txt
FileDelete version.txt

if NewestVersion is not number
{
MsgBox, 48, Fehler, Die Updateserver sind derzeit nicht erreichbar!`nBitte bei Kabby melden. Der Keybinder kann trotzdessen weiter verwendet werden.`nEs können aber keine Hintergrundbilder oder ähnliches heruntergeladen werden!
SERVERDOWN := 1
}

if(SERVERDOWN == 1){
}
else if(NewestVersion > version){
MsgBox, 68, Update verfügbar, Es ist ein Update verfügbar!`n`nAktuelle Version:     [%Version%]`nNeue Version:          [%NewestVersion%]`n`nMöchtest du den Keybinder aktualisieren?
IfMsgBox, YES
{
SplashTextOn, 200, 50, Keybinder, Der Keybinder wird geupdated! Bitte warten...
UrlDownloadToFile http://80.252.107.195/LSPD_Keybinder/Keybinder.exe, %A_ScriptName%.new
UpdateBat=
        (
            Del "%A_ScriptName%"
            Rename "%A_ScriptName%.new" "%A_ScriptName%
            cd "%A_ScriptFullPath%"
            "%A_ScriptName%"
)
FileAppend, %UpdateBat%, update.bat
Run, update.bat, , hide
SplashTextOff
ExitApp
}
IfMsgBox, NO
{
}
}
else
{
}

RegRead, sampuser, HKEY_CURRENT_USER, Software\SAMP, PlayerName

PATH_SAMP_API := PathCombine(A_ScriptDir, "Open-SAMP-API.dll")

hModule := DllCall("LoadLibrary", Str, PATH_SAMP_API)
if(hModule == -1 || hModule == 0)
{
	MsgBox, 48, Error, The dll-file couldn't be found!
	ExitApp
}

;Client.hpp
Init_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "Init")
SetParam_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "SetParam")

;GTAFunctions.hpp
GetGTACommandLine_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetGTACommandLine")
IsMenuOpen_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsMenuOpen")
ScreenToWorld_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ScreenToWorld")
WorldToScreen_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "WorldToScreen")

;PlayerFunctions.hpp
GetPlayerCPed_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerCPed")
GetPlayerHealth_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerHealth")
GetPlayerArmor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerArmor")
GetPlayerMoney_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerMoney")
GetPlayerSkinID_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerSkinID")
GetPlayerInterior_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerInterior")
IsPlayerInAnyVehicle_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerInAnyVehicle")
IsPlayerDriver_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerDriver")
IsPlayerPassenger_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerPassenger")
IsPlayerInInterior_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerInInterior")
GetPlayerX_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerX")
GetPlayerY_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerY")
GetPlayerZ_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerZ")
GetPlayerPosition_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerPosition")
IsPlayerInRange2D_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerInRange2D")
IsPlayerInRange3D_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsPlayerInRange3D")
GetCityName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetCityName")
GetZoneName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetZoneName")

;RenderFunctions.hpp
TextCreate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextCreate")
TextDestroy_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextDestroy")
TextSetShadow_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextSetShadow")
TextSetShown_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextSetShown")
TextSetColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextSetColor")
TextSetPos_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextSetPos")
TextSetString_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextSetString")
TextUpdate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "TextUpdate")
BoxCreate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxCreate")
BoxDestroy_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxDestroy")
BoxSetShown_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetShown")
BoxSetBorder_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetBorder")
BoxSetBorderColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetBorderColor")
BoxSetColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetColor")
BoxSetHeight_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetHeight")
BoxSetPos_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetPos")
BoxSetWidth_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "BoxSetWidth")
LineCreate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineCreate")
LineDestroy_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineDestroy")
LineSetShown_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineSetShown")
LineSetColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineSetColor")
LineSetWidth_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineSetWidth")
LineSetPos_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "LineSetPos")
ImageCreate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageCreate")
ImageDestroy_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageDestroy")
ImageSetShown_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageSetShown")
ImageSetAlign_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageSetAlign")
ImageSetPos_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageSetPos")
ImageSetRotation_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ImageSetRotation")
DestroyAllVisual_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "DestroyAllVisual")
ShowAllVisual_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ShowAllVisual")
HideAllVisual_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "HideAllVisual")
GetFrameRate_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetFrameRate")
GetScreenSpecs_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetScreenSpecs")
SetCalculationRatio_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "SetCalculationRatio")
SetOverlayPriority_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "SetOverlayPriority")
SetOverlayCalculationEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "SetOverlayCalculationEnabled")

;SAMPFunctions.hpp
GetServerIP_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetServerIP")
GetServerPort_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetServerPort")
SendChat_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "SendChat")
ShowGameText_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ShowGameText")
AddChatMessage_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "AddChatMessage")
ShowDialog_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "ShowDialog")
GetPlayerNameByID_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerNameByID")
GetPlayerIDByName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerIDByName")
GetPlayerName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerName")
GetPlayerId_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerId")
IsChatOpen_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsChatOpen")
IsDialogOpen_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsDialogOpen")

;VehicleFunctions.hpp
GetVehiclePointer_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehiclePointer")
GetVehicleSpeed_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleSpeed")
GetVehicleHealth_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleHealth")
GetVehicleModelId_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleModelId")
GetVehicleModelName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleModelName")
GetVehicleModelNameById_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleModelNameById")
GetVehicleType_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleType")
GetVehicleFreeSeats_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleFreeSeats")
GetVehicleFirstColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleFirstColor")
GetVehicleSecondColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleSecondColor")
GetVehicleColor_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetVehicleColor")
IsVehicleSeatUsed_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleSeatUsed")
IsVehicleLocked_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleLocked")
IsVehicleHornEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleHornEnabled")
IsVehicleSirenEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleSirenEnabled")
IsVehicleAlternateSirenEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleAlternateSirenEnabled")
IsVehicleEngineEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleEngineEnabled")
IsVehicleLightEnabled_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleLightEnabled")
IsVehicleCar_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleCar")
IsVehiclePlane_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehiclePlane")
IsVehicleBoat_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleBoat")
IsVehicleTrain_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleTrain")
IsVehicleBike_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "IsVehicleBike")

;WeaponFunctions.hpp
HasWeaponIDClip_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "HasWeaponIDClip")
GetPlayerWeaponID_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponID")
GetPlayerWeaponType_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponType")
GetPlayerWeaponSlot_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponSlot")
GetPlayerWeaponName_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponName")
GetPlayerWeaponClip_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponClip")
GetPlayerWeaponTotalClip_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponTotalClip")
GetPlayerWeaponState_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponState")
GetPlayerWeaponAmmo_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponAmmo")
GetPlayerWeaponAmmoInClip_func := DllCall("GetProcAddress", "UInt", hModule, "AStr", "GetPlayerWeaponAmmoInClip")

Init()
{
	global Init_func
	return DllCall(Init_func)
}

SetParam(_szParamName, _szParamValue)
{
	global SetParam_func
	return DllCall(SetParam_func, "AStr", _szParamName, "AStr", _szParamValue)
}

GetGTACommandLine(ByRef line, max_len)
{
	global GetGTACommandLine_func
	VarSetCapacity(line, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetGTACommandLine_func, "StrP", line, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	line := StrGet(&line, "cp0")
	return res
}

IsMenuOpen()
{
	global IsMenuOpen_func
	return DllCall(IsMenuOpen_func)
}

ScreenToWorld(x, y, ByRef worldX, ByRef worldY, ByRef worldZ)
{
	global ScreenToWorld_func
	return DllCall(ScreenToWorld_func, "Float", x, "Float", y, "FloatP", worldX, "FloatP", worldY, "FloatP", worldZ)
}

WorldToScreen(x, y, z, ByRef screenX, ByRef screenY)
{
	global WorldToScreen_func
	return DllCall(WorldToScreen_func, "Float", x, "Float", y, "Float", z, "FloatP", screenX, "FloatP", screenY)
}

GetPlayerCPed()
{
	global GetPlayerCPed_func
	return DllCall(GetPlayerCPed_func)
}

GetPlayerHealth()
{
	global GetPlayerHealth_func
	return DllCall(GetPlayerHealth_func)
}

GetPlayerArmor()
{
	global GetPlayerArmor_func
	return DllCall(GetPlayerArmor_func)
}

GetPlayerMoney()
{
	global GetPlayerMoney_func
	return DllCall(GetPlayerMoney_func)
}

GetPlayerSkinID()
{
	global GetPlayerSkinID_func
	return DllCall(GetPlayerSkinID_func)
}

GetPlayerInterior()
{
	global GetPlayerInterior_func
	return DllCall(GetPlayerInterior_func)
}

IsPlayerInAnyVehicle()
{
	global IsPlayerInAnyVehicle_func
	return DllCall(IsPlayerInAnyVehicle_func)
}

IsPlayerDriver()
{
	global IsPlayerDriver_func
	return DllCall(IsPlayerDriver_func)
}

IsPlayerPassenger()
{
	global IsPlayerPassenger_func
	return DllCall(IsPlayerPassenger_func)
}

IsPlayerInInterior()
{
	global IsPlayerInInterior_func
	return DllCall(IsPlayerInInterior_func)
}

GetPlayerX(ByRef posX)
{
	global GetPlayerX_func
	return DllCall(GetPlayerX_func, "FloatP", posX)
}

GetPlayerY(ByRef posY)
{
	global GetPlayerY_func
	return DllCall(GetPlayerY_func, "FloatP", posY)
}

GetPlayerZ(ByRef posZ)
{
	global GetPlayerZ_func
	return DllCall(GetPlayerZ_func, "FloatP", posZ)
}

GetPlayerPosition(ByRef posX, ByRef posY, ByRef posZ)
{
	global GetPlayerPosition_func
	return DllCall(GetPlayerPosition_func, "FloatP", posX, "FloatP", posY, "FloatP", posZ)
}

IsPlayerInRange2D(posX, posY, radius)
{
	global IsPlayerInRange2D_func
	return DllCall(IsPlayerInRange2D_func, "Float", posX, "Float", posY, "Float", radius)
}

IsPlayerInRange3D(posX, posY, posZ, radius)
{
	global IsPlayerInRange3D_func
	return DllCall(IsPlayerInRange3D_func, "Float", posX, "Float", posY, "Float", posZ, "Float", radius)
}

GetCityName(ByRef cityName, max_len)
{
	global GetCityName_func
	VarSetCapacity(cityName, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetCityName_func, "StrP", cityName, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	cityName := StrGet(&cityName, "cp0")
	return res
}

GetZoneName(ByRef zoneName, max_len)
{
	global GetZoneName_func
	VarSetCapacity(zoneName, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetZoneName_func, "StrP", zoneName, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	zoneName := StrGet(&zoneName, "cp0")
	return res
}

TextCreate(Font, FontSize, bBold, bItalic, x, y, color, text, bShadow, bShow)
{
	global TextCreate_func
	return DllCall(TextCreate_func, "AStr", Font, "Int", FontSize, "UChar", bBold, "UChar", bItalic, "Int", x, "Int", y, "UInt", color, "AStr", text, "UChar", bShadow, "UChar", bShow)
}

TextDestroy(ID)
{
	global TextDestroy_func
	return DllCall(TextDestroy_func, "Int", ID)
}

TextSetShadow(id, b)
{
	global TextSetShadow_func
	return DllCall(TextSetShadow_func, "Int", id, "UChar", b)
}

TextSetShown(id, b)
{
	global TextSetShown_func
	return DllCall(TextSetShown_func, "Int", id, "UChar", b)
}

TextSetColor(id, color)
{
	global TextSetColor_func
	return DllCall(TextSetColor_func, "Int", id, "UInt", color)
}

TextSetPos(id, x, y)
{
	global TextSetPos_func
	return DllCall(TextSetPos_func, "Int", id, "Int", x, "Int", y)
}

TextSetString(id, str)
{
	global TextSetString_func
	return DllCall(TextSetString_func, "Int", id, "AStr", str)
}

TextUpdate(id, Font, FontSize, bBold, bItalic)
{
	global TextUpdate_func
	return DllCall(TextUpdate_func, "Int", id, "AStr", Font, "Int", FontSize, "UChar", bBold, "UChar", bItalic)
}

BoxCreate(x, y, w, h, dwColor, bShow)
{
	global BoxCreate_func
	return DllCall(BoxCreate_func, "Int", x, "Int", y, "Int", w, "Int", h, "UInt", dwColor, "UChar", bShow)
}

BoxDestroy(id)
{
	global BoxDestroy_func
	return DllCall(BoxDestroy_func, "Int", id)
}

BoxSetShown(id, bShown)
{
	global BoxSetShown_func
	return DllCall(BoxSetShown_func, "Int", id, "UChar", bShown)
}

BoxSetBorder(id, height, bShown)
{
	global BoxSetBorder_func
	return DllCall(BoxSetBorder_func, "Int", id, "Int", height, "UChar", bShown)
}

BoxSetBorderColor(id, dwColor)
{
	global BoxSetBorderColor_func
	return DllCall(BoxSetBorderColor_func, "Int", id, "UInt", dwColor)
}

BoxSetColor(id, dwColor)
{
	global BoxSetColor_func
	return DllCall(BoxSetColor_func, "Int", id, "UInt", dwColor)
}

BoxSetHeight(id, height)
{
	global BoxSetHeight_func
	return DllCall(BoxSetHeight_func, "Int", id, "Int", height)
}

BoxSetPos(id, x, y)
{
	global BoxSetPos_func
	return DllCall(BoxSetPos_func, "Int", id, "Int", x, "Int", y)
}

BoxSetWidth(id, width)
{
	global BoxSetWidth_func
	return DllCall(BoxSetWidth_func, "Int", id, "Int", width)
}

LineCreate(x1, y1, x2, y2, width, color, bShow)
{
	global LineCreate_func
	return DllCall(LineCreate_func, "Int", x1, "Int", y1, "Int", x2, "Int", y2, "Int", width, "UInt", color, "UChar", bShow)
}

LineDestroy(id)
{
	global LineDestroy_func
	return DllCall(LineDestroy_func, "Int", id)
}

LineSetShown(id, bShown)
{
	global LineSetShown_func
	return DllCall(LineSetShown_func, "Int", id, "UChar", bShown)
}

LineSetColor(id, color)
{
	global LineSetColor_func
	return DllCall(LineSetColor_func, "Int", id, "UInt", color)
}

LineSetWidth(id, width)
{
	global LineSetWidth_func
	return DllCall(LineSetWidth_func, "Int", id, "Int", width)
}

LineSetPos(id, x1, y1, x2, y2)
{
	global LineSetPos_func
	return DllCall(LineSetPos_func, "Int", id, "Int", x1, "Int", y1, "Int", x2, "Int", y2)
}

ImageCreate(path, x, y, rotation, align, bShow)
{
	global ImageCreate_func
	return DllCall(ImageCreate_func, "AStr", path, "Int", x, "Int", y, "Int", rotation, "Int", align, "UChar", bShow)
}

ImageDestroy(id)
{
	global ImageDestroy_func
	return DllCall(ImageDestroy_func, "Int", id)
}

ImageSetShown(id, bShown)
{
	global ImageSetShown_func
	return DllCall(ImageSetShown_func, "Int", id, "UChar", bShown)
}

ImageSetAlign(id, align)
{
	global ImageSetAlign_func
	return DllCall(ImageSetAlign_func, "Int", id, "Int", align)
}

ImageSetPos(id, x, y)
{
	global ImageSetPos_func
	return DllCall(ImageSetPos_func, "Int", id, "Int", x, "Int", y)
}

ImageSetRotation(id, rotation)
{
	global ImageSetRotation_func
	return DllCall(ImageSetRotation_func, "Int", id, "Int", rotation)
}

DestroyAllVisual()
{
	global DestroyAllVisual_func
	return DllCall(DestroyAllVisual_func)
}

ShowAllVisual()
{
	global ShowAllVisual_func
	return DllCall(ShowAllVisual_func)
}

HideAllVisual()
{
	global HideAllVisual_func
	return DllCall(HideAllVisual_func)
}

GetFrameRate()
{
	global GetFrameRate_func
	return DllCall(GetFrameRate_func)
}

GetScreenSpecs(ByRef width, ByRef height)
{
	global GetScreenSpecs_func
	return DllCall(GetScreenSpecs_func, "IntP", width, "IntP", height)
}

SetCalculationRatio(width, height)
{
	global SetCalculationRatio_func
	return DllCall(SetCalculationRatio_func, "Int", width, "Int", height)
}

SetOverlayPriority(id, priority)
{
	global SetOverlayPriority_func
	return DllCall(SetOverlayPriority_func, "Int", id, "Int", priority)
}

SetOverlayCalculationEnabled(id, enabled)
{
	global SetOverlayCalculationEnabled_func
	return DllCall(SetOverlayCalculationEnabled_func, "Int", id, "UChar", enabled)
}

GetServerIP(ByRef ip, max_len)
{
	global GetServerIP_func
	VarSetCapacity(ip, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetServerIP_func, "StrP", ip, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	ip := StrGet(&ip, "cp0")
	return res
}

GetServerPort()
{
	global GetServerPort_func
	return DllCall(GetServerPort_func)
}

SendChat(msg)
{
	global SendChat_func
	return DllCall(SendChat_func, "AStr", msg)
}

ShowGameText(msg, time, style)
{
	global ShowGameText_func
	return DllCall(ShowGameText_func, "AStr", msg, "Int", time, "Int", style)
}

AddChatMessage(msg)
{
	global AddChatMessage_func
	return DllCall(AddChatMessage_func, "AStr", msg)
}

ShowDialog(id, style, caption, text, button, button2)
{
	global ShowDialog_func
	return DllCall(ShowDialog_func, "Int", id, "Int", style, "AStr", caption, "AStr", text, "AStr", button, "AStr", button2)
}

GetPlayerNameByID(id, ByRef playername, max_len)
{
	global GetPlayerNameByID_func
	VarSetCapacity(playername, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetPlayerNameByID_func, "Int", id, "StrP", playername, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	playername := StrGet(&playername, "cp0")
	return res
}

GetPlayerIDByName(name)
{
	global GetPlayerIDByName_func
	return DllCall(GetPlayerIDByName_func, "AStr", name)
}

GetPlayerName(ByRef playername, max_len)
{
	global GetPlayerName_func
	VarSetCapacity(playername, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetPlayerName_func, "StrP", playername, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	playername := StrGet(&playername, "cp0")
	return res
}

GetPlayerId()
{
	global GetPlayerId_func
	return DllCall(GetPlayerId_func)
}

IsChatOpen()
{
	global IsChatOpen_func
	return DllCall(IsChatOpen_func)
}

IsDialogOpen()
{
	global IsDialogOpen_func
	return DllCall(IsDialogOpen_func)
}

GetVehiclePointer()
{
	global GetVehiclePointer_func
	return DllCall(GetVehiclePointer_func)
}

GetVehicleSpeed(factor)
{
	global GetVehicleSpeed_func
	return DllCall(GetVehicleSpeed_func, "Float", factor)
}

GetVehicleHealth()
{
	global GetVehicleHealth_func
	return DllCall(GetVehicleHealth_func, "Cdecl float")
}

GetVehicleModelId()
{
	global GetVehicleModelId_func
	return DllCall(GetVehicleModelId_func)
}

GetVehicleModelName(ByRef name, max_len)
{
	global GetVehicleModelName_func
	VarSetCapacity(name, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetVehicleModelName_func, "StrP", name, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	name := StrGet(&name, "cp0")
	return res
}

GetVehicleModelNameById(vehicleID, ByRef name, max_len)
{
	global GetVehicleModelNameById_func
	VarSetCapacity(name, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetVehicleModelNameById_func, "Int", vehicleID, "StrP", name, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	name := StrGet(&name, "cp0")
	return res
}

GetVehicleType()
{
	global GetVehicleType_func
	return DllCall(GetVehicleType_func)
}

GetVehicleFreeSeats(ByRef seatFL, ByRef seatFR, ByRef seatRL, ByRef seatRR)
{
	global GetVehicleFreeSeats_func
	return DllCall(GetVehicleFreeSeats_func, "IntP", seatFL, "IntP", seatFR, "IntP", seatRL, "IntP", seatRR)
}

GetVehicleFirstColor()
{
	global GetVehicleFirstColor_func
	return DllCall(GetVehicleFirstColor_func)
}

GetVehicleSecondColor()
{
	global GetVehicleSecondColor_func
	return DllCall(GetVehicleSecondColor_func)
}

GetVehicleColor(ByRef color1, ByRef color2)
{
	global GetVehicleColor_func
	return DllCall(GetVehicleColor_func, "IntP", color1, "IntP", color2)
}

IsVehicleSeatUsed(seat)
{
	global IsVehicleSeatUsed_func
	return DllCall(IsVehicleSeatUsed_func, "Int", seat)
}

IsVehicleLocked()
{
	global IsVehicleLocked_func
	return DllCall(IsVehicleLocked_func)
}

IsVehicleHornEnabled()
{
	global IsVehicleHornEnabled_func
	return DllCall(IsVehicleHornEnabled_func)
}

IsVehicleSirenEnabled()
{
	global IsVehicleSirenEnabled_func
	return DllCall(IsVehicleSirenEnabled_func)
}

IsVehicleAlternateSirenEnabled()
{
	global IsVehicleAlternateSirenEnabled_func
	return DllCall(IsVehicleAlternateSirenEnabled_func)
}

IsVehicleEngineEnabled()
{
	global IsVehicleEngineEnabled_func
	return DllCall(IsVehicleEngineEnabled_func)
}

IsVehicleLightEnabled()
{
	global IsVehicleLightEnabled_func
	return DllCall(IsVehicleLightEnabled_func)
}

IsVehicleCar()
{
	global IsVehicleCar_func
	return DllCall(IsVehicleCar_func)
}

IsVehiclePlane()
{
	global IsVehiclePlane_func
	return DllCall(IsVehiclePlane_func)
}

IsVehicleBoat()
{
	global IsVehicleBoat_func
	return DllCall(IsVehicleBoat_func)
}

IsVehicleTrain()
{
	global IsVehicleTrain_func
	return DllCall(IsVehicleTrain_func)
}

IsVehicleBike()
{
	global IsVehicleBike_func
	return DllCall(IsVehicleBike_func)
}

HasWeaponIDClip(weaponID)
{
	global HasWeaponIDClip_func
	return DllCall(HasWeaponIDClip_func, "Int", weaponID)
}

GetPlayerWeaponID()
{
	global GetPlayerWeaponID_func
	return DllCall(GetPlayerWeaponID_func)
}

GetPlayerWeaponType()
{
	global GetPlayerWeaponType_func
	return DllCall(GetPlayerWeaponType_func)
}

GetPlayerWeaponSlot()
{
	global GetPlayerWeaponSlot_func
	return DllCall(GetPlayerWeaponSlot_func)
}

GetPlayerWeaponName(dwWeapSlot, ByRef _szWeapName, max_len)
{
	global GetPlayerWeaponName_func
	VarSetCapacity(_szWeapName, max_len * (A_IsUnicode ? 2 : 1), 0)
	res := DllCall(GetPlayerWeaponName_func, "Int", dwWeapSlot, "StrP", _szWeapName, "Int", max_len)
	; We need StrGet to convert the API answer (ANSI) to the charset AHK uses (ANSI or Unicode)
	_szWeapName := StrGet(&_szWeapName, "cp0")
	return res
}

GetPlayerWeaponClip(dwWeapSlot)
{
	global GetPlayerWeaponClip_func
	return DllCall(GetPlayerWeaponClip_func, "Int", dwWeapSlot)
}

GetPlayerWeaponTotalClip(dwWeapSlot)
{
	global GetPlayerWeaponTotalClip_func
	return DllCall(GetPlayerWeaponTotalClip_func, "Int", dwWeapSlot)
}

GetPlayerWeaponState()
{
	global GetPlayerWeaponState_func
	return DllCall(GetPlayerWeaponState_func)
}

GetPlayerWeaponAmmo(weaponType)
{
	global GetPlayerWeaponAmmo_func
	return DllCall(GetPlayerWeaponAmmo_func, "Int", weaponType)
}

GetPlayerWeaponAmmoInClip(weaponType)
{
	global GetPlayerWeaponAmmoInClip_func
	return DllCall(GetPlayerWeaponAmmoInClip_func, "Int", weaponType)
}


PathCombine(abs, rel) {
	VarSetCapacity(dest, (A_IsUnicode ? 2 : 1) * 260, 1) ; MAX_PATH
	DllCall("Shlwapi.dll\PathCombine", "UInt", &dest, "UInt", &abs, "UInt", &rel)
	Return, dest
}

OnPlayerEnterVehicle(){
	Sleep, 100
	if(IsPlayerDriver() == 1 && IsVehicleLocked() == 0){
		SendChat("/flock")
	}
	if(IsPlayerDriver() == 1 && IsVehicleEngineEnabled() == 0){
		SendChat("/motor")
	}
	if(IsPlayerDriver() == 1 && IsVehicleLightEnabled() == 0){
		SendChat("/licht")
	}
	if(IsPlayerDriver() == 1 && getVehicleType() == 2){
		SendChat("/helm")
		helm := true
	}
}

OnPlayerExitVehicle(){
	if(IsPlayerDriver() == 1 && IsVehicleEngineEnabled() == 1){
		SendChat("/motor")
	}
	if(IsPlayerDriver() == 1 && IsVehicleLightEnabled() == 1){
		SendChat("/licht")
	}
	if(IsPlayerDriver() == 1 && IsVehicleLocked() == 1){
		SendChat("/flock")
	}
	if(IsPlayerDriver() == 1 && getVehicleType() == 2){
		SendChat("/helm")
		helm := false
	}
}

KMSG(myTextString){
	return addChatMessage("{0404B4}[Exekutive]{F2F2F2} " myTextString)
}

PlayerInput(text){
	s := A_IsSuspended
	Suspend On
	KeyWait Enter
	SendInput t^a{backspace}%text%
	Input, var, v, {enter}
	SendInput ^a{backspace 100}{enter}
	Sleep, 20
	if(!s)
	Suspend Off
	return var
}

GetChatLine(Line, ByRef Output, timestamp=0, color=0){
	chatindex := 0
	FileRead, file, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	loop, Parse, file, `n, `r
	{
		if(A_LoopField)
	chatindex := A_Index
	}
	loop, Parse, file, `n, `r
	{
		if(A_Index = chatindex - line){
			output := A_LoopField
			break
		}
	}
	file := ""
	if(!timestamp)
		output := RegExReplace(output, "U)^\[\d{2}:\d{2}:\d{2}\]")
	if(!color)
		output := RegExReplace(output, "Ui)\{[a-f0-9]{6}\}")
	return
}

IfNotExist, %A_AppData%\Keybinder\LSPD_Keybinder\config\
{
	FileCreateDir, %A_AppData%\Keybinder\LSPD_Keybinder\config\
}

IniRead, AEngine, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Automatic, Engine
if(AEngine == "ERROR" || AEngine == ""){
	AEngine := 1
	IniWrite, %AEngine%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Automatic, Engine
}
IniRead, TogKey, %A_AppData%\Keybinder\LSPD_Keybinder\config\Hotkeys.ini, Others, ToggleKey
if(TogKey == "ERROR" || TogKey == ""){
	TogKey := F12
	IniWrite, %TogKey%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Hotkeys.ini, Others, ToggleKey
}
IniRead, OV, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Status
if(OV == "ERROR" || OV == ""){
	OV := 0
	IniWrite, %OV%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Status
}
IniRead, OVcolor, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Color
if(OVcolor == "ERROR" || OVcolor == ""){
	OVcolor := 2
	IniWrite, %OVcolor%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Color
}
IniRead, OVsize, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Size
if(OVsize == "ERROR" || OVsize == ""){
	OVsize := 8
	IniWrite, %OVsize%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Size
}

IniRead, runKey, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Laufscript, runKey
if(runKey == "ERROR" || runKey == ""){
	runKey := 1
	IniWrite, %runKey%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Laufscript, runKey
}

global helm 			:= false
global OVloaded			:= false
global AEngine			:= 1
global maxChaseTime		:= 180
global maxTaserTime		:= 30
global chaseTime		:= 0
global isFinding		:= false


if(AEngine == 1){
	SetTimer, engineTimer, On
}else{
	SetTimer, engineTimer, Off
}

gosub main

SetTimer, Overlay, Off
;~ SetTimer, mainTimer, On
SetTimer, chaseTimer, Off
SetTimer, findTimer, Off
SetTimer, PressArTimeout, Off
SetTimer, PressFriskTimeout, Off
SetTimer, TicketTimer, On
return

GuiClose:
TextDestroy(HPoverlay)
ExitApp

Main:
Gui, Destroy
Gui, Add, Text, x2 y39 w100 h30, F2 + 1
Gui, Add, Text, x2 y79 w100 h30, F2 + 2
Gui, Add, Text, x2 y119 w100 h30, F2 + 3
Gui, Add, Text, x2 y159 w100 h30, F2 + 4
Gui, Add, Text, x2 y199 w100 h30, F2 + 5
Gui, Add, Text, x2 y239 w100 h30, F2 + 6
Gui, Add, Text, x2 y279 w100 h30, F2 + 7
Gui, Add, Text, x2 y319 w100 h30, F2 + 8
Gui, Add, Text, x2 y359 w100 h30, F2 + 9
Gui, Add, Text, x2 y399 w100 h30, F2 + 0
Gui, Add, Text, x112 y39 w260 h30, /m Achtung! Los Santos Police Department!
Gui, Add, Text, x112 y79 w260 h30, /m > LSPD < Halten Sie sofort an!
Gui, Add, Text, x112 y119 w260 h30, /m Letzte Aufforderung! Halten Sie sofort an, sonst schießen wir!
Gui, Add, Text, x112 y159 w260 h30, /m > LSPD < Allgemeine Verkehrskontrolle! Halten Sie sofort an!
Gui, Add, Text, x112 y199 w260 h30, Los Santos Police Department!
Gui, Add, Text, x112 y239 w260 h30, Haben Sie Waffen oder verbotene Gegenstände dabei?
Gui, Add, Text, x112 y279 w260 h30, Ich werde Sie nun auf illegale Gegenstände durchsuchen!
Gui, Add, Text, x112 y319 w260 h30, Ich werde noch Ihren Kofferraum durchsuchen. Öffnen Sie den Kofferraum mit /Kofferraum
Gui, Add, Text, x112 y359 w260 h30, Den Fahrzeugschein hätte ich noch gerne gesehen (/Fahrzeugschein [ID]).
Gui, Add, Text, x112 y399 w260 h30, Vielen Dank für Ihre Kooperation!
Gui, Add, Text, x402 y39 w100 h30, F3 + 1
Gui, Add, Text, x402 y79 w100 h30, F3 + 2
Gui, Add, Text, x402 y119 w100 h30, F3 + 3
Gui, Add, Text, x402 y159 w100 h30, F3 + 4
Gui, Add, Text, x402 y199 w100 h30, F3 + 5
Gui, Add, Text, x402 y239 w100 h30, F3 + 6
Gui, Add, Text, x402 y279 w100 h30, F3 + 7
Gui, Add, Text, x402 y319 w100 h30, F3 + 8
Gui, Add, Text, x402 y359 w100 h30, F3 + 9
Gui, Add, Text, x402 y399 w100 h30, F3 + 0
Gui, Add, Text, x512 y39 w260 h30, /m > LSPD < Räumen Sie sofort die Straße!
Gui, Add, Text, x512 y79 w260 h30, /s > LSPD < Hände hoch! Sonst schießen wir!
Gui, Add, Text, x512 y119 w260 h30, /s > LSPD < Letzte Vorwarnung! Sonst schießen wir!
Gui, Add, Text, x512 y159 w260 h30, /m Das Gebäude ist umstellt!
Gui, Add, Text, x512 y199 w260 h30, Steigen Sie in den Streifenwagen! Jeder Widerstand ist eine weitere Straftat!
Gui, Add, Text, x512 y239 w260 h30, /s Halten Sie Abstand! Sie stören die polizeiliche Maßnahme!
Gui, Add, Text, x512 y279 w260 h30, Sie sind verhaftet!
Gui, Add, Text, x512 y319 w260 h30, Polizei Notruf, wie können wir Ihnen helfen?
Gui, Add, Text, x512 y359 w260 h30, /s LSPD! Stehen bleiben!
Gui, Add, Text, x512 y399 w260 h30, Sie haben Wanteds, durch eine Geldstrafe können Sie diese freikaufen.
Gui, Add, Text, x2 y-1 w770 h40 +Center, Live your Dream Keybinder
Gui, Add, Button, x672 y449 w100 h30 gSave, Save
Gui, Add, Button, x552 y449 w100 h30 gSettings, Settings
Gui, Add, Button, x432 y449 w100 h30 gVariablen, Variables
Gui, Add, Button, x312 y449 w100 h30 gHelp, Help
Gui, Add, Button, x192 y449 w100 h30 gBefehle, Weitere Befehle
Gui, Add, Text, x2 y19 w90 h20 +Center, Hotkey
Gui, Add, Text, x112 y19 w250 h20 +Center, Text
Gui, Add, Text, x402 y19 w100 h20 +Center, Hotkey
Gui, Add, Text, x512 y19 w250 h20 +Center, Text
Gui, Show, w775 h490, Live your Dream Keybinder | Home
return

Help:
Gui, Destroy
Gui, Add, Text, x2 y-1 w470 h30 +Center, Live your Dream Keybinder - Help
Gui, Add, Text, x2 y39 w470 h310 , - Die Variablen lassen sich aktuell noch nicht verwenden`n`n- Das Overlay lässt sich aktuell nur Ingame über "/ov" aktivieren und deaktivieren`n`n- Overlay lässt sich aktuell nicht verschieben oder verändern`n`n
Gui, Add, Button, x312 y349 w160 h30 gAbord, Zurück
Gui, Show, w476 h384, Live your Dream Keybinder | Help
return

Befehle:
Gui, Destroy
Gui, Add, Text, x2 y-1 w470 h30 +Center, Live your Dream Keybinder - Weitere Befehle
Gui, Add, Text, x2 y39 w470 h310 , - /ov `t`t`t`t`tIngame Overlay an-/ausschalten`n/laufen `t`t`t`t`tLaufscript an-/ausschalten`n`nWeitere Hotkeys:`nAlt + 1: `t`t`t`t`t/staatrepair`nAlt + 2: `t`t`t`t`t/arrest`nAlt + Num7: `t`t`t`t`t/dienst`nAlt + Num9: `t`t`t`t`tWaffenspint`nAlt + K: `t`t`t`t`t/finden`n`nP: `t`t`t`t`t/flock`nJ: `t`t`t`t`t/hsirene`nY: `t`t`t`t`tBleiben Sie stehen!`nR: `t`t`t`t`tDurchsuchen`nX: `t`t`t`t`tVerhaften`n`nNumpad0: `t`t`t`t/pdgate`nAltNumpad0 `t`t`t`t/agate`nNumpad1: `t`t`t`tTimer starten`nNumpad2: `t`t`t`tTimer beenden`n`n
Gui, Add, Button, x312 y349 w160 h30 gAbord, Zurück
Gui, Show, w476 h384, Live your Dream Keybinder | Weitere Befehle
return

Save:
Reload
return

Variablen:
MsgBox, 0, Live your Dream Keybinder | Variablen, Variablen für den Live your Dream Keybinder:`n`n [Name] = Ingame Name`n [ID] = Ingame ID`n [VehName] = Fahrzeug Name`n [VehType] = Fahrzeug Typ`n`nVariablen sind derzeit nicht nutzbar!
return

Settings:
Gui, Destroy
Gui, Add, Text, x2 y-1 w460 h30 +Center, Live your Dream Keybinder Einstellungen
Gui, Add, CheckBox, x12 y39 w450 h30 vAEngine Checked%AEngine%, Automatisches Motor System
Gui, Add, CheckBox, x12 y79 w450 h30 vOV Checked%OV% , Ingame Overlay
Gui, Add, DropDownList, x322 y119 w140 h100 vOVcolor Choose%OVcolor%, Schwarz|Weiß|Grün|Blau|Rot|Gelb
Gui, Add, Text, x222 y119 w100 h20 +Right, Farbe:
Gui, Add, DropDownList, x82 y119 w140 h100 vOVsize Choose%OVsize%, 1|2|3|4|5|6|7|8|9|10|12|13|14|15|16|17|18
Gui, Add, Text, x2 y119 w80 h20 +Right, Größe:
Gui, Add, Hotkey, x12 y149 w100 h30 vTogKey, %TogKey%
Gui, Add, Text, x122 y149 w340 h30 +Left, Keybinder Aus-/Einschalten
Gui, Add, DropDownList, x12 y188 w100 h130 vrunKey Choose%runKey%, Space|Shift
Gui, Add, Text, x122 y188, Laufscript Taste
Gui, Add, Button, x352 y479 w100 h30 gSetSave, Save
Gui, Add, Button, x232 y479 w100 h30 gAbord, Abbrechen
Gui, Show, w466 h524, Live your Dream Keybinder | Settings
return

SetSave:
GuiControlGet, AEngine
IniWrite, %AEngine%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Automatic, Engine
GuiControlGet, OV
IniWrite, %OV%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Status
GuiControlGet, OVcolor
if(OVcolor == "Schwarz"){
	OVcolorVar := 1
}else if(OVcolor == "Weiß"){
	OVcolorVar := 2
}else if(OVcolor == "Grün"){
	OVcolorVar := 3
}else if(OVcolor == "Blau"){
	OVcolorVar := 4
}else if(OVcolor == "Rot"){
	OVcolorVar := 5
}else if(OVcolor == "Gelb"){
	OVcolorVar := 6
}else{
	OVcolorVar := 2
}
IniWrite, %OVcolorVar%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Color
GuiControlGet, OVsize
IniWrite, %OVsize%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Overlay.ini, Overlay Settings, Size
GuiControlGet, TogKey
IniWrite, %TogKey%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Hotkeys.ini, Others, ToggleKey
GuiControlGet, runKey
if(runKey == "Space"){
	runKey := 1
}else if(runKey == "Shift"){
	runKey := 2
}else{
	runKey := 1
}
IniWrite, %runKey%, %A_AppData%\Keybinder\LSPD_Keybinder\config\Settings.ini, Laufscript, runKey
Reload
return

Abord:
gosub, main
return

ToggleKey:
suspend
if(A_IsSuspended){
	AddChatMessage("Du hast den Keybinder ausgeschaltet!")
	SetTimer, Overlay, Off
	OVloaded := false
	TextDestroy(HPoverlay)
	;~ SetTimer, mainTimer, Off
	SetTimer, engineTimer, Off
}
if(!A_IsSuspended){
	AddChatMessage("Du hast den Keybinder eingeschaltet!")
	;~ SetTimer, mainTimer, On
	if(AEngine == 1){
		SetTimer, engineTimer, On
	}else{
		SetTimer, engineTimer, Off
	}
}
return

~F::
if(AEngine != 1){
	return
}
if(IsChatOpen() || IsDialogOpen()){
	return
}
If(IsPlayerinAnyVehicle() == 1 && IsPlayerDriver() == 1 && IsVehicleEngineEnabled() == 1){
	SendChat("/motor")
	if(IsVehicleLightEnabled() == 1){
		SendChat("/licht")
	}
}
return

~Enter::
if(AEngine != 1){
	return
}
if(IsChatOpen() || IsDialogOpen()){
	return
}
If(IsPlayerinAnyVehicle() == 1 && IsPlayerDriver() == 1 && IsVehicleEngineEnabled() == 1){
	SendChat("/motor")
	if(IsVehicleLightEnabled() == 1){
		SendChat("/licht")
	}
}
return

engineTimer:
if(getVehicleType() != 2){
	if(helm == true){
		SendChat("/helm")
		helm := false
	}
}
if(DoOnce == 0){
	OldState := isPlayerDriver()
	DoOnce := 1
}
NewState := isPlayerDriver()
if(OldState == 1 && NewState != 1){
	OldState := isPlayerDriver()
	OnPlayerExitVehicle()
}else if(OldState != 1 && NewState == 1){
	OldState := isPlayerDriver()
	OnPlayerEnterVehicle()
}
return
/*
mainTimer:
getChatLine(0, firstLine)
if(InStr(firstLine, "Sie stehen an einer Zollstation, der Zollübergang kostet $500! Befehl: /Zoll")){
	SendChat("/zollamt")
}
return
*/
:?:/ov::
if(OVloaded == false){
	SetTimer, Overlay, On
	AddChatMessage("Du hast du Overlay eingeschaltet!")
}else{
	SetTimer, Overlay, Off
	TextDestroy(HPoverlay)
	AddChatMessage("Du hast das Overlay ausgeschaltet!")
	OVloaded := false
}
return

TicketTimer:
GetChatLine(2, zeile3)
GetChatLine(1, zeile2)
GetChatLine(0, zeile1)
if(InStr(zeile1, "Exception 0xC0000005 at 0x4697C1")){
	if(crashMSG == false){
		Random, RanVar, 0, 5
		if(RanVar == 1){
			SendChat("/fc --- 1, 2, 3, 4 - Mein Spiel crasht gleich. Danke Puma! ---")
		}else if(RanVar == 2){
			SendChat("/fc --- Spiel neuinstalliert? Keybinder ausgeschaltet? Keine Mods?")
			SendChat("/fc Trotzdem crasht dein Game? Willkommen auf LyD. Danke Puma! ---")
		}else if(RanVar == 3){
			SendChat("/fc --- 'LyD ist Bugfrei! Unsere Systeme wurden ausgiebig auf Fehler getestet!'")
			SendChat("/fc sagte er als plötzlich grundlos 56.418.235.485$ aus der Staatskasse verschwanden ---")
		}else if(RanVar == 4){
			SendChat("/fc --- 'Das LyD-Script kann dein Spiel nicht zum Absturz bringen!'")
			SendChat("/fc sagte Puma, als er zum dritten mal in einer Stunde gecrasht ist ---")
		}else if(RanVar == 5){
			SendChat("/fc --- Ich rieche einen schöne Nachricht: 'Exception 0xC0000005 at 0x4697C1'")
		}
		crashMSG := true
	}
}
if(InStr(zeile1, ">> LS-Polizeibeamter Kabby hat den Verbrecher") && InStr(zeile1, "ins Alcatraz überführen können! <<")){
    RegExMatch(zeile1, "\>\> LS\-Polizeibeamter Kabby hat den Verbrecher (.*) ins Alcatraz überführen können\! \<\<", arrestAlc)
    KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
    Sleep 250
    Random, ranVar, 0, 5
    if(ranVar == 0){
        SendChat("/fc Ich habe " arrestAlc1 " ins Alcatraz verfrachten können!")
    }else if(ranVar == 1){
        SendChat("/fc " arrestAlc1 " darf nun nicht mehr die Seife fallen lassen!")
    }else if(ranVar == 2){
        SendChat("/fc " arrestAlc1 " wird neuer Schauspieler in 'Orange Is the New Black'")
    }else if(ranVar == 3){
        SendChat("/fc Im Alcatraz befindet sich nun ein neuer Gefangener!")
    }else if(ranVar == 4){
        SendChat("/fc " arrestAlc1 " wird bestimmt sehr viel Spaß im Hochsicherheitstrackt haben!")
    }else if(ranVar == 5){
        SendChat("/fc Die Justiz steht schon für " arrestAlc1 " bereit!")
    }
    Sleep 250
    KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
    return
}

if(InStr(zeile1, ">> LS-Polizeibeamter Kabby hat den Verbrecher") && InStr(zeile1, "überführen können! <<")){
    RegExMatch(zeile1, "\>\> LS\-Polizeibeamter Kabby hat den Verbrecher (.*) überführen können\! \<\<", arrestJail)
    KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
    Sleep 250
    Random, ranVar, 0, 5
    if(ranVar == 0){
        SendChat("/fc " arrestJail1 " wird sich bestimmt im Knast vergnügen!")
    }else if(ranVar == 1){
        SendChat("/fc " arrestJail1 " darf nun lange auf seinen Anwalt warten!")
    }else if(ranVar == 2){
        SendChat("/fc Ich konnt " arrestJail1 " in den Kanst abliefern!")
    }else if(ranVar == 3){
        SendChat("/fc Auch hier darf " arrestJail1 " seine Seife nicht fallen lassen!")
    }else if(ranVar == 4){
        SendChat("/fc Der Adventskalender muss wohl auf " arrestJail1 " warten!")
    }else if(ranVar == 5){
        SendChat("/fc Ich glaube " arrestJail1 " wird heute Abend nicht zum Essen erscheinen!")
    }
    Sleep 250
    KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
    return
}
GetChatLine(0, ChatLine)
if(InStr(ChatLine, "wurde von Kabby ermordet! Tatwaffe: ")){
	RegExMatch(ChatLine, "(.*) wurde von Kabby ermordet\! Tatwaffe\: (.*)", killMSG)
	KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
	Sleep 150
	SendChat("/fc Ich habe" killMSG1 " ermordet! HP: " getPlayerHealth() " AP: " getPlayerArmor())
	Random, ranVar, 1, 3
	if(ranVar == 1){
		SoundPlay, kill.mp3
	}
	if(ranVar == 2){
		SoundPlay, kill2.mp3
	}
	if(ranVar == 3){
		SoundPlay, kill3.mp3
	}
	Sleep 150
	KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
}
GetChatLine(0, ChatLine)
if(InStr(ChatLine, "Kabby wurde von") && InStr(ChatLine, "ermordet! Tatwaffe: ")){
	RegExMatch(ChatLine, "Kabby wurde von (.*) ermordet! Tatwaffe: (.*)", killedMSG)
	Sleep 250
	KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
	Sleep 150
	SendChat("/fc Ich wurde von " killedMSG1 " mit einer " killedMSG2 " ermordet!") 
	Random, ranVar, 1, 3
	if(ranVar == 1){
		SoundPlay, rip.mp3
	}
	if(ranVar == 2){
		SoundPlay, rip2.mp3
	}
	if(ranVar == 3){
		SoundPlay, rip3.mp3
	}
	sleep 150
	KMSG("-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -")
}
return

Overlay:
if(OVloaded == false){
	OVsize := 8
	1kx := 15
	1ky := 250
	HPoverlay := TextCreate("Arial", OvSize, 0, 0, 1kx, 1ky, 0xFFFFFFFF, "", true, true)
	OVloaded := true
}
if(isPlayerDriver()){
	if(IsVehicleEngineEnabled()){
		EngineStatus := "An"
	}else{
		EngineStatus := "Aus"
	}
	if(IsVehicleLightEnabled()){
		LightStatus := "An"
	}else{
		LightStats := "Aus"
	}
	if(IsVehicleLocked()){
		LockStatus := "Ja"
	}else{
		LockStatus := "Nein"
	}
	TextSetString(HPoverlay, "Name: " sampuser " (ID: " GetPlayerId() ")`nHP: " GetPlayerHealth() " AP: " GetPlayerArmor()"`n`nTimer: " chaseTime " Sekunden`n`nMotor: " EngineStatus " Licht: " LightStatus "`nLock: " LockStatus)
}else{
	TextSetString(HPoverlay, "Name: " sampuser " (ID: " GetPlayerId() ")`nHP: " GetPlayerHealth() " AP: " GetPlayerArmor()"`n`nTimer: " chaseTime " Sekunden")
}
return

;=== specific lspd functions ===

:?:/rcar::
Suspend Permit
SendChat("/fc Carrespawn in 20 Sekunden!")
Sleep 10000
SendChat("/fc Carrespawn in 10 Sekunden!")
Sleep 5000
SendChat("/fc Carrespawn in 5 Sekunden!")
Sleep 2000
SendChat("/fc Carrespawn inc 3 Sekunden!")
Sleep 1000
SendChat("/fc Carrespawn in 2 Sekunden!")
Sleep 1000
SendChat("/fc Carrespawn in 1 Sekunde!")
Sleep 1000
SendChat("/respawncars")
return

~Numpad1::
if(IsChatOpen() || IsDialogOpen()){
	return
}
KMSG("Du hast den Timer gestartet! Dieser dauert: " maxChaseTime " Sekunden!")
if(chaseTime != 0){
	chaseTime := 0
}
gosub chaseTimer
SetTimer, chaseTimer, 1000
return

~Numpad2::
if(IsChatOpen() || IsDialogOpen()){
	return
}
KMSG("Du hast den Timer beendet!")
SetTimer, chaseTimer, off
chaseTime := 0
return

chaseTimer:
if(chaseTime == maxChaseTime){
	KMSG("Der Timer jetzt ist abgelaufen!")
	SetTimer, chaseTimer, Off
	SoundBeep
	Sleep 500
	SoundBeep
	return
}
if(chaseTime == maxTaserTime){
	KMSG("Du darfst nun deinen Taser benutzen!")
	SoundBeep
}
chaseTime++
return

!Numpad7::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/dienst")
SendChat("/copman")
SendChat("/rank")
return

!Numpad9::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/waffenspint")
Sleep 100
SendInput {Enter}
Sleep 100
SendChat("/waffenspint")
Sleep 100
SendInput {Enter}
Sleep 100
SendChat("/waffenspint")
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Enter}
Sleep 100
SendChat("/waffenspint")
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Enter}
Sleep 100
SendChat("/waffenspint")
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Enter}
Sleep 100
SendChat("/waffenspint")
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Down}
Sleep 100
SendInput {Enter}
return

~Numpad5::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/pflanzeverbrennen")
return

!1::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/staatrepair")
return

!2::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendInput t/arrest{space}
return

~y::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/s > LSPD < Bleiben Sie Stehen und nehmen Sie die Hände hoch! Sonst schießen wir!")
return

~p::
if(IsChatOpen() || IsDialogOpen()){
	return
}
if(isPlayerDriver()){
	SendChat("/flock")
}
return

~j::
if(IsChatOpen() || isDialogOpen()){
	return
}
if(!isPlayerDriver()){
	return
}
SendChat("/hsirene")
return

~r::
if(IsChatOpen() || isDialogOpen()){
	return
}
if(isFriskPressed){
	SendInput t/durchsuchen{space}
	isFriskPressed := 0
	return
}
SendChat("Ich werde Sie nun auf illegale Gegenstände durchsuchen.")
isFriskPressed := 1
SetTimer, PressFriskTimeout, 10000
return

PressFriskTimeout:
if(isFriskPressed != 0){
	isFriskPressed := 0
	return
}
SetTimer, PressFriskTimeout, Off
return

~x::
if(IsChatOpen() || isDialogOpen()){
	return
}
if(isArPressed){
	SendInput t/verhaften{space}
	isArPressed := 0
	return
}
SendChat("Los Santos Police Department!")
SendChat("Sie sind verhaftet!")
isArPressed := 1
SetTimer, PressArTimeout, 10000
return

PressArTimeout:
if(isArPressed != 0){
	isArPressed := 0
	return
}
SetTimer, PressArTimeout, Off
return

~NumpadSub::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Los Santos Police Department!")
SendChat("Sie sind verhaftet!")
SendInput t/suicidearrest{space}
return

~Numpad0::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/pdgate")
return

!Numpad0::
if(IsChatOpen() || IsDialogOpen()){
	return
}
SendChat("/agate")
return

~NumpadAdd::
if(IsChatOpen() || IsDialogOpen()){
	return
}
hp:=GetPlayerHealth()
if(hp > 89){
	KMSG("Du kannst keine Kekse essen, da du über 89 HP hast!")
}
if(hp = 89 or hp = 88){
	sendChat("/isskeks")
	sleep 100
}
if(hp = 87 or hp = 86){
	sendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 100
}
if(hp = 85 or hp = 84){
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendCHat("/isskeks")
	sleep 100
}
if(hp = 83 or hp = 82){
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 100
}
if(hp = 81 or hp = 80){
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 100
}
if(hp = 79 or hp = 78){
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 100
}
if(hp < 78){
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 230
	SendChat("/isskeks")
	sleep 100
	Sleep 5400
	KMSG("Du kannst wieder Kekse essen!")
}
return

!k::
if(isFinding){
	SetTimer, findTimer, Off
	isFinding := false
	KMSG("Du hast die Suche beendet!")
}else{
	findID := PlayerInput("ID oder Name: ")
	if(findID != ""){
		gosub findTimer
		SetTimer, findTimer, 3000
		isFinding := true
		KMSG("Du suchst nun nach " findID)
	}
}
return

findTimer:
SendChat("/finden " findID)
return

~F2 & ~1::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m Achtung! Los Santos Police Department!")
return

~F2 & ~2::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m > LSPD < Halten Sie sofort an!")
return

~F2 & ~3::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m Letzte Aufforderung! Halten Sie sofort an, sonst schießen wir!")
return

~F2 & ~4::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m > LSPD < Allgemeine Verkehrskontrolle! Halten Sie sofort an!")
return

~F2 & ~5::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Los Santos Police Department!")
return

~F2 & ~6::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Haben Sie Waffen oder verbotene Gegenstände dabei?")
return

~F2 & ~7::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Ich werde Sie nun auf illegale Gegenstände durchsuchen!")
return

~F2 & ~8::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Ich werde noch Ihren Kofferraum durchsuchen. Öffnen Sie den Kofferraum mit /Kofferraum")
return

~F2 & ~9::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Den Fahrzeugschein hätte ich noch gerne gesehen (/Fahrzeugschein [ID]).")
return

~F2 & ~0::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Vielen Dank für Ihre Kooperation!")
return

~F3 & ~1::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m > LSPD < Räumen Sie sofort die Straße!")
return

~F3 & ~2::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/s > LSPD < Hände hoch! Sonst schießen wir!")
return

~F3 & ~3::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/s > LSPD < Letzte Vorwarnung! Sonst schießen wir!")
return

~F3 & ~4::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/m Das Gebäude ist umstellt!")
return

~F3 & ~5::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Steigen Sie in den Streifenwagen! Jeder Widerstand ist eine weitere Straftat!")
return

~F3 & ~6::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/s Halten Sie Abstand! Sie stören die polizeiliche Maßnahme!")
return

~F3 & ~7::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Sie sind verhaftet!")
return

~F3 & ~8::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Polizei Notruf, wie können wir Ihnen helfen?")
return

~F3 & ~9::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("/s LSPD! Stehen bleiben!")
return

~F3 & ~0::
if(IsChatOpen() || isDialogOpen()){
	return
}
SendChat("Sie haben Wanteds, durch eine Geldstrafe können Sie diese freikaufen.")
return

:?:/laufen::
if(isLaufen == true){
	isLaufen := false
	KMSG("Du hast dein Laufscript ausgeschaltet!")
}else if(isLaufen == false){
	isLaufen := true
	KMSG("Du hast dein Laufscript eingeschaltet!")
}else{
	isLaufen := true
	KMSG("Du hast dein Laufscript eingeschaltet!")
}
return

#If isLaufen && runkey == 1

~Space::
if(IsChatOpen() || isDialogOpen()){
	return
}
Loop {
If !GetKeyState("Space","P")
break
Send {Space down}
Sleep 1
Send {Space up}
Sleep 1
Send {Space down}
Sleep 5
Send {Space up}
}
return

#If isLaufen && runkey == 2

~Shift::
if(IsChatOpen() || isDialogOpen()){
	return
}
Loop {
If !GetKeyState("Shift","P")
break
Send {Shift down}
Sleep 1
Send {Shift up}
Sleep 1
Send {Shift down}
Sleep 5
Send {Shift up}
}
return