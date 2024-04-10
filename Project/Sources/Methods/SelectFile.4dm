//%attributes = {"shared":true}
#DECLARE($saveNewFile : Boolean; \
$fileExtension : Text; \
$defaultDirectory : Text; \
$dialogTitle : Text) : 4D.File

$saveNewFile:=Count parameters>=1 ? $saveNewFile : False
$fileExtension:=Count parameters>=2 ? $fileExtension : "*"
$defaultDirectory:=Count parameters>=3 ? $defaultDirectory : ""
$dialogTitle:=Count parameters>=4 ? $dialogTitle : \
($saveNewFile ? "Enter a file name" : "Select a file")

ARRAY TEXT($selectedPlatformPaths; 0)
var $fileName : Text
$fileName:=Select document($defaultDirectory; $fileExtension; $dialogTitle; \
($saveNewFile ? File name entry : 0)\
; $selectedPlatformPaths)

return (OK=1) && (Size of array($selectedPlatformPaths)>=1) ? \
File($selectedPlatformPaths{1}; fk platform path) : Null