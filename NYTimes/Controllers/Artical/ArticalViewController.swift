//
//  ArticalViewController.swift
//  NYTimes
//
//  Created by MAC on 12/9/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticalViewController: UIViewController {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var articalTableView: UITableView!
    private let CellIdentifier = "ArticalCell"
    
    
    var viewModel = ArticalesViewModel()
    var articales  = [Result](){
        didSet {
            DispatchQueue.main.async {
                
            }
        }
    }
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        setupContentTableView()
        
        createCallbacks()
        viewModel.getArticalesList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
}



extension ArticalViewController {
    // MARK: - CallBack
    func createCallbacks() {
        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
        viewModel
            .isSuccess
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (data) in
                self.articales = data
            }).disposed(by: disposeBag)
        
    }
    
}




extension ArticalViewController : UITableViewDelegate {
    
    func setupContentTableView() {
        
        self.articalTableView.register(UINib(nibName: self.CellIdentifier, bundle: nil), forCellReuseIdentifier: self.CellIdentifier)
        
        self.articalTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.viewModel.isSuccess.bind(to: self.articalTableView.rx.items(cellIdentifier: self.CellIdentifier, cellType: ArticalCell.self)) { index, element, cell in
            
            cell.config(articalName: self.articales[index].title ?? ""
                , writenBy: self.articales[index].byline ?? ""
                , time: self.articales[index].publishedDate ?? ""
                , type:  self.articales[index].type ?? "")
            cell.openDetailsAction = {
                let destinationVC = ArticalDetailsVC.instantiateFromNib()
                destinationVC?.articales = self.articales[index]
                self.navigationController!.pushViewController(destinationVC!, animated: true)
            }
        }.disposed(by: disposeBag)
        
        self.articalTableView.rx.itemSelected.bind { (indexPath) in
            let destinationVC = ArticalDetailsVC.instantiateFromNib()
            destinationVC?.articales = self.articales[indexPath.row]
            self.navigationController!.pushViewController(destinationVC!, animated: true)
            
        }.disposed(by: disposeBag)
        self.articalTableView.rx.contentOffset.bind { (contentOffset) in
            
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
}



