//
//  HistoricViewCell.swift
//  UbUTT
//
//  Created by if26-grp1 on 13/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit

class HistoricViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var prix: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var modele: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var statut: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
