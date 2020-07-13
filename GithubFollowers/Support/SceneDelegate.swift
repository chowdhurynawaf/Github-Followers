//
//  SceneDelegate.swift
//  GithubFollowers
//
//  Created by as on 6/21/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //let searchNC   = UINavigationController(rootViewController: SearchVC())
        //let favoriteNC = UINavigationController(rootViewController: FavoriteListVC())
        
        
        
        window =  UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        
        configureNavigationbar()
    }
    
    
    func createSearchNavigationController()->UINavigationController{
        
        let searchVC = SearchVC()
        searchVC.title = "Title"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteNavigationController() -> UINavigationController {
        
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorite"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
    
    
    func createNav(title : String , item : UITabBarItem.SystemItem , tag : Int , cl : UIViewController) -> UINavigationController {
        let vc : UIViewController = cl
        vc.title = title
       // vc.tabBarItem = item
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: item, tag: tag)
        
        return UINavigationController(rootViewController: vc)
    
    }
    
    func createTabBar() -> UITabBarController {
        
        let tabbar  = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        //tabbar.viewControllers = [createSearchNavigationController() , createFavoriteNavigationController() ]
        tabbar.viewControllers = [createNav(title: "search", item: .search, tag: 0, cl: SearchVC()) , createNav(title: "fav", item: .favorites, tag: 1, cl: FavoriteListVC())]
        
        return tabbar
    }
    
    
    func configureNavigationbar() {
        
        
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

