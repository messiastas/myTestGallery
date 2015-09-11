/*
	Inversion of Control/Dependency Injection Using Robotlegs
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package org.robotlegs.demos.imagegallery.models
{
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.demos.imagegallery.events.GalleryEvent;
	import org.robotlegs.demos.imagegallery.models.vo.Gallery;
	import org.robotlegs.demos.imagegallery.models.vo.GalleryImage;
	import org.robotlegs.mvcs.Actor;

	public class GalleryModel extends Actor
	{
		private var _gallery:Gallery;
		private var _galleryToShow:Gallery = new Gallery();
		private var checkedImages:ArrayCollection = new ArrayCollection();
		
		private var stageWidth:int = 0;
		private var stageHeight:int = 0;
		
		private var isFirstCalculate:Boolean = true;
		
		
		public function GalleryModel()
		{
			trace("Sorting arrays from low to high", ExtraTaskArraySorting(new Array(1,4,4,5,8,10,18,19,20,20),new Array(0,6,6,7,8,9)));
			trace("Sorting arrays from high to low", ExtraTaskArraySorting(new Array(20,20,18,16,12,8,5,2,2,1),new Array(12,10,10,8,7,6,5)));
			super();
		}
		
		public function ExtraTaskArraySorting(a:Array,b:Array):Array
		{
			var summ:Array = new Array();// in case we need a or b somewhere else, not touch them and create new array
			var lastBCheckedIndex:int = 0;
			var isFromLowToHigh:Boolean = a[0]<a[a.length-1] || b[0]<b[b.length-1];
			for(var i:int = 0;i<a.length;i++)
			{
				while(lastBCheckedIndex<b.length && (isFromLowToHigh == b[lastBCheckedIndex]<a[i]))
				{
					summ.push(b[lastBCheckedIndex]);
					lastBCheckedIndex++;
				}
				summ.push(a[i]);
			}
			return summ;
		}
		
		public function get gallery():Gallery
		{
			return this._gallery;
		}
		
		public function set gallery(v:Gallery):void
		{
			this._gallery = v;
			
		}
		
		public function get galleryToShow():Gallery
		{
			return this._galleryToShow;
		}
		
		public function set galleryToShow(v:Gallery):void
		{
			this._galleryToShow = v;
			
		}
		
		public function setSelectedImage(selectedImage:GalleryImage):void
		{
			if(this._gallery.photos.length>this._galleryToShow.photos.length)
			{
				for each(var image:GalleryImage in this._gallery.photos)
				{
					if(image.URL==selectedImage.URL)
					{
						image.dispose();
						this._gallery.photos.removeItemAt(this._gallery.photos.getItemIndex(image));
						break;
					}
				}
				
				calculateLayout();
			}
		}
		
		public function setStageSize(w:int, h:int):void
		{
			stageWidth = w;
			stageHeight = h;
			trace("setStageSize", w,h)
		}
		
		public function setSizeImage(loadedImage:GalleryImage, w:Number, h:Number, iB:BitmapData):void
		{
			loadedImage.imageWidth = w;
			loadedImage.imageHeight = h;
			loadedImage.imageBitmap = iB;
			var allImagesLoaded:Boolean = true;
			for each(var image:GalleryImage in this._gallery.photos)
			{
				if(image.imageWidth==0)
					allImagesLoaded = false;
			}
			if(allImagesLoaded && isFirstCalculate)
				calculateLayout();
		}
		
		protected function calculateLayout():void
		{
			trace("calculateLayout start");
			isFirstCalculate = false;
			this._galleryToShow.photos = new ArrayCollection();
			checkedImages = new ArrayCollection();
			var isPlaceFound:Boolean = true;
			while(isPlaceFound)
			{
				isPlaceFound = findPlace(findTallestImage(),"horizontal");// || findPlace(findTallestImage(),"vertical");
				//isPlaceFound = findPlace(findTallestImage(),"vertical");
			}
			isPlaceFound = true;
			while(isPlaceFound)
			{
				isPlaceFound = findPlace(findWidestImage(),"vertical");// || findPlace(findWidestImage(),"horizontal");
				//isPlaceFound = findPlace(findWidestImage(),"horizontal");				
			}
			isPlaceFound = true;
			while(isPlaceFound)
			{
				
				isPlaceFound = findPlace(findSmallHeightImage(),"horizontal");// || findPlace(findSmallHeightImage(),"vertical");
				//isPlaceFound = findPlace(findSmallHeightImage(),"vertical");
			}
			isPlaceFound = true;
			while(isPlaceFound)
			{
				isPlaceFound = findPlace(findSmallWidthImage(),"vertical");// || findPlace(findSmallWidthImage(),"horizontal");
				//isPlaceFound = findPlace(findSmallWidthImage(),"horizontal");
				
			}
			/*for each(var image:GalleryImage in this._gallery.photos)
			{
				if(!this.galleryToShow.photos.contains(image) && !this.checkedImages.contains(image))
				{
					this.checkedImages.addItem(image);
					findPlace(image,"horizontal");// findPlace(image,"vertical");
				}
			}*/
			trace("calculateLayout",this.galleryToShow.photos.length, this._gallery.photos.length);
			dispatch(new GalleryEvent(GalleryEvent.GALLERY_TO_SHOW_LOADED, this._galleryToShow));
		}
		
		private function findTallestImage():GalleryImage
		{
			var currentTallestImage:GalleryImage = null;
			for each(var image:GalleryImage in this._gallery.photos)
			{
				if(currentTallestImage==null || image.imageHeight>currentTallestImage.imageHeight)
				{
					if(!this.galleryToShow.photos.contains(image) && !this.checkedImages.contains(image))
					{
						currentTallestImage = image;
						//trace("findTallestImage", image.URL);
					}
				}
			}
			this.checkedImages.addItem(image);
			return currentTallestImage;
		}
		
		private function findWidestImage():GalleryImage
		{
			var currentWidestImage:GalleryImage = null;
			for each(var image:GalleryImage in this._gallery.photos)
			{
				if(currentWidestImage==null || image.imageWidth>currentWidestImage.imageWidth)
				{
					if(!this.galleryToShow.photos.contains(image) && !this.checkedImages.contains(image))
					{
						currentWidestImage = image;
						//trace("currentWidestImage", image.URL);
					}
				}
			}
			this.checkedImages.addItem(image);
			return currentWidestImage;
		}
		
		private function findSmallHeightImage():GalleryImage
		{
			var currentSmallHeightImage:GalleryImage = null;
			for each(var image:GalleryImage in this._gallery.photos)
			{
				if(currentSmallHeightImage==null || image.imageHeight<currentSmallHeightImage.imageHeight)
				{
					if(!this.galleryToShow.photos.contains(image) && !this.checkedImages.contains(image))
					{
						currentSmallHeightImage = image;
						//trace("findSmallHeightImageImage", image.URL);
					}
				}
			}
			this.checkedImages.addItem(image);
			return currentSmallHeightImage;
		}
		
		private function findSmallWidthImage():GalleryImage
		{
			var currentSmallWidthImage:GalleryImage = null;
			for each(var image:GalleryImage in this._gallery.photos)
			{
				if(currentSmallWidthImage==null || image.imageWidth<currentSmallWidthImage.imageWidth)
				{
					if(!this.galleryToShow.photos.contains(image) && !this.checkedImages.contains(image))
					{
						currentSmallWidthImage = image;
						//trace("currentWidestImage", image.URL);
					}
				}
			}
			this.checkedImages.addItem(image);
			return currentSmallWidthImage;
		}
		
		private function findPlace(image:GalleryImage, direction:String="horizontal"):Boolean
		{
			if(direction=="horizontal")
			{
				var firstCoord:String = "positionX";
				var secondCoord:String = "positionY";
				var firstDirect:String = "imageWidth";
				var secondDirect:String = "imageHeight";
				var stageFirstDirect:int = stageWidth;
				var stageSecondDirect:int = stageHeight;
			} else 
			{
				firstCoord = "positionY";
				secondCoord = "positionX";
				firstDirect = "imageHeight";
				secondDirect = "imageWidth";
				stageFirstDirect = stageHeight;
				stageSecondDirect = stageWidth;
			}
			var isFoundPlace:Boolean = false;
			if(image)
			{
				image[firstCoord] = 0;
				image[secondCoord] = 0;				
				while(!isFoundPlace)
				{
					if(direction=="horizontal")
					{
						var minHeight:int = findXCoord(image);
					} else 
					{
						minHeight = findYCoord(image);
					}
					if(image[firstCoord]+image[firstDirect]>stageFirstDirect)
					{
						image[firstCoord] = 0;
						image[secondCoord]+=minHeight+1;
						if(image[secondCoord]+image[secondDirect]>stageSecondDirect)
						{
							break;
						}
					} else 
					{
						if(image[secondCoord]+image[secondDirect]<=stageSecondDirect)
						{
							isFoundPlace = true;
							image.finalPositionX = image.positionX;
							image.finalPositionY = image.positionY;
							this._galleryToShow.photos.addItem(image);
						} else 
						{
							break;
						}
					}
					//trace("searchingPlace", image.URL, image.positionX, image.positionY);
				}
				//trace("foundPlace",isFoundPlace, image.URL, image.positionX, image.positionY);
			} else 
			{
				
			}
			return isFoundPlace;
		}
		
		private function findXCoord(image:GalleryImage):int 
		{
			var nextY:int = stageHeight;
			if(this._galleryToShow.photos.length>0)
			{
				for each(var storedImage:GalleryImage in this._galleryToShow.photos)
				{
					if(storedImage)
					{
						if(checkHitImagesHeight(image,storedImage) && calculateDY(image,storedImage)<nextY)
						{
							nextY=calculateDY(image,storedImage);	
						}
						//if((image.positionY>=storedImage.positionY && image.positionY<=storedImage.positionY+storedImage.imageHeight) && (image.positionX>=storedImage.positionX && image.positionX<=storedImage.positionX+storedImage.imageWidth))
						if(checkHitImagesHeight(image,storedImage) && checkHitImagesWidth(image,storedImage))
						{
							//trace("hit for", image.URL, image.positionX, image.positionY);
							image.positionX=storedImage.positionX+storedImage.imageWidth+1;
							nextY = findXCoord(image);
						} else 
						{
							nextY = 0;
						}
					}
				}
			} else 
			{
				nextY = 0;
			}
			
			return nextY;
		}
		
		private function findYCoord(image:GalleryImage):int 
		{
			var nextX:int = stageWidth;
			if(this._galleryToShow.photos.length>0)
			{
				for each(var storedImage:GalleryImage in this._galleryToShow.photos)
				{
					if(storedImage)
					{
						if(checkHitImagesWidth(image,storedImage) && calculateDX(image,storedImage)<nextX)
						{
							nextX=calculateDX(image,storedImage);	
						}
						//if((image.positionY>=storedImage.positionY && image.positionY<=storedImage.positionY+storedImage.imageHeight) && (image.positionX>=storedImage.positionX && image.positionX<=storedImage.positionX+storedImage.imageWidth))
						if(checkHitImagesHeight(image,storedImage) && checkHitImagesWidth(image,storedImage))
						{
							//trace("hit for", image.URL, image.positionX, image.positionY);
							image.positionY=storedImage.positionY+storedImage.imageHeight+1;
							nextX = findYCoord(image);
						} else 
						{
							nextX = 0;
						}
					}
				}
			} else 
			{
				nextX = 0;
			}
			
			return nextX;
		}
		
		private function checkHitImagesHeight(image:GalleryImage,storedImage:GalleryImage):Boolean
		{
			return checkHit(image.positionY,image.imageHeight,storedImage.positionY,storedImage.imageHeight);
			
		}
		
		private function checkHitImagesWidth(image:GalleryImage,storedImage:GalleryImage):Boolean
		{
			return checkHit(image.positionX,image.imageWidth,storedImage.positionX,storedImage.imageWidth);
			
		}
		
		private function checkHit(iP:int,iH:int,sP:int,sH:int):Boolean
		{
			return (iP+iH>=sP&&iP+iH<=sP+sH) ||(iP>=sP&&iP<=sP+sH) || (sP+sH>=iP&&sP+sH<=iP+iH) ||(sP>=iP&&sP<=iP+iH);
		}
		
		private function calculateDY(image:GalleryImage, storedImage:GalleryImage):int
		{
			return storedImage.positionY+storedImage.imageHeight-image.positionY;
		}
		
		private function calculateDX(image:GalleryImage, storedImage:GalleryImage):int
		{
			return storedImage.positionX+storedImage.imageWidth-image.positionX;
		}
	}
}