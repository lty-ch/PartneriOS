//
//  AppDelegate.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcmMessageIDKey"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //keyboard management
        UserDefaults.standard.set("no", forKey: "fromLead")
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        checkToLoadScreen()
        deviceId = UIDevice.current.identifierForVendor!.uuidString
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        GMSServices.provideAPIKey(kGoogleApiKey)
        GMSPlacesClient.provideAPIKey(kGoogleApiKey)
        setupRemotePushNotifications()
        
        window?.makeKeyAndVisible()

        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }

        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print("Failed to register: \(error)")
        }

}

extension AppDelegate {
    private func setupRemotePushNotifications() {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { [weak self] granted, error in
                if granted {
                    self?.getNotificationSettingsAndRegister()
                } else {
                   print(" error")
                }
            })

        Messaging.messaging().delegate = self

        UIApplication.shared.registerForRemoteNotifications()

        processPushToken()
    }

    private func getNotificationSettingsAndRegister() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    private func processPushToken() {
        if let token = Messaging.messaging().fcmToken {
            print("FCM TOKEN \(token)")
            UserDefaults.standard.set(token, forKey: AppKeys.fcmKey)
          //  kUserDefaults.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
          //  kUserDefaults.set(token, forKey: AppKeys.fcmKey)
            
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//print("notification alert")
      //  completionHandler(.alert)
//        let ui = notification.request.content.userInfo
//        let type = ui["type"] as! String
//
//        var category = UNNotificationCategory(identifier: "", actions: [], intentIdentifiers: [], options: [])
//
//        switch type {
//        case "type1":
//            let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: [.foreground])
//            let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: [.foreground, .destructive])
//
//            category = UNNotificationCategory(identifier: "", actions: [acceptAction, declineAction], intentIdentifiers: [], options: [])
//        default:
//            break
//        }
//
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("user npt")
//        DispatchQueue.main.async{
//            
//            if let rootViewController = self.window?.rootViewController as? UINavigationController {
//                let storyboard: UIStoryboard = UIStoryboard(name: "LeadStoryboard", bundle: nil) // Replace with your storyboard name
//                if let specificViewController = storyboard.instantiateViewController(withIdentifier: "LeadListVC") as? LeadListVC {
//                    rootViewController.pushViewController(specificViewController, animated: true)
//                }
//            }else{
//                
//                guard var rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
//                    return
//                }
//                
//                let storyboard = UIStoryboard(name: "LeadStoryboard", bundle: nil)
//                
//                
//                if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "LeadListVC") as? LeadListVC,
//                    let tabBarController = rootViewController as? UITabBarController,
//                    let navController = tabBarController.selectedViewController as? UINavigationController {
//                    
//                    // we can modify variable of the new view controller using notification data
//                    // (eg: title of notification)
//                    // conversationVC.senderDisplayName = response.notification.request.content.title
//                    // you can access custom data of the push notification by using userInfo property
//                    // response.notification.request.content.userInfo
//                    navController.pushViewController(conversationVC, animated: true)
//                }
//                
//            }
//                /*
//                print(" not a rootvc")
//                
//                
//                guard let window = UIApplication.shared.keyWindow else { return }
//
//                let storyboard: UIStoryboard = UIStoryboard(name: "LeadStoryboard", bundle: nil)
//                  let yourVC = storyboard.instantiateViewController(withIdentifier: "LeadListVC") as! LeadListVC
//                  
//                  let navController = UINavigationController(rootViewController: yourVC)
//                  navController.modalPresentationStyle = .fullScreen
//
//                  window.rootViewController = navController
//                  window.makeKeyAndVisible()
//                
//            }
//                 */
//            
//        }

        completionHandler()
    }
  
}

public extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        processPushToken()
    }
}

