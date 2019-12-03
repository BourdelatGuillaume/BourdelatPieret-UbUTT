//
//  BDConnection.swift
//  UbUTT
//
//  Created by if26-grp3 on 28/11/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation
import CommonCrypto

public class BDConnection{
    
    private var res:Any?
    
    private func connexionPage(page:String, requete:String, parametres:String){
        let now = Date()
        let format = DateFormatter() 
        format.dateFormat = "dd-MM-yyyy"
        var mdp:String = sha512(string:"GE"+format.string(from:now)+"IF26"+requete+parametres)
        //let params="requete="+requete+"&mdp="+mdp
        let params = ["requete":requete,"mdp":mdp]
        
        var request = URLRequest(url: URL(string: page)!)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        //request.httpBody = params.data(using: String.Encoding.utf8)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            //print(response!)
            let httpResponse = response as! HTTPURLResponse
            print("response code = \(httpResponse.statusCode)")
            let dataRes:Data? = "[{\"id_utilisateur\": \"1\",\"nom_utilisateur\": \"Bob\",\"prenom_utilisateur\": \"Erwan\",\"adresse_email\": \"bob.erwan@gmail.com\",\"num_telephone\": \"+33606407808\",\"password\": \"test1234\",\"id_image\": \"0\"}]".data(using: .utf8)

            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let json = dataRes else {
                print("No data")
                return
            }
            
            guard json.count != 0 else {
                print("Zero bytes of data")
                return
            }
            //print(String(decoding: json, as: UTF8.self))
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
                    as? [[String: Any]] else {
                        print("noJSON")
                        return
                }
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    public func execute(page:String,requete:String, parametres:String)->Any{
        self.connexionPage(page: page, requete: requete, parametres: parametres)
        return self.res
    }
    
    func sha512(string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            data.withUnsafeBytes {
                _ = CC_SHA512($0, CC_LONG(data.count), &digest)
            }
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}