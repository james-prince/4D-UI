//%attributes = {}
ASSERT(Compile project({\
defaultTypeForButtons: Is real; \
defaultTypeForNumerics: Is real; \
generateSymbols: True; \
generateSyntaxFile: True; \
generateTypingMethods: "reset"; \
targets: "x86_64_generic"; \
typeInference: "all"}).success || False; "Cannot compile project")

var $BinFolder:=Folder(fk database folder).folder("Bin")
If ($BinFolder.exists)
	$BinFolder.delete(Delete with contents)
End if 
ASSERT($BinFolder.create(); "Cannot create $BinFolder")

var $Component : cs.Build4D.Component:=cs.Build4D.Component.new({\
buildName: "4D-UI"; \
destinationFolder: $BinFolder; \
packedProject: True})
ASSERT($Component.build(); "Build Failed - Check $Logs")
var $Logs : Collection:=$Component.logs
TRACE