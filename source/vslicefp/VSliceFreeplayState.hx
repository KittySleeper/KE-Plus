package vslicefp;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup;
import shaders.AngleMask;
import shaders.StrokeShader;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class VSliceFreeplayState extends MusicBeatState
{
    //final currentCharacter:String;
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	var bg:FlxSprite;

    //var dj:DJBoyfriend;
	var ostName:FlxText;
	var bgDad:FlxSprite;
	var rankBg:FlxSprite;
	var fp:FreeplayScore;
	var txtCompletion:AtlasText;
	var letterSort:LetterSort;
	var exitMovers:ExitMoverData = new Map();
	public var orangeBackShit:FlxSprite;
	public var alsoOrangeLOL:FlxSprite;
	public var pinkBack:FlxSprite;
	public var moreWays:BGScrollingText;
	public var funnyScroll:BGScrollingText;
	public var txtNuts:BGScrollingText;
	public var funnyScroll2:BGScrollingText;
	public var moreWays2:BGScrollingText;
	public var funnyScroll3:BGScrollingText;

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		songs.push(new SongMetadata("Random", "face", "0", ["null"]));

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new SongMetadata(data[0], data[2], data[1], data[3].split("|")));
		}

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		pinkBack = new FlxSprite(0, 0, Paths.image('freeplay/pinkBack'));
		pinkBack.color = 0xFFFFD4E9; // sets it to pink!
		pinkBack.x -= pinkBack.width;
		add(pinkBack);
		FlxTween.tween(pinkBack, {x: 0}, 0.6, {ease: FlxEase.quartOut});
		

		// Create the first orangeBackShit sprite
		var orangeBackShit = new FlxSprite(84, 440);
		orangeBackShit.makeGraphic(Std.int(pinkBack.width), 75, FlxColor.WHITE); // Set the size and fill with white color
		orangeBackShit.color = 0xFFFEDA00; // Apply the color
		add(orangeBackShit);

		// Create the alsoOrangeLOL sprite
		var alsoOrangeLOL = new FlxSprite(0, orangeBackShit.y);
		alsoOrangeLOL.makeGraphic(100, Std.int(orangeBackShit.height), FlxColor.WHITE); // Set the size and fill with white color
		alsoOrangeLOL.color = 0xFFFFD400; // Apply the color
		add(alsoOrangeLOL);

		exitMovers.set([pinkBack, orangeBackShit, alsoOrangeLOL], {
			x: -pinkBack.width,
			y: pinkBack.y,
			speed: 0.4,
			wait: 0
		});

		var grpTxtScrolls:FlxGroup = new FlxGroup();
		add(grpTxtScrolls);
		grpTxtScrolls.visible = false;

		moreWays = new BGScrollingText(0, 160, 'HOT BLOODED IN MORE WAYS THAN ONE', FlxG.width, true, 43);
		moreWays.funnyColor = 0xFFFFF383;
		moreWays.speed = 6.8;
		grpTxtScrolls.add(moreWays);

		exitMovers.set([moreWays], {
			x: FlxG.width * 2,
			speed: 0.4,
		});

		funnyScroll = new BGScrollingText(0, 220, 'BOYFRIEND', FlxG.width / 2, false, 60);
		funnyScroll.funnyColor = 0xFFFF9963;
		funnyScroll.speed = -3.8;
		grpTxtScrolls.add(funnyScroll);

		exitMovers.set([funnyScroll], {
			x: -funnyScroll.width * 2,
			y: funnyScroll.y,
			speed: 0.4,
			wait: 0
		});

		txtNuts = new BGScrollingText(0, 285, 'PROTECT YO NUTS', FlxG.width / 2, true, 43);
		txtNuts.speed = 3.5;
		grpTxtScrolls.add(txtNuts);
		exitMovers.set([txtNuts], {
			x: FlxG.width * 2,
			speed: 0.4,
		});

		funnyScroll2 = new BGScrollingText(0, 335, 'BOYFRIEND', FlxG.width / 2, false, 60);
		funnyScroll2.funnyColor = 0xFFFF9963;
		funnyScroll2.speed = -3.8;
		grpTxtScrolls.add(funnyScroll2);

		exitMovers.set([funnyScroll2], {
			x: -funnyScroll2.width * 2,
			speed: 0.5,
		});

		moreWays2 = new BGScrollingText(0, 397, 'HOT BLOODED IN MORE WAYS THAN ONE', FlxG.width, true, 43);
		moreWays2.funnyColor = 0xFFFFF383;
		moreWays2.speed = 6.8;
		grpTxtScrolls.add(moreWays2);

		exitMovers.set([moreWays2], {
			x: FlxG.width * 2,
			speed: 0.4
		});

		funnyScroll3 = new BGScrollingText(0, orangeBackShit.y + 10, 'BOYFRIEND', FlxG.width / 2, 60);
		funnyScroll3.funnyColor = 0xFFFEA400;
		funnyScroll3.speed = -3.8;
		grpTxtScrolls.add(funnyScroll3);

		exitMovers.set([funnyScroll3], {
			x: -funnyScroll3.width * 2,
			speed: 0.3
		});

        /*dj = new DJBoyfriend(640, 366);
        exitMovers.set([dj],
          {
            x: -dj.width * 1.6,
            speed: 0.5
          });
    
        // TODO: Replace this.
        if (currentCharacter == 'pico') dj.visible = false;
    
        add(dj);*/

		bgDad = new FlxSprite(pinkBack.width * 0.74, 0).loadGraphic(Paths.image('freeplay/freeplayBGdad'));
		bgDad.shader = new AngleMask();
		bgDad.visible = false;

		var blackOverlayBullshitLOLXD:FlxSprite = new FlxSprite(FlxG.width,0,Paths.image("back"));
		blackOverlayBullshitLOLXD.alpha = 1;
		add(blackOverlayBullshitLOLXD); // used to mask the text lol!
		
		// this makes the texture sizes consistent, for the angle shader
		bgDad.setGraphicSize(0, FlxG.height);
		blackOverlayBullshitLOLXD.setGraphicSize(0, FlxG.height);

		bgDad.updateHitbox();
		blackOverlayBullshitLOLXD.updateHitbox();

		exitMovers.set([blackOverlayBullshitLOLXD, bgDad], {
			x: FlxG.width * 1.5,
			speed: 0.4,
			wait: 0
		});
		
		add(bgDad);
		FlxTween.tween(blackOverlayBullshitLOLXD, {x: (pinkBack.width * 0.74)-37}, 0.7, {ease: FlxEase.quintOut});

		blackOverlayBullshitLOLXD.shader = bgDad.shader;

		/*var rankBg:FlxSprite = new FlxSprite();
		rankBg.makeGraphic(FlxG.width, FlxG.height, 0xD3000000);
		add(rankBg);*/

		var overhangStuff:FlxSprite = new FlxSprite();
		overhangStuff.makeGraphic(FlxG.width, 64, FlxColor.BLACK);
		overhangStuff.y -= overhangStuff.height;
		add(overhangStuff);
		FlxTween.tween(overhangStuff, {y: 0}, 0.3, {ease: FlxEase.quartOut});

		var fnfFreeplay:FlxText = new FlxText(8, 8, 0, 'FREEPLAY', 48);
		fnfFreeplay.font = 'VCR OSD Mono';
		fnfFreeplay.visible = false;

		ostName = new FlxText(8, 8, FlxG.width - 8 - 8, 'OFFICIAL OST', 48);
		ostName.font = 'VCR OSD Mono';
		ostName.alignment = RIGHT;
		ostName.visible = false;

		exitMovers.set([overhangStuff, fnfFreeplay, ostName], {
			y: -overhangStuff.height,
			x: 0,
			speed: 0.2,
			wait: 0
		});

		var sillyStroke:StrokeShader = new StrokeShader(0xFFFFFFFF, 2, 2);
		fnfFreeplay.shader = sillyStroke;
		ostName.shader = sillyStroke;
		add(fnfFreeplay);
		add(ostName);

		var fnfHighscoreSpr:FlxSprite = new FlxSprite(860, 70);
		fnfHighscoreSpr.frames = Paths.getSparrowAtlas('freeplay/highscore');
		fnfHighscoreSpr.animation.addByPrefix('highscore', 'highscore small instance 1', 24, false);
		fnfHighscoreSpr.visible = false;
		fnfHighscoreSpr.setGraphicSize(0, Std.int(fnfHighscoreSpr.height * 1));
		fnfHighscoreSpr.updateHitbox();
		add(fnfHighscoreSpr);

		new FlxTimer().start(FlxG.random.float(12, 50), function(tmr)
		{
			fnfHighscoreSpr.animation.play('highscore');
			tmr.time = FlxG.random.float(20, 60);
		}, 0);

		fp = new FreeplayScore(460, 60, 7, 100);
		fp.visible = false;
		add(fp);

		var clearBoxSprite:FlxSprite = new FlxSprite(1165, 65).loadGraphic(Paths.image('freeplay/clearBox'));
		clearBoxSprite.visible = false;
		add(clearBoxSprite);
		
		
		txtCompletion = new AtlasText(1185, 87, '69', AtlasFont.FREEPLAY_CLEAR);
		txtCompletion.visible = false;
		add(txtCompletion);

		letterSort = new LetterSort(400, 75);
		add(letterSort);
		letterSort.visible = false;

		exitMovers.set([letterSort], {
			y: -100,
			speed: 0.3
		});

		letterSort.changeSelectionCallback = (str) ->
		{
			switch (str)
			{
				case 'fav':
					generateSongList({filterType: FAVORITE}, true);
				case 'ALL':
					generateSongList(null, true);
				case '#':
					generateSongList({filterType: REGEXP, filterData: '0-9'}, true);
				default:
					generateSongList({filterType: REGEXP, filterData: str}, true);
			}

			// We want to land on the first song of the group, rather than random song when changing letter sorts
			// that is, only if there's more than one song in the group!
			if (grpCapsules.members.length > 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				curSelected = 1;
				changeSelection();
			}
		};

		exitMovers.set([fp, txtCompletion, fnfHighscoreSpr, txtCompletion, clearBoxSprite], {
			x: FlxG.width,
			speed: 0.3
		});

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			//FlxG.sound.playMusic(Paths.inst(songs[i].songName), 0.1); // preload
			
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false, true);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			// using a FlxGroup is too much fuss!

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxTween.color(pinkBack, 0.25, pinkBack.color, 0xFFFFD0D5, {ease: FlxEase.quadOut});
			orangeBackShit.visible = false;
			alsoOrangeLOL.visible = false;
			moreWays.visible = false;
			funnyScroll.visible = false;
			txtNuts.visible = false;
			funnyScroll2.visible = false;
			moreWays2.visible = false;
			funnyScroll3.visible = false;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			// pre lowercasing the song name (update)
			var songLowercase = StringTools.replace(songs[curSelected].songName, " ", "-").toLowerCase();
			// adjusting the highscore song name to be compatible (update)
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
			
			trace(songLowercase);

			var poop:String = Highscore.formatSong(songHighscore, songs[curSelected].difficultys[curDifficulty]);

			trace(poop);
			
			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = songs[curSelected].difficultys[curDifficulty];
			PlayState.storyWeek = songs[curSelected].week;
			trace('CUR WEEK' + PlayState.storyWeek);
			LoadingState.loadAndSwitchState(new PlayState());
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = songs[curSelected].difficultys.length - 1;
		if (curDifficulty > songs[curSelected].difficultys.length - 1)
			curDifficulty = 0;

		// adjusting the highscore song name to be compatible (changeDiff)
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		
		#if !switch
		intendedScore = Highscore.getScore(songHighscore, songs[curSelected].difficultys[curDifficulty]);
		#end

		diffText.text = songs[curSelected].difficultys[curDifficulty].toUpperCase();
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		changeDiff();

		// selector.y = (70 * curSelected) + 30;
		
		// adjusting the highscore song name to be compatible (changeSelection)
		// would read original scores if we didn't change packages
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");

		#if !switch
		intendedScore = Highscore.getScore(songHighscore, songs[curSelected].difficultys[curDifficulty]);
		// lerpScore = 0;
		#end
		if (songs[curSelected].songName == 'random')
			FlxG.sound.playMusic(Paths.music('freeplayRandom/freeplayRandom'), 0);
		else
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

/**
 * The map storing information about the exit movers.
 */
 typedef ExitMoverData = Map<Array<FlxSprite>, MoveData>;

 /**
  * The data for an exit mover.
  */
typedef MoveData =
{
	var ?x:Float;
	var ?y:Float;
	var ?speed:Float;
	var ?wait:Float;
}

class SongMetadata
{
	public var songName:String = "";
	public var week:String = "0";
	public var songCharacter:String = "";
	public var difficultys:Array<String> = [];

	public function new(song:String, week:String, songCharacter:String, songDifficultys:Array<String>)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.difficultys = songDifficultys;
	}
}