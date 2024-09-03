package plugins;

import flixel.system.ui.FlxSoundTray;
import flixel.FlxSprite;
import flixel.FlxG;
import openfl.utils.Assets;
import openfl.display.BitmapData;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class FunkinSoundTray extends FlxSoundTray
{
    var graphicScale:Float = 0.30;
    var lerpYPos:Float = 0;
    var alphaTarget:Float = 0;

    var volumeUpSound:FlxSound;
    var volumeDownSound:FlxSound;
    var volumeMaxSound:FlxSound;

    public function new()
    {
        super();
        removeChildren();

        var bg:FlxSprite = new FlxSprite();
        bg.loadGraphic(Paths.image("soundtray/volumebox.png"));
        bg.scale.set(graphicScale, graphicScale);

        // If `add` is not recognized, ensure this class extends a Flixel container or replace with manual addition
        add(bg); 

        y = -height;
        visible = false;

        var backingBar:FlxSprite = new FlxSprite();
        backingBar.loadGraphic(Paths.image("soundtray/bars_10.png"));
        backingBar.x = 9;
        backingBar.y = 5;
        backingBar.scale.set(graphicScale, graphicScale);
        backingBar.alpha = 0.4;
        add(backingBar);

        _bars = [];

        for (i in 1...11)
        {
            var bar:FlxSprite = new FlxSprite();
            bar.loadGraphic(Paths.image("soundtray/bars_" + i + ".png"));
            bar.x = 9;
            bar.y = 5;
            bar.scale.set(graphicScale, graphicScale);

            // Adding to `_bars` array for later reference
            add(bar);
            _bars.push(bar);
        }

        y = -height;
        screenCenter();

        // Make sure you are using `FlxG.sound.load` correctly for your Flixel version
        volumeUpSound = FlxG.sound.load(Paths.sound("soundtray/Volup"));
        volumeDownSound = FlxG.sound.load(Paths.sound("soundtray/Voldown"));
        volumeMaxSound = FlxG.sound.load(Paths.sound("soundtray/VolMAX"));

        trace("Custom tray added!");
    }

    override public function update(MS:Float):Void
    {
        // Ensure that FlxTween's easing functions are accessible and correctly used
        y = FlxTween.linear(y, lerpYPos, 0.1);
        alpha = FlxTween.linear(alpha, alphaTarget, 0.25);

        if (_timer > 0)
        {
            _timer -= (MS / 1000);
            alphaTarget = 1;
        }
        else if (y >= -height)
        {
            lerpYPos = -height - 10;
            alphaTarget = 0;
        }

        if (y <= -height)
        {
            visible = false;
            active = false;

            if (FlxG.save.bind("mySave"))
            {
                FlxG.save.data.mute = FlxG.sound.muted;
                FlxG.save.data.volume = FlxG.sound.volume;
                FlxG.save.flush();
            }
        }
    }

    override public function show(up:Bool = false):Void
    {
        _timer = 1;
        lerpYPos = 10;
        visible = true;
        active = true;
        var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

        if (FlxG.sound.muted)
        {
            globalVolume = 0;
        }

        var sound = up ? volumeUpSound : volumeDownSound;

        if (globalVolume == 10) sound = volumeMaxSound;

        if (sound != null) sound.play();

        for (i in 0..._bars.length)
        {
            _bars[i].visible = i < globalVolume;
        }
    }
}
