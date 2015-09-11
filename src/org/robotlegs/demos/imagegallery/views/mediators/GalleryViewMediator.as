/*
	Inversion of Control/Dependency Injection Using Robotlegs
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package org.robotlegs.demos.imagegallery.views.mediators
{
	import org.robotlegs.demos.imagegallery.events.GalleryEvent;
	import org.robotlegs.demos.imagegallery.events.GalleryImageEvent;
	import org.robotlegs.demos.imagegallery.models.vo.GalleryImage;
	import org.robotlegs.demos.imagegallery.views.components.GalleryView;
	import org.robotlegs.demos.imagegallery.events.GalleryStageEvent;
	import org.robotlegs.mvcs.Mediator;

	public class GalleryViewMediator extends Mediator
	{
		[Inject]
		public var galleryView:GalleryView;
		
		public function GalleryViewMediator()
		{
		}

		override public function onRegister():void
		{
			eventMap.mapListener( galleryView, GalleryImageEvent.SELECT_GALLERY_IMAGE, onImageSelected );
			eventMap.mapListener( galleryView, GalleryImageEvent.SET_GALLERY_IMAGE_SIZE, onSetImageSize );
			eventMap.mapListener( eventDispatcher, GalleryEvent.GALLERY_LOADED, onGalleryLoaded );
			eventMap.mapListener( eventDispatcher, GalleryEvent.GALLERY_TO_SHOW_LOADED, onGalleryToShowLoaded );
			
			eventDispatcher.dispatchEvent( new GalleryEvent( GalleryEvent.LOAD_GALLERY ) );
		}
		
		protected function selectImage(image:GalleryImage):void
		{
			galleryView.imageSource = image.URL;
			eventDispatcher.dispatchEvent(new GalleryImageEvent(GalleryImageEvent.SELECT_GALLERY_IMAGE, image));
		}
		
		protected function onGalleryLoaded(event:GalleryEvent):void
		{
			trace("onGalleryLoaded",event.gallery.photos.length);
			galleryView.dataProvider = event.gallery.photos;
			//selectImage( event.gallery.photos[0] as GalleryImage );
			eventDispatcher.dispatchEvent(new GalleryStageEvent(GalleryStageEvent.STAGE_SIZE,this.galleryView.stage.stageWidth,this.galleryView.stage.stageHeight ));
		}
		
		protected function onGalleryToShowLoaded(event:GalleryEvent):void
		{
			trace("onGalleryToShowLoaded",event.gallery.photos.length);
			galleryView.dataProvider = event.gallery.photos;
		}
		
		protected function onImageSelected(event:GalleryImageEvent):void
		{
			this.selectImage(event.image);
		}
		
		protected function onSetImageSize(event:GalleryImageEvent):void
		{
			eventDispatcher.dispatchEvent(new GalleryImageEvent(GalleryImageEvent.SET_GALLERY_IMAGE_SIZE, event.image, event.imageWidth, event.imageHeight, event.imageBitmap));
		}
	}
}