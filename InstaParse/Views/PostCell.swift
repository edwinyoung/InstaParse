//
//  PostCell.swift
//  InstaParse
//
//  Created by Edwin Young on 3/9/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {
	
	@IBOutlet weak var postIV: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var captionLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	var postData: PFObject! {
		didSet {
			let user = postData.object(forKey: "author") as? PFUser
			let date = postData.object(forKey: "date") as? Date
			
			captionLabel.text = postData.object(forKey: "caption") as? String
			
			// Set date created if one is available
			if date != nil {
				dateLabel.text = calculateTimeStamp(timePostedAgo: (date?.timeIntervalSinceNow)!)
			} else {
				dateLabel.text = ""
			}
			
			// Only display username if there is a caption
			if captionLabel.text == "" {
				usernameLabel.text = ""
			} else {
				usernameLabel.text = user?.username!
			}
			
			let dataData = postData.object(forKey: "media") as? PFFile
			dataData?.getDataInBackground(block: { (datainfo: Data?, error: Error?) in
				if(error == nil) {
					let picture = UIImage(data: datainfo!)
					self.postIV.image = picture
				}
			})
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func calculateTimeStamp(timePostedAgo: TimeInterval) -> String {
		// Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
		var rawTime = Int(timePostedAgo)
		var timeAgo: Int = 0
		var timeChar = ""
		
		rawTime = rawTime * (-1)
		
		// Figure out time ago
		if (rawTime <= 60) { // SECONDS
			timeAgo = rawTime
			if timeAgo == 1 {
				timeChar = "second ago"
			} else {
				timeChar = "seconds ago"
			}
		} else if ((rawTime/60) <= 60) { // MINUTES
			timeAgo = rawTime/60
			if timeAgo == 1 {
				timeChar = "minute ago"
			} else {
				timeChar = "minutes ago"
			}
		} else if (rawTime/60/60 <= 24) { // HOURS
			timeAgo = rawTime/60/60
			if timeAgo == 1 {
				timeChar = "hour ago"
			} else {
				timeChar = "hours ago"
			}
		} else if (rawTime/60/60/24 <= 365) { // DAYS
			timeAgo = rawTime/60/60/24
			if timeAgo == 1 {
				timeChar = "day ago"
			} else {
				timeChar = "days ago"
			}
		} else if (rawTime/60/60/24 <= 365) { // MONTHS
			timeAgo = rawTime/60/60/24/30
			if timeAgo == 1 {
				timeChar = "month ago"
			} else {
				timeChar = "months ago"
			}
		} else if (rawTime/(3153600) <= 1) { // YEARS
			timeAgo = rawTime/60/60/24/365
			if timeAgo == 1 {
				timeChar = "year ago"
			} else {
				timeChar = "years ago"
			}
		}
		
		return "posted \(timeAgo) \(timeChar)"
	}
	
}
