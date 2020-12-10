//
//  File.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import RxSwift

class ArticalesViewModel: BaseViewModel{
    // MARK: - Observers
    let isSuccess: PublishSubject<[Result]> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    
    // MARK: - Variables
    let disposeBag: DisposeBag = DisposeBag()
    let articalRepo : ArticalRepository
    
    var userDefaults = UserDefaults.standard
    public init (_ repo: ArticalRepository = ArticalRepository()) {
        articalRepo = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    func getArticalesList() {
        isLoading.onNext(true)
        articalRepo.getArticalList(){ [weak self] (result) in
            guard let self = self else {return}
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? ArticalesModelJSON{
                    switch data.status {
                    case "OK":
                        if let articalList = data.results {
                            self.isSuccess.onNext(articalList)
                        }
                    default:
                        let error =
                            ErrorMessage(title: "Error", message: "Error ", action: nil)
                        self.isError.onNext(error)
                    }
                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }
}



