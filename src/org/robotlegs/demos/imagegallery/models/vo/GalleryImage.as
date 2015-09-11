/*
	Inversion of Control/Dependency Injection Using Robotlegs
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package org.robotlegs.demos.imagegallery.models.vo
{
	import flash.display.BitmapData;
	//[Bindable]
	public class GalleryImage
	{
		protected var _URL:String;
		protected var _thumbURL:String;
		protected var _selected:Boolean;
		protected var _imageWidth:Number = 0;
		protected var _imageHeight:Number = 0;
		protected var _positionX:Number = -1;
		protected var _positionY:Number = -1;
		[Bindable]
		protected var _finalPositionX:Number = -1;
		[Bindable]
		protected var _finalPositionY:Number = -1;
		protected var _imageBitmap:BitmapData = null;
		
		public function dispose():void
		{
			imageBitmap = null;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(v:Boolean):void
		{
			_selected = v;
		}

		public function get thumbURL():String
		{
			return _thumbURL;
		}

		public function set thumbURL(v:String):void
		{
			_thumbURL = v;
		}

		public function get URL():String
		{
			return _URL;
		}

		public function set URL(v:String):void
		{
			_URL = v;
		}
		
		public function get imageWidth():Number
		{
			return _imageWidth;
		}
		
		public function set imageWidth(v:Number):void
		{
			_imageWidth = v;
		}
		
		public function get imageHeight():Number
		{
			return _imageHeight;
		}
		
		public function set imageHeight(v:Number):void
		{
			_imageHeight = v;
		}
		
		public function get positionX():Number
		{
			return _positionX;
		}
		
		public function set positionX(v:Number):void
		{
			_positionX = v;
		}
		
		public function get positionY():Number
		{
			return _positionY;
		}
		
		public function set positionY(v:Number):void
		{
			_positionY = v;
		}
		
		public function get finalPositionX():Number
		{
			return _finalPositionX;
		}
		
		public function set finalPositionX(v:Number):void
		{
			_finalPositionX = v;
		}
		
		public function get finalPositionY():Number
		{
			return _finalPositionY;
		}
		
		public function set finalPositionY(v:Number):void
		{
			_finalPositionY = v;
		}
		
		public function get imageBitmap():BitmapData
		{
			return _imageBitmap;
		}
		
		public function set imageBitmap(v:BitmapData):void
		{
			_imageBitmap = v;
		}
		
		public function GetImage():*
		{
			if(imageBitmap!=null)
			{
				trace(URL, "return Bitmap")
				return imageBitmap;
			} else
			{
				trace(URL, "return url")
				return URL;
			}
				
		}

	}
}