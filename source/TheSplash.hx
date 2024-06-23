//CUM
package;

import flixel.FlxG;
import flixel.FlxSprite;

class TheSplash extends FlxSprite
{
    function create() {
        frames = Paths.getSparrowAtlas('noteSplashes');
    }
}
