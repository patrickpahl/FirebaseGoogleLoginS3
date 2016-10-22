//
//  LoginViewController.swift
//  FirebaseGoogleLoginS3
//
//  Created by Patrick Pahl on 10/22/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
    googleLoginButtonOutlet.style = .iconOnly
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var googleLoginButtonOutlet: GIDSignInButton!

}
