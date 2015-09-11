package org.robotlegs.demos.imagegallery.test.cases
{
	import org.flexunit.Assert;
	import org.robotlegs.demos.imagegallery.models.GalleryModel;
	import org.robotlegs.demos.imagegallery.models.vo.Gallery;
	import org.robotlegs.demos.imagegallery.models.vo.GalleryImage;

	public class TestGalleryModel
	{
		private var galleryModel:GalleryModel;
		
		[Before]
		public function setUp():void
		{
			this.galleryModel = new GalleryModel()
		}
		
		[After]
		public function tearDown():void
		{
			this.galleryModel = null;
		}
		
		[Test]
		public function testSetGallery():void
		{
			var gallery:Gallery = new Gallery();
			this.galleryModel.gallery = gallery;
			Assert.assertEquals("galleryModel should have a gallery", 
				this.galleryModel.gallery != null, true );
		}
		
		[Test]
		public function testSetLayout():void
		{
			var image1:GalleryImage = new GalleryImage()
			var image2:GalleryImage = new GalleryImage()
			image1.imageWidth = 50;
			image1.imageHeight = 100;
			image2.imageWidth = 100;
			image2.imageHeight = 50;
			var gallery:Gallery = new Gallery()
			this.galleryModel.gallery = gallery;
			gallery.photos.addItem(image1);
			gallery.photos.addItem(image2);
			this.galleryModel.calculateLayout()();
			Assert.assertEquals("Image1 position should be >=0", image1.positionX>=0, true);
			Assert.assertEquals("Image1 position should be >=0", image2.positionX>=0, true);
		}
	}
}