//
//  AppDelegate.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, 
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    CoreDataManager.shared.load()
    return true
  }

  // MARK: UISceneSession Lifecycle
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}


  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Note")
      container.loadPersistentStores { description, error in
          if let error {
              print(error.localizedDescription)
          } else {
            print("DB url = ", description.url?.absoluteString ?? "")
          }
      }
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

}

