//
//  ArticalDetailsVC.swift
//  NYTimes
//
//  Created by MAC on 12/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class ArticalDetailsVC: UIViewController {
    
    @IBOutlet weak var articalNameLabel: UILabel!
    @IBOutlet weak var writenByLabel : UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var articalImag: UIImageView!
    var articales : Result?{
        didSet{
            articalNameLabel.text =  articales?.title ?? ""
            writenByLabel.text = articales?.byline ?? ""
            typeLabel.text = articales?.type ?? ""
            timeLabel.text = articales?.publishedDate ?? ""
            let  url =  articales?.media?[0].mediaMetadata?[0].url ?? ""
            if url != ""{
                guard let url = URL(string: url ) else  { return }
                self.articalImag.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar"))
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}


