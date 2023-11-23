function playAnim(AnimName)
{
	if (AnimName == "singDOWN-alt")
	{
		canDance = false;

		animation.finishCallback = function(anim)
		{
			canDance = true;
		};
	}
}