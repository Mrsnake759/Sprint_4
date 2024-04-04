//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by artem on 02.04.2024.
//

import Foundation
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    
    weak var view: UIViewController?
    init (view: UIViewController) {
        self.view = view
    }
    
    func showAlert(alertModel: AlertModel) {
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
