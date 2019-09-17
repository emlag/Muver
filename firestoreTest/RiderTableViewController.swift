//
//  RiderTableViewController.swift
//  firestoreTest
//
//  Created by Edwin Lagos on 8/28/19.
//  Copyright © 2019 Edwin Lagos. All rights reserved.
//

import UIKit
import Firebase

class RiderTableViewController: UITableViewController {
    var colRef: CollectionReference!
    var allUsers: Array<MuverUser>!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDriverNames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = allUsers[indexPath.row].name
        
        return cell
    }
    
    @IBAction func addDriver(_ sender: Any)
    {
        //1. Create an alert
        let alert = UIAlertController(title: "Driver Info", message: "Enter your name", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Enter name here"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let name = textField?.text {
                
                //We're creating MuverUser objects instead of passing around strings
                let newUser: MuverUser = MuverDriver(name: name, ID: "", availability: true)
                self.allUsers.append(newUser)
                
                self.addDriverToDB(user: newUser)
                self.loadDrivers()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == MuverConstants.nav.DRIVER_SEGUE,
        let destination = segue.destination as? DriverViewController,
        let driverIndex = tableView.indexPathForSelectedRow?.row
        {
            //Pass the User object of the current user to the next screen.
            destination.currUser = allUsers[driverIndex]
        }
    }
    
    private func loadDriverNames()
    {
        //Getting data from firebase
        
        //1. this is the collection that I want to use,
        //that way I dont have to type this out every time
        colRef = Firestore.firestore().collection(MuverConstants.db.DRIVERS_COLL)
        
        //2. Initialize names array
        allUsers = []
        
        //3. only get the documents with available drivers
        colRef.whereField(MuverConstants.db.MUVERUSER_AVAILABILITY, isEqualTo: true).getDocuments() {
            (availDrivers, err) in
            if let err = err {
                print("oh no! \(err)")
            } else {
                for document in availDrivers!.documents {
                    //4. With the data that you get from firestore, which is a dictionary,
                    //we'll use one of MuverUser's(parent of MuverDriver) constructors to create the
                    //object with the necessary information.
                    let currUserSimple = MuverDriver(data: document.data())
                    
                    //add that user to our array of MuverUsers
                    self.allUsers.append(currUserSimple)
                }
            }
            
            //Makes sure that this reloads the tableView on the main thread
            self.loadDrivers()
        }
    }
    
    func addDriverToDB(user: MuverUser ) {
        //This is a helper function to create a document for this user in Firestore
        colRef = Firestore.firestore().collection(MuverConstants.db.DRIVERS_COLL)
        colRef.addDocument(data: user.toDictionary())
    }
    
    func loadDrivers()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
