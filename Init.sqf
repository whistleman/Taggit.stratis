
enableSaving [false, false];
enableSentences false;

ExecVM "briefing.sqf";

waituntil {time > 3};
ExecVM "Taggit-init.sqf";
