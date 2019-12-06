//
//  SQLRequest.swift
//  UbUTT
//
//  Created by if26-grp1 on 05/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

/**
 * Classe reprÃ©sentant un utilisateur de l'application
 */
public class SQLRequest<E:Entity>{
    private var requete:String?
    private var parametre:Array<String>
    
    private let NoResult:String    = "https://appliweb.000webhostapp.com/if26/SQLNoResultIOS.php"
    private let OneResult:String = "https://appliweb.000webhostapp.com/if26/SQLOneResultIOS.php"
    private let MultipleResult:String    = "https://appliweb.000webhostapp.com/if26/SQLMultipleResultIOS.php"
    
    init(){
        self.parametre=Array()
    }
    
    public func prepare(requete:String) -> Void{
        self.parametre.removeAll()
        self.requete = requete
    }
    
    public func addParametres(parametre:Array<String>) -> Void{
        self.parametre.append(contentsOf:parametre)
    }
    
    public func executerNoResult() -> Void{
        let bd:BDConnection = BDConnection()
        bd.execute(page:self.NoResult, requete:self.requete!, parametres:arrayToString(liste:self.parametre))
    }
    
    public func executerOneResult() -> E?{
        let bd:BDConnection = BDConnection()
        let data:Data? = bd.execute(page:self.OneResult, requete:self.requete!, parametres:arrayToString(liste:self.parametre))
        if(data != nil){
            do {
             guard let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
             as? [String: Any] else {
                print("noJSON")
                return nil
             }
                return E.init(dictionary: jsonObject)
             } catch  {
                print("error trying to convert data to JSON")
                return nil
             }
        }
        return nil
    }
    
    public func executerMultipleResult() -> Array<E>{
        let bd:BDConnection = BDConnection()
        var array:Array<E>=Array()
        let data:Data? = bd.execute(page:self.MultipleResult, requete:self.requete!, parametres:arrayToString(liste:self.parametre))
        if(data != nil){
            do {
                guard let jsonObjects = try JSONSerialization.jsonObject(with: data!, options: [])
                    as? [[String: Any]] else {
                        print("noJSON")
                        return array
                }
                for jsonObject in jsonObjects{
                    array.append(E.init(dictionary: jsonObject))
                }
                return array
            } catch  {
                print("error trying to convert data to JSON")
                return array
            }
        }
        return array
    }
    
    private func arrayToString(liste:Array<String>) -> String{
        if(liste.count>0){
        var res:String=""
        for i in 0..<liste.count-1 {
            res += liste[i] + "¤"
        }
            return res+liste[liste.count-1]
            
        } else {
            return ""
        }
    }
}
