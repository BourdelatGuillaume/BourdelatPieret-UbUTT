//
//  HistoricController.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class HistoricController: UIViewController {
    
    var user:Utilisateur?
    
    @IBOutlet weak var histo: UIView!
    
    var histoTableViewController: HistoricTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickReturn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueContainerHistoric" {
            let vc = segue.destination as? HistoricTableViewController
            vc?.user = self.user
        }
    }

}
