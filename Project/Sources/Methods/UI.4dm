//%attributes = {"shared":true,"preemptive":"capable"}
#DECLARE() : cs._UI

If (Process_UIClassObject=Null)
	Process_UIClassObject:=cs._UI.new()
End if 
return Process_UIClassObject