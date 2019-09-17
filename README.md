# Muver
A Demo App for Muving People

---
### Make sure to add the following to your podfile

* pod 'Firebase/Storage'
* pod 'Firebase/Analytics'
* pod 'FirebaseUI/Storage'

Save the file and run "pod install" on the terminal. 

---

## Design

**Model:**
MuverUser : A parent class for users of this app. It contains two types of constructors and one 
helper method that converts the information for a user into a dictionary that can be sent to 
firestore.

  * MuverDriver : A subclass of MuverUser
  * MuverRider : A subclass of MuverUser
    
**View:**

  * Driver view: Shows a profile for the MuverUser. The label will be updates with the driver's name.
  
  * Rider view: Gives the user a list of available Drivers to choose from. 
    
**Controller:**

* DiverTableViewController: A view that shows the profile of a driver. Currently it looks up the
  driver's name in the database and retrives his/her picture using Firebase Storage and Firebase
  StorageUI.This class also holds a representation of a MuverUser, which has been passed from 
  RiderTableViewController
  
* RiderTableViewController: A list of available drivers. View didLoad calls loadDriverNames.

  * loadDriverNames: Iterates through a collection and creates a MuverUser for each document found.
                     Each MuverUser is then added to the allUsers array so that the tableView can
                     use that data. 
                     
  * addDriver: Is called when the "+" button is clicked. Creates an alert popup and uses addDriverToDB
               to store the new driver information in the database.
                       
  * addDriverToDB: Receives a MuverUser object from addDriver and stores the necessary information in
                   Firestore db.
                   
  * prepare for segue : Sends the selected MuverUser to the next screen so that the profile for that user 
                         is shown. 
                     
               
