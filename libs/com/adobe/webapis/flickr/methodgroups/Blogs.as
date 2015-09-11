/*
	Copyright (c) 2008, Adobe Systems Incorporated
	All rights reserved.

	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    	this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    	this list of conditions and the following disclaimer in the 
    	documentation and/or other materials provided with the distribution.
    * Neither the name of Adobe Systems Incorporated nor the names of its 
    	contributors may be used to endorse or promote products derived from 
    	this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.webapis.flickr.methodgroups {
	
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.adobe.webapis.flickr.*;
	import flash.events.Event;
	import flash.net.URLLoader;
	
		/**
		 * Broadcast as a result of the getList method being called
		 *
		 * The event contains the following properties
		 *	success	- Boolean indicating if the call was successful or not
		 *	data - When success is true, contains a "blogs" array of Blog instances
		 *		   When success is false, contains an "error" FlickrError instance
		 *
		 * @see #getList
		 * @see com.adobe.service.flickr.FlickrError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		[Event(name="blogsGetList", 
			 type="com.adobe.webapis.flickr.events.FlickrResultEvent")]
			 
		/**
		 * Broadcast as a result of the postPhoto method being called
		 *
		 * The event contains the following properties
		 *	success	- Boolean indicating if the call was successful or not
		 *	data - When success is true, an empty object
		 *		   When success is false, contains an "error" FlickrError instance
		 *
		 * @see #postPhoto
		 * @see com.adobe.service.flickr.FlickrError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		[Event(name="blogsPostPhoto", 
			 type="com.adobe.webapis.flickr.events.FlickrResultEvent")]	
	
	/**
	 * Contains the methods for the Blogs method group in the Flickr API.
	 * 
	 * Even though the events are listed here, they're really broadcast
	 * from the FlickrService instance itself to make using the service
	 * easier.
	 */
	public class Blogs {
			 
		/** 
		 * A reference to the FlickrService that contains the api key
		 * and logic for processing API calls/responses
		 */
		private var _service:FlickrService;
	
		/**
		 * Construct a new Blogs "method group" class
		 *
		 * @param service The FlickrService this method group
		 *		is associated with.
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function Blogs( service:FlickrService ) {
			_service = service;
		}
	
		/**
		 * Get a list of configured blogs for the calling user.
		 *
		 * This method requires authentication with READ permission.
		 *
		 * @see http://www.flickr.com/services/api/flickr.blogs.getList.html
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getList( ):void {
			// Let the Helper do the work to invoke the method
			MethodGroupHelper.invokeMethod( _service, getList_result, "flickr.blogs.getList", false );
		}
		
		/**
		 * Capture the result of the getList call, and dispatch
		 * the event to anyone listening.
		 *
		 * @param event The complete event generated by the URLLoader
		 * 			that was used to communicate with the Flickr API
		 *			from the invokeMethod method in MethodGroupHelper
		 */
		private function getList_result( event:Event ):void {
			// Create a BLOGS_GET_LIST event
			var result:FlickrResultEvent = new FlickrResultEvent( FlickrResultEvent.BLOGS_GET_LIST );

			// Have the Helper handle parsing the result from the server - get the data
			// from the URLLoader which correspondes to the result from the API call
			MethodGroupHelper.processAndDispatch( _service, 
												  URLLoader( event.target ).data, 
												  result,
												  "blogs",
												  MethodGroupHelper.parseBlogList );
		}
		
		/**
		 * Posts a photo to a flickr blog.
		 *
		 * This method requires authentication with WRITE permission.
		 *
		 * @param blog_id The id of the blog to post to
		 * @param photo_id The id of the photo to blog
		 * @param title The blog post title
		 * @param description The blog post body
		 * @param blog_password (Optional) The password for the blog (used when the blog does not have a stored password)
		 * @see http://www.flickr.com/services/api/flickr.blogs.postPhoto.html
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function postPhoto( blog_id:String, photo_id:String, title:String, description:String, blog_password:String = "" ):void {
			// Let the Helper do the work to invoke the method
			MethodGroupHelper.invokeMethod( _service, postPhoto_result, 
								   "flickr.blogs.postPhoto", 
								   false,
								   new NameValuePair( "blog_id", blog_id ),
								   new NameValuePair( "photo_id", photo_id ),
								   new NameValuePair( "title", title ),
								   new NameValuePair( "description", description ),
								   new NameValuePair( "blog_password", blog_password ) );
		}
		
		/**
		 * Capture the result of the postPhoto call, and dispatch
		 * the event to anyone listening.
		 *
		 * @param event The complete event generated by the URLLoader
		 * 			that was used to communicate with the Flickr API
		 *			from the invokeMethod method in MethodGroupHelper
		 */
		private function postPhoto_result( event:Event ):void {
			// Create a BLOGS_POST_PHOTO event
			var result:FlickrResultEvent = new FlickrResultEvent( FlickrResultEvent.BLOGS_POST_PHOTO );

			// Have the Helper handle parsing the result from the server - get the data
			// from the URLLoader which correspondes to the result from the API call
			MethodGroupHelper.processAndDispatch( _service, 
												  URLLoader( event.target ).data, 
												  result );
		}
		
	}	
	
}