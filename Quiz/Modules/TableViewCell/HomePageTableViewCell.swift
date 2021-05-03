//
//  HomePageTableViewCell.swift
//  Quiz
//
//  Created by SRV InfoTech on 10/05/20.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!{
        didSet{
            mainView.layer.cornerRadius = 4
            mainView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
