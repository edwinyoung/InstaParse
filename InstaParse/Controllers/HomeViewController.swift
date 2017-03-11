//
//  HomeViewController.swift
//  InstaParse
//
//  Created by Edwin Young on 3/9/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
	@IBAction func onLogout(_ sender: UIButton) {
		PFUser.logOut()
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "User logged out"), object: nil)
		self.performSegue(withIdentifier: "Logout Segue", sender: nil)
	}

}
