/*
	Inversion of Control/Dependency Injection Using Robotlegs
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package  org.robotlegs.demos.imagegallery.events
{
	
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.robotlegs.demos.imagegallery.models.vo.GalleryImage;

	public class GalleryImageEvent extends Event
	{
		public static const SELECT_GALLERY_IMAGE:String = "selectGalleryImage";
		public static const SET_GALLERY_IMAGE_SIZE:String = "setGalleryImageSize";
		
		public var image:GalleryImage;
		public var imageWidth:Number;
		public var imageHeight:Number;
		public var imageBitmap:BitmapData;
		
		public function GalleryImageEvent(type:String, image:GalleryImage, w:Number=0, h:Number=0, iBitmap:BitmapData=null)
		{
			this.image = image;
			this.imageWidth = w;
			this.imageHeight = h;
			this.imageBitmap = iBitmap;
			super(type, true, true);
		}
		
		override public function clone() : Event
		{
			return new GalleryImageEvent(this.type, this.image, this.imageWidth, this.imageHeight, this.imageBitmap);
		}
	}
}