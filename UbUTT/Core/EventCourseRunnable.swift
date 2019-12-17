//
//  EventCourseRunnable.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation

public class EventCourseRunnable {
    
    let runQueue = DispatchQueue(label: "runnableQueue")
    var handler: (Course, String) -> Void
    var isPaused = false
    var isRunning = true
    
    var user: Utilisateur
    
    init(user: Utilisateur, completionHandler: @escaping(_ result: Course, _ error: String) -> Void){
        self.handler = completionHandler;
        self.user = user;
        runQueue.async(execute: { () -> Void in
            self.run()
        })
    }
    
    public func run() {
        if(!isPaused) {
            let courseActive:Course? = user.getCourseActive()
            handler(courseActive!, courseActive != nil ? "" : "Erreur lors de la récupération de la course active")
        }
        if(isRunning) {
            runQueue.asyncAfter(deadline: .now() + .seconds(5)){
                self.run()
            }
        }
    }
    
    public func setPause(pause: Bool){
        self.isPaused = pause;
    }
    
    public func stop(){
        self.isRunning = false;
    }
}
