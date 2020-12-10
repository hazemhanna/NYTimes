//
//  ArticalCell.swift
//  NYTimes
//
//  Created by MAC on 12/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import  Kingfisher

class ArticalCell: UITableViewCell {

     @IBOutlet weak var articalNameLabel: UILabel!
     @IBOutlet weak var writenByLabel : UILabel!
     @IBOutlet weak var typeLabel: UILabel!
     @IBOutlet weak var timeLabel: UILabel!

    var openDetailsAction: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func config(articalName: String, writenBy: String, time: String,type: String) {
        
        self.articalNameLabel.text = articalName
        timeLabel.text = time
        writenByLabel.text = writenBy
        typeLabel.text  = type
    }
    
    @IBAction func GoForDetailsAction(_ sender: UIButton) {
           openDetailsAction?()
       }
    
}
