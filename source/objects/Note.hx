package objects;

import openfl.Assets;
import haxe.Json;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

using StringTools;

typedef NoteTypeAnimHandler =
{
	var leftNoteAnim:String;
	var upNoteAnim:String;
	var downNoteAnim:String;
	var rightNoteAnim:String;

	var susLeftNoteAnim:String;
	var susUpNoteAnim:String;
	var susDownNoteAnim:String;
	var susRightNoteAnim:String;

	var susEndLeftNoteAnim:String;
	var susEndUpNoteAnim:String;
	var susEndDownNoteAnim:String;
	var susEndRightNoteAnim:String;
}

typedef NoteTypeHandler =
{
	var image:String;
	var flipX:Bool;
	var cpuCanHit:Bool;
	var hurtWhenMiss:Bool;
	var hurtWhenHit:Bool;
	var autoDelete:Bool;
	var playCharacterAnim:Bool;
	var anims:NoteTypeAnimHandler;
}

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteType:String = "";

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var rating:String = "shit";

	public var cpuCanHit:Bool = true;
	public var hurtWhenMiss:Bool = true;
	public var hurtWhenHit:Bool = false;
	public var autoDelete:Bool = true;
	public var playCharacterAnim:Bool = true;

	public var script:HScript;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:String = "default")
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.noteType = noteType;
		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;

		if (this.strumTime < 0)
			this.strumTime = 0;

		this.noteData = noteData;

		var daStage:String = PlayState.curStage;

		script = new HScript('assets/data/notes/$noteType');

		if (!script.isBlank && script.expr != null)
		{
			script.interp.scriptObject = this;
			script.setValue("note", this);
			script.interp.execute(script.expr);
		}

		switch (daStage)
		{
			case 'school' | 'schoolEvil':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				frames = Paths.getSparrowAtlas('NOTE_assets');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
		}

		switch (noteData)
		{
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}
		if (FlxG.save.data.downscroll && sustainNote)
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * FlxG.save.data.scrollSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}

		var note:NoteTypeHandler = null;
		if (Assets.exists(Paths.json('notes/$noteType')))
			note = Json.parse(Assets.getText(Paths.json('notes/$noteType')));

		if (note != null)
		{
			frames = Paths.getSparrowAtlas(note.image);
			if (note.flipX != true && note.flipX != false)
				note.flipX = false;
			if (note.cpuCanHit != true && note.cpuCanHit != false)
				note.cpuCanHit = false;
			if (note.autoDelete != true && note.autoDelete != false)
				note.autoDelete = true;
			if (note.hurtWhenHit != true && note.hurtWhenHit != false)
				note.hurtWhenHit = false;
			if (note.hurtWhenMiss != true && note.hurtWhenMiss != false)
				hurtWhenMiss = true;

			flipX = note.flipX;
			cpuCanHit = note.cpuCanHit;
			hurtWhenMiss = note.hurtWhenMiss;
			hurtWhenHit = note.hurtWhenHit;
			autoDelete = note.autoDelete;

			var anims = ["left", "down", "up", "right"];
			var noteAnims = [
				note.anims.leftNoteAnim,
				note.anims.downNoteAnim,
				note.anims.upNoteAnim,
				note.anims.rightNoteAnim
			];
			var susNoteAnims = [
				note.anims.susLeftNoteAnim,
				note.anims.susDownNoteAnim,
				note.anims.susUpNoteAnim,
				note.anims.susRightNoteAnim
			];
			var susEndNoteAnims = [
				note.anims.susEndLeftNoteAnim,
				note.anims.susEndDownNoteAnim,
				note.anims.susEndUpNoteAnim,
				note.anims.susEndRightNoteAnim
			];

			if (!isSustainNote)
			{
				animation.addByPrefix(anims[noteData], noteAnims[noteData]);
				animation.play(anims[noteData]);
			}
			else
			{
				animation.addByPrefix(anims[noteData], susNoteAnims[noteData]);
				animation.play(anims[noteData]);

				if (prevNote != null)
				{
					animation.addByPrefix(anims[noteData] + "end", susEndNoteAnims[noteData]);
					animation.play(anims[noteData] + "end");
				}
			}
		}

		script.callFunction("create");
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (ID < 0 || noteData < 0)
			kill();

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}

		script.callFunction("update", [elapsed]);
	}

	public function bfNoteHit(character:Character)
	{
		if (playCharacterAnim && !hurtWhenHit)
		{
			switch (noteData)
			{
				case 0:
					character.playAnim('singLEFT', true);
				case 2:
					character.playAnim('singUP', true);
				case 1:
					character.playAnim('singDOWN', true);
				case 3:
					character.playAnim('singRIGHT', true);	
			}
		}

		#if sys
		var daNote = this;

		script.callFunction("bfNoteHit", [character, daNote]);
		#end
	}

	public function dadNoteHit(character:Character) {
		#if sys
		var daNote = this;

		script.callFunction("dadNoteHit", [character, daNote]);
		#end
	}
}
