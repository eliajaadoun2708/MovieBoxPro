//
//  Router.swift
//  MovieBoxPro
//
//  Created by elia jadoun on 03/03/2021.
//

import UIKit
import FirebaseAuth

//class since we use it everyehere in our app -> singleton
class Router{
    
    //singleton:
    static let shared = Router()
    
    //properties:
    weak var window: UIWindow?
    var isAuthorized: Bool {
        return Auth.auth().currentUser != nil
    }
 
    //init:
    private init(){}
    
    //methods:
    func determineRootViewController(){
        let name = isAuthorized ? "Main" : "Login"
        let storyboard = UIStoryboard(name: name, bundle: .main)
        let rootViewContoller = storyboard.instantiateInitialViewController()
        
        window?.rootViewController = rootViewContoller
    }
}

