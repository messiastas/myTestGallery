package org.robotlegs.demos.imagegallery.controller
{
	import org.robotlegs.demos.imagegallery.events.GalleryImageEvent;
	import org.robotlegs.demos.imagegallery.models.GalleryModel;
	import org.robotlegs.mvcs.Command;
	
	public class SetSizeImageCommand extends Command
	{
		[Inject]
		public var event:GalleryImageEvent;
		
		[Inject]
		public var proxy:GalleryModel;
		
		override public function execute():void
		{
			if(event.image)
				proxy.setSizeImage(event.image, event.imageWidth, event.imageHeight, event.imageBitmap);
		}
	}
}