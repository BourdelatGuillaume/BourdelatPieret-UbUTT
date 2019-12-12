//
//  WaitingCourseController.swift
//  UbUTT
//
//  Created by if26-grp3 on 12/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class WaitingCourseController: UITabBarController {

    var timer: Timer?
    var minute: Int = 0
    var second: Int = 0
    
    @IBOutlet weak var timerView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(WaitingCourseController.back(sender:)))
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.second = self.second + 1;
            
            // au bout de 10 minutes d'attentes, on coupe
            if(self.minute == 10 && self.second == 60){
                self.navigationController?.popToRootViewController(animated: true)
            }else if(self.second == 60){
                self.minute = self.minute + 1;
                self.second = 0;
            }
            
            let mn = self.minute < 10 ? "0"+String(self.minute) : String(self.minute)
            let sec = self.second < 10 ? "0"+String(self.second) : String(self.second)
            self.timerView.text =  mn + ":" + sec
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    @objc func back(sender: UIBarButtonItem){
        navigationController?.popToRootViewController(animated: true)
        // todo delete from database the course
    }
    
}
