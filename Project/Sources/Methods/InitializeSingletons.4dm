//%attributes = {}
Use (Storage)
	Storage.Singletons:=New shared object
End use 

Use (Storage.Singletons)
	Storage.Singletons.Color:=OB Copy(cs.Color.new(); ck shared)
End use 