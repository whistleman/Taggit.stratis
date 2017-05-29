class Default
{
	title = ""; // Tile displayed as text on black background. Filled by arguments.
	iconPicture = ""; // Small icon displayed in left part. Colored by "color", filled by arguments.
	iconText = ""; // Short text displayed over the icon. Colored by "color", filled by arguments.
	description = ""; // Brief description displayed as structured text. Colored by "color", filled by arguments.
	color[] = {1,1,1,1}; // Icon and text color
	duration = 5; // How many seconds will the notification be displayed
	priority = 0; // Priority; higher number = more important; tasks in queue are selected by priority
	difficulty[] = {}; // Required difficulty settings. All listed difficulties has to be enabled
};
class NewTagger {
	title = "%2 is it!";
	iconText = ":-)";
	description = "%1";
	priority = 0;
};
class FistTagger {
    	title = "%2 is it!";
    	iconText = ":-)";
    	description = "%1";
    	priority = 0;
};
class Run {
    	title = "Run!";
    	iconText = ":-)";
    	description = "%1";
    	priority = 0;
};
class ScoreAdded
{
	title = "Score bonus";
	iconText = "+%2";
	description = "%1";
	color[] = {0.5,1,1,1};
	priority = 0;
	difficulty[] = {"netStats"};
};
