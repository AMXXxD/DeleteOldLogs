#include <amxmodx>

#define PLUGIN "Delete Old Logs"
#define VERSION "1.0"
#define AUTHOR "PANDA"

#define ILU_DNIOWE_PLIKI 7

new lista_folderow[][]={
	"addons/amxmodx/logs",
	"addons/amxmodx/logs/reaimdetector",
	"addons/amxmodx/logs/amx_log",
	"addons/amxmodx/logs/amx_log/amx_log_chat"
}

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	set_task(5.0, "Delete");
}

public Delete(){
	new szFile[32], systime=get_systime(), sciezka[128], dirHandle, FileType:type, left=ILU_DNIOWE_PLIKI*86400;
	for(new i=0;i<sizeof(lista_folderow);i++){
		dirHandle=open_dir(lista_folderow[i], szFile, 31, type);
		if(!strlen(szFile) || type!=FileType_File) continue;
		formatex(sciezka, 127, "%s/%s", lista_folderow[i], szFile);
		if(systime-GetFileTime(sciezka, FileTimeType:FileTime_LastChange)>left) delete_file(sciezka);
		for(new x=0;next_file(dirHandle, szFile, 31, type);x++){
			if(!strlen(szFile) || type!=FileType_File) continue;
			formatex(sciezka, 127, "%s/%s", lista_folderow[i], szFile);
			if(systime-GetFileTime(sciezka, FileTimeType:FileTime_LastChange)>left) delete_file(sciezka);
		}
	}
}
