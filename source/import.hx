import Paths;

import states.game.PlayState;

import states.mainmenu.FreeplayState;
import states.mainmenu.StoryMenuState;
import states.mainmenu.OptionsMenu;

import objects.FunkinBar;
import objects.HealthIcon;
import objects.BackgroundGirls;
import objects.BackgroundDancer;
import objects.BGSprite;
import objects.MenuItem;
import objects.Alphabet;
import objects.Note;
import objects.DialogueBox;
import objects.Character;
import objects.MenuCharacter;

#if windows
import backend.Discord.DiscordClient;
#end
import backend.Song;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.HScript;
import backend.Controls;
import backend.ControlsSubState;
import backend.Conductor;
import backend.Highscore;
import backend.Replay;
import backend.Ratings;
import backend.EtternaFunctions;
import backend.ChartParser;
import backend.WiggleEffect;

import options.Options;
import options.PlayerSettings;

using StringTools;