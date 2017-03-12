//
//  UploadViewController.swift
//  InstaParse
//
//  Created by Edwin Young on 3/11/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import EZLoadingActivity

class UploadViewController: UIViewController {
	
	@IBOutlet weak var postIV: UIImageView!
	@IBOutlet weak var postTextView: UITextView!
	
	var postImage: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		postIV.image = postImage
		postTextView.becomeFirstResponder()
		
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	@IBAction func onPost(_ sender: UIButton) {
		EZLoadingActivity.show("Uploading...", disableUI: true)
		self.view.alpha = 0.2
		
		Post.postUserImage(image: postImage, caption: postTextView.text) { (success: Bool, error: Error?) in
			if success {
				EZLoadingActivity.hide(true, animated: true)
				self.tabBarController?.selectedIndex = 0
				self.postIV.image = nil
				self.postTextView.text = ""
				self.view.alpha = 1
				self.dismiss(animated: true, completion: nil)
			} else {
				EZLoadingActivity.hide(false, animated: true)
				self.view.alpha = 1
			}
		}
	}
}
