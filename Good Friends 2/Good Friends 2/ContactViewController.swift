//
//  ContactViewController.swift
//  Good Friends 2
//
//  Created by Administrator on 5/13/20.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {

   var contacts = ["Jon", "John", "Jhon"]
   var contactNotes = ["Vegan", "Hates Coffee", "Mother died"]
   var contactInfo = [Contact]()
   var newContact: String = ""
   
   var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row]

        return cell
    }


    @IBAction func cancel(segue:UIStoryboardSegue) {
      
    }

    @IBAction func done(segue:UIStoryboardSegue) {
         let contactDetailVC = segue.source as! AddContactViewController
                  newContact = contactDetailVC.name
                     
        
        self.add(newContact)
                  //contacts.append(newContact)
                  //tableView.reloadData()
    }
    
    func add(_ contact: String){
        let index = 0
        contacts.insert(contact, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        contacts.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    

    
    
}
