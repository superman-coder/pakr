 //
//  AppDelegate.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Google
import Parse
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var authenService: AuthService!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
       
        // if we run from testing environment. nothing happen for saving time
            if NSProcessInfo.processInfo().environment["XCInjectBundle"] != nil  ||
               NSProcessInfo.processInfo().environment["XCTestConfigurationFilePath"] != nil  {
                return false
            }
        
        Fabric.with([Crashlytics.self])

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window = window
        
        setUpStyle()
        setUpParse()
        setUpAWS()
        setUpGoogleAnalytic()
        
        authenService = WebServiceFactory.getAuthService()
        
       if authenService.isLogin() {
            let rootViewController = PakrTabBarController()
            window.rootViewController = rootViewController
        } else {
            let rootViewController = LoginController(nibName: "LoginController", bundle: nil)
            window.rootViewController = rootViewController
        }
        
        window.makeKeyAndVisible()
        return true
    }
   
    // http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
    func setUpStyle() {
        // setup navigation bar style
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.primaryColor()
        
        let barAttributes :Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(18),
                                      NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = barAttributes
        
        // navigation item normal state
        let itemAttributes :Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15),
                                      NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes(itemAttributes, forState: UIControlState.Normal)
        
        // tab bar item normal state
        var tabBarItemAttributes :Dictionary = [NSFontAttributeName: UIFont.boldSystemFontOfSize(11),
                                                NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xE0E0E0)]
        UITabBarItem.appearance().setTitleTextAttributes(tabBarItemAttributes, forState: UIControlState.Normal)
        
        // tab bar item select state
        tabBarItemAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(11),
                                                NSForegroundColorAttributeName: UIColor.UIColorFromRGB(Constants.Color.PrimaryColor)]
        UITabBarItem.appearance().setTitleTextAttributes(tabBarItemAttributes, forState: UIControlState.Selected)
       
        // icon color when selected
        UITabBar.appearance().tintColor = UIColor.UIColorFromRGB(Constants.Color.PrimaryColor)
        
        UITabBar.appearance().translucent = false
        UITabBar.appearance().backgroundColor = UIColor.blackColor()
    }
    
    func setUpGoogleAnalytic() {
        // Configure tracker from GoogleService-Info.plist.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
    }
    
    func setUpParse() {
        User.registerSubclass()
        let config = ParseClientConfiguration(block: {
            (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = Constants.Parse.APP_ID
            ParseMutableClientConfiguration.clientKey = Constants.Parse.MASTER_KEY
            ParseMutableClientConfiguration.server = Constants.Parse.HOST
        });
        
        Parse.initializeWithConfiguration(config);
    }
    
    func setUpAWS() {
        let credentialsProvider = AWSCognitoCredentialsProvider(
                regionType: Constants.AWS.CognitoRegionType,
                identityPoolId: Constants.AWS.CognitoIdentityPoolId)
        
        let configuration = AWSServiceConfiguration(
                region: Constants.AWS.DefaultServiceRegionType,
                credentialsProvider: credentialsProvider)
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
    }
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        print("step 2 of OAuth2. Url: \(url)")
        
        // url from google
        if GoogleAuth.isValidatedWithUrl(url) {
            return GIDSignIn.sharedInstance().handleURL(
                    url,
                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        }
        // url from facebook
         else if FacebookAuth.isValidatedWithUrl(url) {
             return FBSDKApplicationDelegate.sharedInstance().application(application,
                    openURL: url,
                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String,
                    annotation: options [UIApplicationOpenURLOptionsAnnotationKey])
        }
        // application hasn't supported this url yet
        else {
              return false
        }
    }
    
    // from ios 9. this method isn't called anymore. must be called manually from above method
    @available(iOS, introduced=8.0, deprecated=9.0)
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if FacebookAuth.isValidatedWithUrl(url) {
            print("AppDelegate. FacebookURL: \(url)")
            return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return false
    }
}

