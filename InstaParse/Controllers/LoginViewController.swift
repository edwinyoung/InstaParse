//
//  LoginViewController.swift
//  InstaParse
//
//  Created by Edwin Young on 3/9/17.
//  Copyright © 2017 Test Org Pls Ignore. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		usernameTextField.becomeFirstResponder()
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
	@IBAction func onSignup(_ sender: Any) {
		let newUser = PFUser()
		
		newUser.username = usernameTextField.text
		newUser.password = passwordTextField.text
		
		newUser.signUpInBackground { (success: Bool, error: Error?) in
			if success {
				print("Created User \(newUser.username!)")
				self.usernameTextField.text = ""
				self.passwordTextField.text = ""
				self.performSegue(withIdentifier: "Login Segue", sender: nil)
			} else {
				print(error?.localizedDescription)
				if (error as! NSError).code == 202 {
					print("Username \(newUser.username!) is already taken")
				}
			}
		}
	}
	
	@IBAction func onLogin(_ sender: Any) {
		PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) -> Void in
			if user != nil {
				print("User \(user!.username!) successfully logged in")
				self.usernameTextField.text = ""
				self.passwordTextField.text = ""
				self.performSegue(withIdentifier: "Login Segue", sender: nil)
			} else {
				print(error?.localizedDescription)
			}
		}
	}
	
}
