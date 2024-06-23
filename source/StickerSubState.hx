package;

import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxState;

class StickerSubState extends MusicBeatSubstate {
    public var stickers:Array<FlxSprite> = [];
    var nextState:FlxState;
    var resetState:Bool = false;

    override public function new(nextState:FlxState, resetState:Bool = false) {
        super();

        this.nextState = nextState;
        this.resetState = resetState;

        for (i in 0...45) {
            placeSticker("bfSticker1");
        }
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (stickers.length >= 45) {
            if (resetState)
                FlxG.resetState();
            else
                FlxG.switchState(nextState);   
            
            PlayState.instance.transIn = FlxTransitionableState.defaultTransIn;
            PlayState.instance.transOut = FlxTransitionableState.defaultTransOut;
        }
    }

    function placeSticker(stickerName:String) {
        var sticker = new FlxSprite(FlxG.random.float(-FlxG.width, FlxG.width), FlxG.random.float(-FlxG.height, FlxG.height)).loadGraphic(Paths.image("transitionSwag/Base Game Stickers/" + stickerName));
        sticker.angle = FlxG.random.int(-60, 70);
        sticker.scrollFactor.set();
        stickers.push(sticker);
        add(sticker);
    }
}