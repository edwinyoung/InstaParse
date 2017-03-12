//
//  Post.swift
//  InstaParse
//
//  Created by Edwin Young on 3/11/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
	
	class func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?) {
		// Create Parse object PFObject
		let post = PFObject(className: "Post")
		let date = Date()
		
		// Add relevant fields to the object
		post["media"] = getPFFileFromImage(image: image) // PFFile column type
		post["author"] = PFUser.current() // Pointer column type that points to PFUser
		post["caption"] = caption
		post["likesCount"] = 0
		post["commentsCount"] = 0
		post["date"] = date
		
		// Save object (following function will save the object in Parse asynchronously)
		post.saveInBackground(block: completion)
	}
	
	class func getPFFileFromImage(image: UIImage?) -> PFFile? {
		// check if image is not nil
		if let image = image {
			// get image data and check if that is not nil
			if let imageData = UIImagePNGRepresentation(image) {
				return PFFile(name: "image.png", data: imageData)
			}
		}
		return nil
	}
	
}
