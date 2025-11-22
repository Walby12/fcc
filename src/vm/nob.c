#define NOB_IMPLEMENTATION
#include "nob.h"

#define SRC_FOLDER "src/"
#define BUILD_FOLDER "build/"

int main(int argc, char *argv[]) {
	NOB_GO_REBUILD_URSELF(argc, argv);

	Nob_Cmd cmd = {0};
	
	if (!nob_mkdir_if_not_exists(BUILD_FOLDER)) return 1;

	nob_cmd_append(&cmd, "cc", "-O3", "-Wall", "-Wextra", "-o", BUILD_FOLDER"fcc_vm", SRC_FOLDER"main.c", SRC_FOLDER"lexer.c");

	if (!nob_cmd_run(&cmd)) return 1;
	return 0;
}
