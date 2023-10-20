//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by artem on 17.10.2023.
//

import UIKit

class AlertPresenter {
    
    weak var view: UIViewController?
    init (view: UIViewController) {
        self.view = view
    }
    
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.buttonAction()
        }
    
        alert.addAction(action)

        view?.present(alert, animated: true, completion: nil)
    }
}
