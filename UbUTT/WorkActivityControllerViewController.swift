//
//  WorkActivityControllerViewController.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class WorkActivityControllerViewController: UIViewController {

    public static let segueIdentifier: String = "segueBetweenWorkAndHome"
    
    var user: Utilisateur!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user != nil{
            
        }else{
            self.dismiss(animated: true)
        }
        
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == WorkTableViewController.segueIdentifier {
            let vc = segue.destination as? WorkTableViewController
            vc?.user = self.user.getConducteur()
        }
    }

}
