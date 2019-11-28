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
        var mdp:String = sha512(string:"GE"+"28-11-2019"+"IF26"+requete+parametres)
        let params = ["requete":requete, "parametre":parametres,"mdp":mdp] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: page)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            let httpResponse = response as! HTTPURLResponse
            print("response code = \(httpResponse.statusCode)")
            
            do {
                self.res = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(self.res!)
                
            } catch {
                print("error")
            }
        })
        
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
