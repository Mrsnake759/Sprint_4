//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by artem on 18.10.2023.
//

import UIKit

final class AlertPresenter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}

extension AlertPresenter: AlertPresenterProtocol {
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.buttonAction()
        }
            
        // добавляем в алерт кнопку
        alert.addAction(action)
        
        viewController?.present(alert, animated: true)
    }
}

private func show(alertModel: AlertModel) {
    let alert = UIAlertController(
        title: alertModel.title,
        message: alertModel.text,
        preferredStyle: .alert)
    
    let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [self] _ in
        self.currentQuestionIndex = 0
        
        self.correctAnswer = 0
        
        questionFactory?.requestNextQuestion()
    }
    
    alert.addAction(action)
    
    self.present(alert, animated: true, completion: nil)
}
