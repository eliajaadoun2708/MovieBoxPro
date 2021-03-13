//
//  ContentViewController.swift
//  MovieBoxPro
//
//  Created by elia jadoun on 04/03/2021.
//

import UIKit
import SwiftUI
import Firebase

class ContentViewController: UITableViewController {

    @IBAction func signOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            Router.shared.determineRootViewController()//send the user back to the login page
        }
        catch let err{
            showError(title: err.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    struct ContentView: View {
        
        
        var body: some View {
            TabView {
                MovieListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "tv")
                            Text("Movies")
                        }
                }
                .tag(0)
                
                MovieSearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                }
                .tag(1)
                
            }
            
            
            
        }
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    func userSignOut(){
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Couldn't create the audio player for file")
        }
    }

    
    

   
}

