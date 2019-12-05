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
public class Course:Entity{
    
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
    
    required init(){
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
        super.init()
    }
    
    required init( dictionary: [String : Any]){
        self.id_course=dictionary["id_course"] as? Int ?? 0
        self.id_conducteur=dictionary["id_conducteur"] as? Int ?? 0
        self.id_passager=dictionary["id_passager"] as? Int ?? 0
        self.id_statut=dictionary["id_statut"] as? Int ?? 0
        self.date=dictionary["date"] as? String ?? ""
        self.position_conducteur=dictionary["position_conducteur"] as? String ?? ""
        self.point_depart=dictionary["point_depart"] as? String ?? ""
        self.point_arrivee=dictionary["point_arrivee"] as? String ?? ""
        self.heure_depart=dictionary["heure_depart"] as? String ?? ""
        self.heure_arrivee=dictionary["heure_arrivee"] as? String ?? ""
        self.prix_estime=dictionary["prix_estime"] as? Double ?? 0.0
        self.note_conducteur = dictionary["note_conducteur"] as? Int ?? -1
        self.note_passager = dictionary["note_passager"] as? Int ?? -1
        super.init(dictionary: dictionary)
    }
    
    
    public func getPassager() -> Utilisateur?{
        if(self.passager == nil){
            self.passager = Utilisateur.getBDUtilisateurByID(id:self.id_passager)
        }
        return self.passager
    }
    
    public func getConducteur() -> Conducteur?{
        if(self.conducteur == nil){
            self.conducteur = Conducteur.getBDConducteurByID(id:self.id_conducteur)
        }
        return self.conducteur
    }
    
    public func getStatut() -> Statut?{
        if(self.statut == nil){
            self.statut = Statut.getBDStatutByID(id:self.id_statut)
        }
        return self.statut
    }
    
    public static func createInBD(id_utilisateur:Int, depart_lat:Double, depart_lng:Double, arrivee_lat:Double, arrivee_lng:Double, distance:Double) -> Course?{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let date:String = format.string(from:now)
        let req:SQLRequest = SQLRequest()
        req.prepare(requete:"INSERT INTO COURSE(ID_PASSAGER, DATE, POINT_DEPART, POINT_ARRIVEE, PRIX_ESTIME) VALUES(?,?,?,?,?)")
        req.addParametres(parametre: [String(id_utilisateur),date,depart_lat+","+depart_lng,arrivee_lat+","+arrivee_lng, String(0.1*distance)])
        let reqID:SQLRequest<Course> = SQLRequest()
        reqID.prepare(requete:"SELECT * FROM COURSE WHERE ID_PASSAGER, DATE, POINT_DEPART, POINT_ARRIVEE) VALUES(?,?,?,?)")
        reqID.addParametres(parametre: [String(id_utilisateur),date,depart_lat+","+depart_lng,arrivee_lat+","+arrivee_lng])
        return reqID.executerOneResult()
    }
    
    
    public static func getBDCourseByID(id:Int) -> Course?{
        let req:SQLRequest<Course> = SQLRequest<>()
        req.prepare(requete:"SELECT * FROM COURSE WHERE ID_COURSE= ?")
        req.addParametres(parametre:[String(id)])
        return req.executerOneResult()
    }
    
    public func updateNotePassager() -> Void{
        let req:SQLRequest = SQLRequest()
        req.prepare(requete: "UPDATE COURSE SET NOTE_PASSAGER = ? WHERE ID_COURSE=?")
        req.addParametres(parametre:[String(self.note_passager),String(self.id_course)])
        req.executerNoResult()
    }
    
    public func updateNoteConducteur()-> Void{
        let req:SQLRequest = SQLRequest()
        req.prepare(requete:"UPDATE COURSE SET NOTE_CONDUCTEUR = ? WHERE ID_COURSE=?")
        req.addParametres(parametre:[String(self.note_conducteur),String(self.id_course)])
        req.executerNoResult()
    }
    
    public func updateStatut()-> Void{
        let req:SQLRequest = SQLRequest()
        req.prepare(requete:"UPDATE COURSE SET ID_STATUT = ? WHERE ID_COURSE=?")
        req.addParametres(parametre:[String(self.id_statut),String(self.id_course)])
        req.executerNoResult()
    }
    
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
