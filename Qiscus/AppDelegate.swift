//
//  AppDelegate.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import UIKit
import CoreData
import Foundation
import QiscusCore
import SwiftyJSON

let APP_ID : String = "sdksample"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        QiscusCore.enableDebugMode(value: true)
        QiscusCore.setup(AppID: APP_ID)
        self.auth()
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "Qiscus")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

}

extension AppDelegate {
    // Auth
    func auth() {
        let target : UIViewController
        if QiscusCore.hasSetupUser() {
            target = ChatViewController()
            _ = QiscusCore.connect(delegate: self)
        }else {
            target = ViewController()
        }
        let navbar = UINavigationController()
        navbar.viewControllers = [target]
    }
    
    func registerDeviceToken(){
        if let deviceToken = UserDefaults.standard.getDeviceToken(){
            //change isDevelopment to false for production and true for development
            QiscusCore.shared.registerDeviceToken(token: deviceToken, onSuccess: { (success) in
                print("success register device token =\(deviceToken)")
            }) { (error) in
                print("failed register device token = \(error.message)")
            }
        }
    }
}

extension AppDelegate : QiscusConnectionDelegate {
    func onConnected(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reSubscribeRoom"), object: nil)
    }
    func onReconnecting(){
        
    }
    func onDisconnected(withError err: QError?){
        
    }
    
    func connectionState(change state: QiscusConnectionState) {
        if (state == .disconnected){
            var roomsId = [String]()
            
            let rooms = QiscusCore.database.room.all()
            
            if rooms.count != 0{
                
                for room in rooms {
                    roomsId.append(room.id)
                }
                
                QiscusCore.shared.getChatRooms(roomIds: roomsId, showRemoved: false, showParticipant: true, onSuccess: { (rooms) in
                    //brodcast rooms to your update ui ex in ui listRoom
                }, onError: { (error) in
                    print("error = \(error.message)")
                })
                
            }
            
        }
        
    }
}

