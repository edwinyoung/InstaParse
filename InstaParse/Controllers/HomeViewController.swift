//
//  HomeViewController.swift
//  InstaParse
//
//  Created by Edwin Young on 3/9/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	var posts: [PFObject]!
	let refreshControl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		tableView.delegate = self
		tableView.dataSource = self
		
		refreshControl.addTarget(self, action: #selector(HomeViewController.refreshControlAction), for: UIControlEvents.valueChanged)
		tableView.insertSubview(refreshControl, at: 0)
		
		fetchPostsInBackground()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		fetchPostsInBackground()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if posts != nil {
			return posts.count
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
		cell.postData = posts[indexPath.row]
		
		return cell
	}
	
	func fetchPostsInBackground() {
		print("called fetchPostsInBackground()")
		let query = PFQuery(className: "Post")
		query.order(byDescending: "createdAt")
		query.includeKey("author")
		query.limit = 20
		query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
			print("Finished network requests")
			if let posts = posts {
				self.posts = posts
				self.tableView.reloadData()
				self.refreshControl.endRefreshing()
			} else {
				print("error")
			}
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		
		/*
		let originalWidth = originalImage.cgImage?.width
		let originalHeight = originalImage.cgImage?.height
		
		let aspectRatio = try! Float(originalWidth!) / Float(originalHeight!)
		let targetWidth = Float(360)
		let scaleFactor = targetWidth / aspectRatio
		
		let newWidth = Int(Float(originalWidth!) * scaleFactor)
		let newHeight = Int(Float(originalHeight!) * scaleFactor)
		
		let editedImage = resize(image: originalImage, newSize: CGSize(width: newWidth, height: newHeight))
		*/
		
		dismiss(animated: false, completion: nil)
		
		performSegue(withIdentifier: "Upload Segue", sender: originalImage)
	}
	
	/*
	func resize(image: UIImage, newSize: CGSize) -> UIImage {
		let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
		resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
		resizeImageView.image = image
		
		UIGraphicsBeginImageContext(resizeImageView.frame.size)
		resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
	*/
	
	func refreshControlAction() {
		fetchPostsInBackground()
	}

	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	@IBAction func onLogout(_ sender: UIButton) {
		PFUser.logOut()
		// NotificationCenter.default.post(name: NSNotification.Name(rawValue: "User logged out"), object: nil)
		self.performSegue(withIdentifier: "Logout Segue", sender: nil)
	}
	
	@IBAction func onPost(_ sender: Any) {
		let vc = UIImagePickerController()
		vc.delegate = self
		vc.allowsEditing = true
		vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
		self.present(vc, animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let backButton = UIBarButtonItem()
		
		if segue.identifier == "Upload Segue" {
			backButton.title = "Cancel"
			
			let originalImage = sender as! UIImage
			let vc = segue.destination as! UploadViewController
			vc.postImage = originalImage
			
		}
		
		navigationItem.backBarButtonItem = backButton
	}
}
