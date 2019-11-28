//
//  Course.swift
//  UbUTT
//
//  Created by if26-grp1 on 26/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**
 * Classe définissant une course entre un point A et un point B
 */
public class Course{
    
    private var id_course:Int
    private var id_conducteur:Int
    private var id_passager:Int
    private var id_statut:Int // 1: en attente conducteur -> 2: en attente prise en charge -> 3: en cours -> 4: en attente note -> 5: finished
    private var date:String // yyyy-mm-dd
    private var position_conducteur:String
    private var point_depart:String
    private var point_arrivee:String
    private var heure_depart:String
    private var heure_arrivee:String
    private var prix_estime:Double
    private var note_conducteur:Int
    private var note_passager:Int
    private var passager:Utilisateur?
    private var conducteur:Conducteur?
    private var statut:Statut?
    
    init(){
        self.id_course=0
        self.id_conducteur=0
        self.id_passager=0
        self.id_statut=0
        self.date=""
        self.position_conducteur=""
        self.point_depart=""
        self.point_arrivee=""
        self.heure_depart=""
        self.heure_arrivee=""
        self.prix_estime=0.0
        self.note_conducteur = -1
        self.note_passager = -1
    }
    /*
    public func getPassager() -> Utilisateur{
        if(self.passager is NSNull){
            self.passager = Utilisateur.getBDUtilisateurByID(self.id_passager)
        }
        return self.passager
    }
    
    public func getConducteur() -> Conducteur{
        if(self.conducteur == NSNull){
            self.conducteur = Conducteur.getBDConducteurByID(self.id_conducteur)
        }
        return self.conducteur
    }
    
    public func getStatut() -> Statut{
        if(self.statut == NSNull){
            self.statut = Statut.getBDStatutByID(self.id_statut)
        }
        return self.statut
    }
    
    public static func createInBD(id_utilisateur:Int, depart_lat:Double, depart_lng:Double, arrivee_lat:Double, arrivee_lng:Double, distance:Double) -> Course{
        String date = new SimpleDateFormat("yyyy-mm-dd", Locale.getDefault()).format(Calendar.getInstance().getTime())
        SQLRequest req= new SQLRequest()
        req.prepare("INSERT INTO COURSE(ID_PASSAGER, DATE, POINT_DEPART, POINT_ARRIVEE, PRIX_ESTIME) " +
            "VALUES(?,?,?,?,?)")
        req.addParametres(new String[]{String.valueOf(id_utilisateur),date,depart_lat+","+depart_lng,arrivee_lat+","+arrivee_lng, String.valueOf(0.1*distance)})
        SQLRequest<Course> reqID= new SQLRequest(Course.class)
        reqID.prepare("SELECT * FROM COURSE WHERE ID_PASSAGER, DATE, POINT_DEPART, POINT_ARRIVEE) " +
            "VALUES(?,?,?,?)")
        reqID.addParametres(new String[]{String.valueOf(id_utilisateur),date,depart_lat+","+depart_lng,arrivee_lat+","+arrivee_lng})
        return reqID.executerOneResult()
    }
    
    
    public static func getBDCourseByID(int id) -> Course{
        SQLRequest<Course> req= new SQLRequest<>(Course.class)
        req.prepare("SELECT * FROM COURSE WHERE ID_COURSE= ?")
        req.addParametres(new String[]{String.valueOf(id)})
        return req.executerOneResult()
    }
    
    public func updateNotePassager() -> Void{
        SQLRequest req= new SQLRequest()
        req.prepare("UPDATE COURSE SET NOTE_PASSAGER = ? WHERE ID_COURSE=?")
        req.addParametres(new String[]{String.valueOf(self.note_passager),String.valueOf(self.id_course)})
        req.executerNoResult()
    }
    
    public func updateNoteConducteur()-> Void{
        SQLRequest req= new SQLRequest()
        req.prepare("UPDATE COURSE SET NOTE_CONDUCTEUR = ? WHERE ID_COURSE=?")
        req.addParametres(new String[]{String.valueOf(self.note_conducteur),String.valueOf(self.id_course)})
        req.executerNoResult()
    }
    
    public func updateStatut()-> Void{
        SQLRequest req= new SQLRequest()
        req.prepare("UPDATE COURSE SET ID_STATUT = ? WHERE ID_COURSE=?")
        req.addParametres(new String[]{String.valueOf(self.id_statut),String.valueOf(self.id_course)})
        req.executerNoResult()
    }*/
    
    public func getId_course() -> Int{
        return id_course
    }
    
    public func getId_conducteur() -> Int{
        return id_conducteur
    }
    
    public func getId_passager() -> Int{
        return id_passager
    }
    
    public func getId_statut() -> Int{
        return id_statut
    }
    
    public func getDate() -> String{
        return date
    }
    
    public func getPosition_conducteur() -> String{
        return position_conducteur
    }
    
    public func getPoint_depart() -> String{
        return point_depart
    }
    
    public func getPoint_arrivee() -> String{
        return point_arrivee
    }
    
    public func getHeure_depart() -> String{
        return heure_depart
    }
    
    public func getHeure_arrivee() -> String{
        return heure_arrivee
    }
    
    public func getPrix_estime() -> Double{
        return prix_estime
    }
    
    public func getNote_conducteur() -> Int{
        return note_conducteur
    }
    
    public func getNote_passager() -> Int{
        return note_passager
    }
    
    public func setId_course(id_course:Int) -> Void{
        self.id_course = id_course
    }
    
    public func setId_conducteur(id_conducteur:Int) -> Void{
        self.id_conducteur = id_conducteur
    }
    
    public func setId_passager(id_passager:Int) -> Void{
        self.id_passager = id_passager
    }
    
    public func setId_statut(id_statut:Int) -> Void{
        self.id_statut = id_statut
    }
    
    public func setDate(date:String) -> Void{
        self.date = date
    }
    
    public func setPosition_conducteur(position_conducteur:String) -> Void{
        self.position_conducteur = position_conducteur
    }
    
    public func setPoint_depart(point_depart:String) -> Void{
        self.point_depart = point_depart
    }
    
    public func setPoint_arrivee(point_arrivee:String) -> Void{
        self.point_arrivee = point_arrivee
    }
    
    public func setHeure_depart(heure_depart:String) -> Void{
        self.heure_depart = heure_depart
    }
    
    public func setHeure_arrivee(heure_arrivee:String) -> Void{
        self.heure_arrivee = heure_arrivee
    }
    
    public func setPrix_estime(prix_estime:Double) -> Void{
        self.prix_estime = prix_estime
    }
    
    public func setNote_conducteur(note_conducteur:Int) -> Void{
        self.note_conducteur = note_conducteur
    }
    
    public func setNote_passager(note_passager:Int) -> Void{
        self.note_passager = note_passager
    }
    
}
