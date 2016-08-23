state("Mandagon"){
	int runesCollected : "mono.dll", 0x002635C0, 0x98, 0x370, 0x38;
	int loading : "Mandagon.exe", 0x12A5B20;
	int roomID : "Mandagon.exe", 0x0125B5D8, 0x158, 0x10, 0x7e0, 0x4d0, 0x0;
	int blueGuy : "Mandagon.exe", 0x012A80A0, 0x3e0, 0x48, 0x8, 0x4b0, 0x138;
}

init{
	vars.runeCount = current.runesCollected;
}

startup{
	settings.Add("settings", true, "Settings:");
	settings.Add("autoSplit", true, "Auto-Split?", "settings");
	
	settings.Add("categories", true, "Categories: (Only Select One Please!)");
	settings.Add("anyPercent", true, "Any%?", "categories");
	settings.Add("1tablet", false, "1 Tablet?", "categories");
	settings.Add("2tablet", false, "2 Tablets?", "categories");
	settings.Add("3tablet", false, "3 Tablets?", "categories");
	
}

split{
	if (settings["autoSplit"]){
		if (old.runesCollected + 1 == current.runesCollected){
			if (current.runesCollected != current.runeCount){
				current.runeCount = current.runesCollected;
				return true;
			}
		}
		
		if (old.blueGuy + 1 == current.blueGuy){
			return true;
		}
		
		if (settings["1tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 1);
			}
		}
		
		if (settings["2tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 2);
			}
		}
		
		if (settings["3tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 3);
			}
		}
	}
	
	return false;
}

reset{
	return (old.roomID - 1 == current.roomID && current.roomID == 2);
}

isLoading{
	return (current.loading != 0);
}

start{
	if (timer.CurrentPhase == TimerPhase.NotRunning){
		current.runeCount = current.runesCollected;
	}
	
	return (old.roomID + 1 == current.roomID);
}