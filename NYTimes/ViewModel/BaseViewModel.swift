//
//  File.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var isLoading: PublishSubject<Bool> { get }
    var isError: PublishSubject<ErrorMessage> { get }
    var disposeBag: DisposeBag { get }
}
extension BaseViewModel {
    func configureDisposeBag() {
        isError.disposed(by: disposeBag)
        isLoading.disposed(by: disposeBag)
    }
}
protocol BaseViewController {
    var disposeBag: DisposeBag { get }
}
