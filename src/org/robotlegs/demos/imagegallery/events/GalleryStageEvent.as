package org.robotlegs.demos.imagegallery.events
{
	import flash.events.Event;
	
	public class GalleryStageEvent extends Event
	{
		public static const STAGE_SIZE:String = "stageSize";
		public var stageWidth:int;
		public var stageHeight:int;
		
		public function GalleryStageEvent(type:String, stageWidth:int, stageHeight:int)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			super(type, true, true);
		}
		
		override public function clone() : Event
		{
			return new GalleryStageEvent(this.type, this.stageWidth, this.stageHeight);
		}
	}
}