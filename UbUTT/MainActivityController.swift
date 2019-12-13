//
//  MainActivityController.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
// +33 6 06 40 78 06 -> test12
//

import UIKit

class MainActivityController: UIViewController {
    
    var utilisateurConnection:UtilisateurConnection?
    var user:Utilisateur?
    
    @IBOutlet weak var num_tel: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        utilisateurConnection = UtilisateurConnection()
        //utilisateurConnection!.disconnect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(utilisateurConnection!.isConnected()){
            let utilisateur:Utilisateur? = utilisateurConnection!.getUtilisateurConnecte()
            if(utilisateur != nil) {
                self.signIn(user:utilisateur!)
            }
        }
        //num_tel.text = "+33606407806"
        //password.text = "test12"
    }
    
    @IBAction func onClickConnection(_ sender: UIButton) {
        if(num_tel.text!.count<10){
            num_tel.backgroundColor = UIColor.red
        } else {
            num_tel.backgroundColor = UIColor.white
        }
        if(password.text!.count<6){
            password.backgroundColor = UIColor.red
        } else {
            password.backgroundColor = UIColor.white
        }
        if(num_tel.text!.count >= 10 && password.text!.count >= 6) {
            let utilisateur:Utilisateur? = utilisateurConnection!.connection(num_telephone: num_tel.text!,password:password.text!);
            if (utilisateur != nil) {
                self.signIn(user: utilisateur!);
            }
        }
    }
    
    private func signIn(user:Utilisateur){
        self.user = user
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueHomeActivity", sender: nil)
        
    }
    
    
    @IBAction func onClickRegister(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueRegister", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is HomeActivityController
        {
            let vc = segue.destination as? HomeActivityController
            vc?.user = self.user
        }
    }

}
