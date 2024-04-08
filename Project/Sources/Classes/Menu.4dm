property _MenuItems : Collection
property _MenuReference : Text
property _SubMenu : Boolean
property _SubMenuText : Text

property _MenuItemCollection : Collection

property Cancelled : Boolean

Class constructor($BasicMenuItems : Collection)
	This._MenuItems:=[]
	
	var $MenuItemText : Text
	For each ($MenuItemText; $BasicMenuItems || [])
		This.addVariantItem($MenuItemText; This._MenuItems.length+1)
	End for each 
	
Function addSeperator()->$MenuItem : cs.MenuItem
	If (This._MenuItems.length=0)
		return 
	End if 
	$MenuItem:=cs._MenuItem.new()
	$MenuItem._IsSeperator:=True
	This._MenuItems.push($MenuItem)
	
Function addVariantItem($MenuText : Text; $Variant : Variant)->$MenuItem : cs.MenuItem
	$MenuItem:=cs._MenuItem.new($MenuText)
	$MenuItem._IsVariantItem:=True
	$MenuItem._Variant:=$Variant
	This._MenuItems.push($MenuItem)
	
Function addFormulaItem($MenuText : Text; $FormulaOrFormulaSet : Variant)->$MenuItem : cs.MenuItem
	//VariantTypeCheck($FormulaOrFormulaSet; []; [4D.Function; cs.FormulaSet])
	$MenuItem:=cs._MenuItem.new($MenuText)
	$MenuItem._IsFormulaItem:=True
	$MenuItem._Formula:=$FormulaOrFormulaSet
	This._MenuItems.push($MenuItem)
	
Function addSubMenu($SubMenuText : Text)->$Menu : cs.Menu
	$Menu:=cs.Menu.new()
	$Menu._SubMenu:=True
	$Menu._SubMenuText:=$SubMenuText
	This._MenuItems.push($Menu)
	
	
Function show()->$FormulaResult : Variant
	This._addMenuItems()
	var $SelectedMenuUUID:=Dynamic pop up menu(This._MenuReference)
	This._release()
	
	var $MenuItem : cs.MenuItem:=This._MenuItemCollection.query("_UUID#'' && _UUID=:1"; $SelectedMenuUUID).first()
	This.Cancelled:=($MenuItem=Null)
	If (This.Cancelled)
		return Null
	End if 
	return $MenuItem._process()
	
	
	
	
Function _addMenuItems($ParentMenuReference : Text)
	This._MenuReference:=Create menu
	This._MenuItemCollection:=[]
	If (This._SubMenu=True)
		APPEND MENU ITEM($ParentMenuReference; This._SubMenuText; This._MenuReference)
	End if 
	
	var $MenuItemVariant : Variant
	For each ($MenuItemVariant; This._MenuItems)
		//VariantTypeCheck($MenuItem; []; [cs.Menu; cs.MenuItem])
		
		Case of 
			: (OB Instance of($MenuItemVariant; cs.Menu))
				var $Menu : cs.Menu:=$MenuItemVariant
				$Menu._addMenuItems(This._MenuReference)
				This._MenuItemCollection.combine($Menu._MenuItemCollection)
				
			: (OB Instance of($MenuItemVariant; cs.MenuItem))
				var $MenuItem : cs.MenuItem:=$MenuItemVariant
				$MenuItem._addMenuItem(This._MenuReference)
				This._MenuItemCollection.push($MenuItem)
				
		End case 
	End for each 
	
	
Function _release()
	var $MenuItem : Variant
	For each ($MenuItem; This._MenuItems)
		If (OB Instance of($MenuItem; cs.Menu))
			$MenuItem._release()
		End if 
	End for each 
	RELEASE MENU(This._MenuReference)