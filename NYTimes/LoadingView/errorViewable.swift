//
//  File.swift
//  NYTimes
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController: errorViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for isError() method.
    public var isError: Binder<ErrorMessage> {
        return Binder(self.base, binding: { (viewController, error) in
            viewController.showError(with: error)
        })
    }
}

protocol errorViewable {
    func showError(with: ErrorMessage)
}
extension errorViewable where Self: UIViewController {
    func showError(with: ErrorMessage) {
        let alertController =
            UIAlertController(title: with.title, message: with.message, preferredStyle: UIAlertController.Style.alert)
        let okAction =
            UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
            if let action = with.action {
                action()
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
