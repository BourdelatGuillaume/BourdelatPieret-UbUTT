//
//  ParametresController.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class ParametresController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var save: UIButton!
    
    var user:Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickReturn(_ sender: UIButton) {
    }
    
    @IBAction func onClickSave(_ sender: UIButton) {
    }
    
    @IBAction func onEditNom(_ sender: UITextField) {
    }
    @IBAction func onEditPrenom(_ sender: UITextField) {
    }
    @IBAction func onEditEmail(_ sender: UITextField) {
    }
    @IBAction func onEditNum(_ sender: UITextField) {
    }
    @IBAction func onEditPass(_ sender: UITextField) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
