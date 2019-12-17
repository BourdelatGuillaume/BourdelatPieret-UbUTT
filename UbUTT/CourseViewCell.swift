//
//  CourseViewCell.swift
//  UbUTT
//
//  Created by if26-grp3 on 17/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class CourseViewCell: UITableViewCell {

    public static let cellID = "CourseViewCell"
    
    @IBOutlet weak var labelPrix: UILabel!
    @IBOutlet weak var labelDestination: UILabel!
    
    @IBAction func onTakeCoursePressed(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
