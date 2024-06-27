package;

import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxSprite;

class NoteColorSetState extends MusicBeatState {
    var notes:Array<Note> = [];
    var curSelected:Int = 0;

    override function create() {
        super.create();

        var magenta = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.color = 0xFFfd719b;
		add(magenta);

        for (i in 0...4) {
            var note = new Note(0, i);
            note.screenCenter(Y);
            note.x = 10 + (110 * i);
            notes.push(note);
            add(note);
        }

        FlxG.mouse.enabled = true;
        FlxG.mouse.visible = true;
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.LEFT_P)
            curSelected--;
        if (controls.RIGHT_P)
            curSelected++;

        if (controls.UP_P || FlxG.mouse.overlaps(notes[curSelected]) && FlxG.mouse.justPressed) {
            var noteColor = FlxG.random.getObject([FlxColor.BLACK, FlxColor.GRAY, FlxColor.BLUE, FlxColor.RED, FlxColor.YELLOW, FlxColor.ORANGE, FlxColor.CYAN, FlxColor.LIME]);

            Note.noteColor[curSelected] = noteColor;
            notes[curSelected].color = noteColor;

            KadeEngineData.KEOptions.set("notecolors", Note.noteColor);
            FlxG.save.data.KEOptions = KadeEngineData.KEOptions;
        }

        for (i => note in notes) {
            if (FlxG.mouse.overlaps(note) && FlxG.mouse.justPressed)
                curSelected = i;

            if (note.noteData == curSelected || FlxG.mouse.overlaps(note)) {
                 note.alpha = FlxMath.lerp(1, note.alpha, 0.85);
                 note.y = FlxMath.lerp((FlxG.height / 2) - (note.height / 2) - 5, note.y, 0.85);
            } else {
                note.alpha = FlxMath.lerp(0.65, note.alpha, 0.85);
                note.y = FlxMath.lerp((FlxG.height / 2) - (note.height / 2), note.y, 0.85);
            }
        }

        if (controls.BACK)
            FlxG.switchState(new OptionsMenu());
    }
}