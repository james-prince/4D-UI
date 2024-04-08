//%attributes = {}
var $Component : cs.Build4D.Component:=cs.Build4D.Component.new({\
buildName: "Menus"; \
destinationFolder: "./Bin/"; \
packedProject: True})
ASSERT($Component.build())

//var $StructureFolder : 4D.Folder:=$Component._structureFolder
//var $DestinationFolder:=Folder("C:\\Users\\jprince\\source\\repos\\synthotec\\SynthoTec-4D\\Components"; fk platform path)
//$StructureFolder.copyTo($DestinationFolder; $StructureFolder.fullName; fk overwrite)


cs.Ui.Menu.new()
cs.UI.Menu.new()
cs.Interface.Menu.new()