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
        
        /*if(user != null && this.course!=null){
            if(user.getId_utilisateur()==this.course.getId_passager()){
                Utilisateur userConducteur = course.getConducteur().getUtilisateur();
                txt_nom.setText(getResources().getString(R.string.note_conducteur)+" "+userConducteur.getPrenom_utilisateur()+" "+userConducteur.getNom_utilisateur());
            } else if(user.getConducteur().getId_conducteur()==this.course.getId_conducteur()){
                Utilisateur userPassager = course.getPassager();
                txt_nom.setText(getResources().getString(R.string.note_passager)+" "+userPassager.getPrenom_utilisateur()+" "+userPassager.getNom_utilisateur());
            }*/
        
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
            star1.image = UIImage(named: "star")
        }
        if(num>=3){
            star1.image = UIImage(named: "star")
        }
        if(num>=4){
            star1.image = UIImage(named: "star")
        }
        if(num==5){
            star1.image = UIImage(named: "star")
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
        /*if(user.getId_utilisateur()==this.course.getId_passager()){
            course.setNote_conducteur(this.note);
            course.updateNoteConducteur();
        } else if(user.getConducteur().getId_conducteur()==this.course.getId_conducteur()){
            course.setNote_passager(this.note);
            course.updateNotePassager();
        }
        course = Course.getBDCourseByID(course.getId_course());
        if(course.getNote_conducteur()!=-1 && course.getNote_passager()!=-1){
            course.setId_statut(5);
            course.updateStatut();
        }
        setResult(RESULT_OK, new Intent().putExtra(Constants.COURSE_EXTRA, this.course));
        finish();*/
    }

}
