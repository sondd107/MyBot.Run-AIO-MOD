
; #FUNCTION# ====================================================================================================================
; Name ..........: ClickOkay
; Description ...: checks for window with "Okay" button, and clicks it
; Syntax ........: ClickOkay($FeatureName)
; Parameters ....: $FeatureName         - [optional] String with name of feature calling. Default is "Okay".
; ...............; $bCheckOneTime       - (optional) Boolean flag - only checks for Okay button once
; Return values .: Returns True if button found, if button not found, then returns False and sets @error = 1
; Author ........: MonkeyHunter (2015-12)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2019
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func ClickOkay($FeatureName = "Okay", $bCheckOneTime = False)
	Local $i = 0
	If _Sleep($DELAYSPECIALCLICK1) Then Return False ; Wait for Okay button window
	While 1 ; Wait for window with Okay Button
		Local $offColors[3][3] = [[0x0D0D0D, 141, 0], [0xFFFFFF, 54, 19], [0xDDF783, 54, 10]] ; 2nd Black opposite button, 3rd pixel White "O" center top, 4th pixel Green "O" bottom center
		Local $ButtonPixel = _MultiPixelSearch(438, 372 + $g_iMidOffsetY, 590, 404 + $g_iMidOffsetY, 1, 1, Hex(0x2C2C2C, 6), $offColors, 20) ; first vertical black pixel of Okay
		If IsArray($ButtonPixel) Then
			If $g_bDebugSetlog Then
				SetDebugLog("ButtonPixelLocation = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_DEBUG) ;Debug
				SetDebugLog("Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 141, $ButtonPixel[1], True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 19, True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 10, True), $COLOR_DEBUG)
			EndIf
			PureClick($ButtonPixel[0] + 75, $ButtonPixel[1] + 25, 2, 50, "#0117") ; Click Okay Button
			ExitLoop
		EndIf
		If $bCheckOneTime Then Return False ; enable external control of loop count or follow on actions, return false if not clicked
		If $i > 5 Then
			SetLog("Can not find button for " & $FeatureName & ", giving up", $COLOR_ERROR)
			If $g_bDebugImageSave Then DebugImageSave($FeatureName & "_ButtonCheck_")
			SetError(1, @extended, False)
			Return
		EndIf
		$i += 1
		If _Sleep($DELAYSPECIALCLICK2) Then Return False ; improve pause button response
	WEnd
	Return True
EndFunc   ;==>ClickOkay
