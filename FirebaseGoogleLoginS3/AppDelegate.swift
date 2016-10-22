//
//  AppDelegate.swift
//  FirebaseGoogleLoginS3
//
//  Created by Patrick Pahl on 10/22/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//
//Create FirebaseAccount -> copy over google plist
//Go to project -> Capabilities -> Turn on key chain access (for simulator)
//Get reverse client ID from google plist, copy it to project -> Info -> URLtypes
// Add '+' schema, paste in reverse client ID in URL schemes
// Create obj-c 'm' file, then create bridging header file automatically (delete m file)
// In the bridging header file, copy/paste from the firebase docs: #import <GoogleSignIn/GoogleSignIn.h>
//* Go to Firebase console -> Authentication -> Enable google login -> Save


import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    var databaseRef: FIRDatabaseReference?
    //Reference to Firebase database
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("User signed into google")
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("User signed into firebase")
        
        self.databaseRef = FIRDatabase.database().reference()
        // Location of our firebase database
        
        //Check if users info is stored already or not:
        self.databaseRef?.child("user_profiles").child(user.uid).observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.value as? NSDictionary
            
            if snapshot == nil {
                self.databaseRef?.child("user_profiles").child(user.uid).child("name").setValue(user.)
            
            }
        })
    }
        // 10-36
        
        
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    
    //////
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
}

