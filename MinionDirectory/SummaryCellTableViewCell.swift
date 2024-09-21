//
//  SummaryCellTableViewCell.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/21/24.
//


import UIKit

class SummaryCell: UITableViewCell {

    // Outlet for the title (Stuart's name)
    @IBOutlet weak var summaryTitleLabel: UILabel!

    // Outlet for the description (Stuart's details)
    @IBOutlet weak var summaryDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
