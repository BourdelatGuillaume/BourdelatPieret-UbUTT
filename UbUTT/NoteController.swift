//
//  NoteController.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class NoteController: UIViewController {

    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var user:Utilisateur?
    var course:Course?
    var delegate:isAbleToReceiveData!
    var note:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.user != nil && self.course != nil){
            if(self.user!.getId_utilisateur()==self.course!.getId_passager()){
                let userConducteur:Utilisateur = course!.getConducteur()!.getUtilisateur()!
                nom.text = "Notez le conducteur "+userConducteur.getPrenom_utilisateur()+" "+userConducteur.getNom_utilisateur()
            } else if(self.user!.getConducteur()!.getId_conducteur()==self.course!.getId_conducteur()){
                let userPassager:Utilisateur = self.course!.getPassager()!
                nom.text = "Notez le passager "+userPassager.getPrenom_utilisateur()+" "+userPassager.getNom_utilisateur()
            }
        }
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.tapStar1))
        star1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapStar2))
        star2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.tapStar3))
        star3.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.tapStar4))
        star4.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.tapStar5))
        star5.addGestureRecognizer(tap5)
        
        // Do any additional setup after loading the view.
    }
    
    public func clearStars(){
        star1.image = UIImage(named: "star_unselected")
        star2.image = UIImage(named: "star_unselected")
        star3.image = UIImage(named: "star_unselected")
        star4.image = UIImage(named: "star_unselected")
        star5.image = UIImage(named: "star_unselected")
    }
    
    public func click(num:Int){
        clearStars()
        if(num>=1){
            star1.image = UIImage(named: "star")
        }
        if(num>=2){
            star2.image = UIImage(named: "star")
        }
        if(num>=3){
            star3.image = UIImage(named: "star")
        }
        if(num>=4){
            star4.image = UIImage(named: "star")
        }
        if(num==5){
            star5.image = UIImage(named: "star")
        }
        self.note=num;
    }
    
    @objc public func tapStar1(){
        click(num: 1)
    }
    @objc public func tapStar2(){
        click(num: 2)
    }
    @objc public func tapStar3(){
        click(num: 3)
    }
    @objc public func tapStar4(){
        click(num: 4)
    }
    @objc public func tapStar5(){
        click(num: 5)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if(self.user!.getId_utilisateur()==self.course!.getId_passager()){
            course!.setNote_conducteur(note_conducteur: self.note);
            course!.updateNoteConducteur();
        } else if(user!.getConducteur()!.getId_conducteur()==self.course!.getId_conducteur()){
            course!.setNote_passager(note_passager: self.note);
            course!.updateNotePassager();
        }
        self.course = Course.getBDCourseByID(id: self.course!.getId_course());
        if(course!.getNote_conducteur() != -1 && course!.getNote_passager() != -1){
            self.course!.setId_statut(id_statut: 5);
            self.course!.updateStatut();
        }
        delegate.pass(data: user!)
        dismiss(animated: true, completion: nil)
    }

}
