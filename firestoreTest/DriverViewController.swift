//
//  DriverViewController.swift
//  firestoreTest
//
//  Created by Edwin Lagos on 9/2/19.
//  Copyright © 2019 Edwin Lagos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorageUI

class DriverViewController: UIViewController {
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverImage: UIImageView!
    
    var currUser:MuverUser!
    
    var colRef: CollectionReference!
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        driverNameLabel.text = currUser.name
        
        print("The user's name is \(String(describing: currUser.name))")
        
        //Storing things in Firebase Storage
        //1. Create a reference
        storageRef = Storage.storage().reference()
        
        //You can choose to have a place holder image
        let placeholderImage = UIImage(named: "placeholder.jpg")
        
        //2. Make sure that the user we received from the previous screen has a name
        guard let name = currUser.name else
        {print("Name not found in DB for this user")
            return
            
        }
        
        //3. Create a reference to where you want to save this image.
        let reference = storageRef.child("driverImages/\(String(describing: name)).jpg")
        
        //4. Use the outlet for the image view to use sd_setImage so that you can download the image
        //and set it within the imageview
        driverImage.sd_setImage(with: reference, placeholderImage: placeholderImage)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //This function writes to the database and updates the availability of a driver.
    @IBAction func bookDriver(_ sender: Any) {
        colRef.document(currUser.ID).updateData([MuverConstants.db.MUVERUSER_AVAILABILITY: false])
    }
    
    @IBAction func loadImage(_ sender: Any) {
//        storageRef = Storage.storage().reference()
//        let imagesRef = storageRef.child("driverImages")
//        let juanRef = imagesRef.child("juan.jpg")
//
//        juanRef.downloadURL { (url, error) in
//            if let error = error {
//                print(error)
//            } else {
//                self.driverImage.sd_setImage(with: url)
//            }
//        }



//        driverImage.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/firestoretest-63093.appspot.com/o/driverImages%2Fjuan.jpg?alt=media&token=91c7a16e-13c6-4d23-b4aa-51764090dd77"))
    
    }
}
