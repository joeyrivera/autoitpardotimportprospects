#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Joey Rivera

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <config.au3>
#include <IE.au3>

; open browser
Local $browser = _IECreate($pardotUrl)
_IELoadWait($browser)

; login
; @todo: check if you need to login first, might already be logged in
login($browser)

; go to the import tool
_IENavigate($browser, $importUrl)
_IELoadWait($browser)

; find the form
Local $form = _IEFormGetObjByName($browser, "wizard_form")

; select the update prospect radio
_IEFormElementRadioSelect($form, "email", "prospect_import_unique_key")
Sleep(1000)

; check the box
_IEFormElementCheckBoxSelect($form, "1", "opted_in_agreement")
Sleep(1000)

; upload file
; @todo: the file might already be selected if something broke after uploading successfully buting didn't confirm/save
uploadFile()
; @todo instead of waiting 5 seconds, get creative as it could take a while to upload the file
Sleep(5000)

; summit form upload form
submitForm($form, "Next »")
Sleep(5000)

; get the new form
$form = getForm($browser, "wizard_form")

; make sure overwrite is selected
_IEFormElementCheckBoxSelect($form, "1", "field1_overwrite")
Sleep(1000)

; summit map fields form
submitForm($form, "Next »")
Sleep(5000)

; get the new form
$form = getForm($browser, "wizard_form")

; set default campaign
Local $select = _IEFormElementGetObjByName($form, "import_campaign_id")
_IEFormElementOptionSelect($select, $defaultCampaignId)

; submit select campaign and tag form
submitForm($form, "Next »")
Sleep(5000)

; get the new form
$form = getForm($browser, "wizard_form")

; select import prospects
_IEFormElementRadioSelect($form, "skip", "list_action_skip")
Sleep(1000)

; submit select action form
submitForm($form, "Next »")
Sleep(5000)

; get the new form
$form = getForm($browser, "wizard_form")

; submit confirm and save form
submitForm($form, "Confirm & Save")
Sleep(5000)

; at this point, you could take a screen shot, close the browser, or anything you'd like
;IEQuit($oIE)

; fill out the login form and submit it
Func login($browser)
	Local $form = _IEFormGetObjByName($browser, "log-in")
	Local $emailInput = _IEFormElementGetObjByName($form, "email_address")
	Local $passwordInput = _IEFormElementGetObjByName($form, "password")
	_IEFormElementSetValue($emailInput, $username)
	_IEFormElementSetValue($passwordInput, $password)
	_IEFormSubmit($form)
EndFunc

; IE controls don't work well here, need to use the os to find the window to interact with it
Func uploadFile()
	$oT = _IEFormElementGetObjByName($form, "qqfile")
	MouseMove (_IEPropertyGet ($oT, "screenx") + _IEPropertyGet ($oT, "width") - 10, _IEPropertyGet ($oT, "screeny") + _IEPropertyGet ($oT, "height") / 2)
	MouseClick ("left")
	WinWait("Choose File to Upload")
	Local $window = WinGetHandle("Choose File to Upload")
	ControlSetText($window, "", "Edit1", $fileToUpload)
	Sleep(500)
	ControlClick($window, "", "Button1")
EndFunc

Func getForm($browser, $label)
	Return _IEFormGetObjByName($browser, $label)
	Sleep(1000)
EndFunc

; loop through form elements until you find the button you need to click on
Func submitForm($form, $label)
	; summit form
	Local $inputs = _IEFormElementGetCollection($form)

	For $input in $inputs
		If String($input.value) = $label Then
			_IEAction($input, "click")
			ExitLoop
		EndIf
	Next
EndFunc

