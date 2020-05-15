//
//  AddContactViewController.swift
//  Good Friends 2
//
//  Created by Administrator on 5/13/20.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var contactName: UITextField!
    
    var name: String = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = contactName.text!
        }
    }
    
}
