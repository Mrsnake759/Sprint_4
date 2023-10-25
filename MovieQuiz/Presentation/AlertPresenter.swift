//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by artem on 17.10.2023.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?
    private var alert: UIAlertController?
    private var action: UIAlertAction?
    
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func show(model: AlertModel) {
        alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        action = UIAlertAction(title: model.buttonText, style: .default) {_ in
            model.buttonAction()
        }
        alert?.view.accessibilityIdentifier = "Этот раунд окончен!"
        alert?.addAction(action ?? UIAlertAction())
        delegate?.didPresent(alert: alert)
    }
}
