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
public class Conducteur {
    private var id_conducteur:Int
    private var id_utilisateur:Int
    private var modele_voiture:String
    private var plaque_immatriculation:String
    private var courses:Array<Course>
    private var utilisateur:Utilisateur
    
    init(){}
    
    public static func getBDConducteurByIDUtilisateur(id:Int) -> Conducteur{
        SQLRequest<Conducteur> req= new SQLRequest<>(Conducteur.class)
        req.prepare("SELECT * FROM CONDUCTEUR WHERE ID_UTILISATEUR = ?")
        req.addParametres(new String[]{String.valueOf(id)})
        return req.executerOneResult()
    }
    
    public func update() -> Void{
        SQLRequest req= new SQLRequest()
        req.prepare("UPDATE CONDUCTEUR SET MODELE_VOITURE = ?, PLAQUE_IMMATRICULATION= ? WHERE ID_UTILISATEUR=?")
        req.addParametres(new String[]{self.modele_voiture,self.plaque_immatriculation,String.valueOf(self.id_utilisateur)})
        req.executerNoResult()
    }
    
    public func getCourses() -> Array<Course>{
        if(self.courses==null){
            self.courses = new ArrayList<>()
            SQLRequest<Course> req= new SQLRequest<>(Course.class)
            req.prepare("SELECT * FROM COURSE WHERE ID_CONDUCTEUR = ?")
            req.addParametres(new String[]{String.valueOf(self.id_conducteur)})
            self.courses = req.executerMultipleResult()
        }
        return self.courses
    }
    
    public func getNoteConducteur() -> Double{
        ArrayList<Course> courses = self.getCourses()
        double res = 5.0
        for (Course c: courses) {
            if(c.getNote_conducteur()!=-1) {
                res += c.getNote_conducteur()
            }
        }
        res/=courses.size()+1
        return res
    }
    
    public func getUtilisateur() -> Utilisateur{
        if(self.utilisateur==null){
            self.utilisateur = Utilisateur.getBDUtilisateurByID(self.id_utilisateur)
        }
        return self.utilisateur
    }
    
    public static func getBDConducteurByID(id:Int) -> Conducteur{
        SQLRequest<Conducteur> req= new SQLRequest<>(Conducteur.class)
        req.prepare("SELECT * FROM CONDUCTEUR WHERE ID_CONDUCTEUR = ?")
        req.addParametres(new String[]{String.valueOf(id)})
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
