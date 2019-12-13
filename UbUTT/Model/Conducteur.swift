//
//  Conducteur.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**
 * Classe qui définit un conducteur
 */
public class Conducteur:Entity {
    private var id_conducteur:Int
    private var id_utilisateur:Int
    private var modele_voiture:String
    private var plaque_immatriculation:String
    private var courses:Array<Course>
    private var utilisateur:Utilisateur?
    
    required init(){
        self.id_conducteur=0
        self.id_utilisateur=0
        self.modele_voiture=""
        self.plaque_immatriculation=""
        self.courses=Array()
        super.init()
    }
    
    required init( dictionary: [String : Any]){
        self.id_conducteur=Int(dictionary["id_conducteur"] as? String ?? "0")!
        self.id_utilisateur=Int(dictionary["id_utilisateur"] as? String ?? "0")!
        self.modele_voiture=dictionary["modele_voiture"] as? String ?? ""
        self.plaque_immatriculation=dictionary["plaque_immatriculation"] as? String ?? ""
        self.courses=Array()
        super.init(dictionary: dictionary)
    }
    
    
    public static func getBDConducteurByIDUtilisateur(id:Int) -> Conducteur?{
        let req:SQLRequest<Conducteur> = SQLRequest()
        req.prepare(requete:"SELECT * FROM CONDUCTEUR WHERE ID_UTILISATEUR = ?")
        req.addParametres(parametre: [String(id)])
        return req.executerOneResult()
    }
    
    public func update() -> Void{
        let req:SQLRequest =  SQLRequest()
        req.prepare(requete:"UPDATE CONDUCTEUR SET MODELE_VOITURE = ?, PLAQUE_IMMATRICULATION= ? WHERE ID_UTILISATEUR=?")
        req.addParametres(parametre: [self.modele_voiture,self.plaque_immatriculation,String(self.id_utilisateur)])
        req.executerNoResult()
    }
    
    public func getCourses() -> Array<Course>{
        if(self.courses.count<1){
            let req:SQLRequest<Course> =  SQLRequest()
            req.prepare(requete:"SELECT * FROM COURSE WHERE ID_CONDUCTEUR = ?")
            req.addParametres(parametre: [String(self.id_conducteur)])
            self.courses = req.executerMultipleResult()
        }
        return self.courses
    }
    
    public func getNoteConducteur() -> Double{
        let courses:Array<Course> = self.getCourses()
        var res:Double = 5.0
        for c in courses {
            if(c.getNote_conducteur() != -1) {
                res += Double(c.getNote_conducteur())
            }
        }
        res /= Double(courses.count+1)
        return res
    }
    
    public func getUtilisateur() -> Utilisateur?{
        if(self.utilisateur==nil){
            self.utilisateur = Utilisateur.getBDUtilisateurByID(id:self.id_utilisateur)
        }
        return self.utilisateur
    }
    
    public static func getBDConducteurByID(id:Int) -> Conducteur?{
        let req:SQLRequest<Conducteur> =  SQLRequest()
        req.prepare(requete:"SELECT * FROM CONDUCTEUR WHERE ID_CONDUCTEUR = ?")
        req.addParametres(parametre: [String(id)])
        return req.executerOneResult()
    }
    
    public func getId_conducteur() -> Int{
        return id_conducteur
    }
    
    public func getId_utilisateur() -> Int{
        return id_utilisateur
    }
    
    public func getModele_voiture() -> String{
        return modele_voiture
    }
    
    public func getPlaque_immatriculation() -> String{
        return plaque_immatriculation
    }
    
    public func setId_conducteur(id_conducteur:Int) -> Void{
        self.id_conducteur = id_conducteur
    }
    
    public func setId_utilisateur(id_utilisateur:Int) -> Void{
        self.id_utilisateur = id_utilisateur
    }
    
    public func setModele_voiture(modele_voiture:String) -> Void{
        self.modele_voiture = modele_voiture
    }
    
    public func setPlaque_immatriculation(plaque_immatriculation:String) -> Void{
        self.plaque_immatriculation = plaque_immatriculation
    }
}
