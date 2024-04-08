//%attributes = {}
var $Component : cs.Build4D.Component:=cs.Build4D.Component.new({\
buildName: "UI"; \
destinationFolder: "./Bin/"; \
packedProject: True})
ASSERT($Component.build())