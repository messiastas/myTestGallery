package org.robotlegs.demos.imagegallery.controller
{
	import org.robotlegs.demos.imagegallery.events.GalleryStageEvent;
	import org.robotlegs.demos.imagegallery.models.GalleryModel;
	import org.robotlegs.mvcs.Command;
	
	public class SetStageSizeCommand extends Command
	{
		[Inject]
		public var event:GalleryStageEvent;
		
		[Inject]
		public var proxy:GalleryModel;
		
		override public function execute():void
		{
			if(event.stageWidth)
				proxy.setStageSize(event.stageWidth, event.stageHeight);
		}
	}
}