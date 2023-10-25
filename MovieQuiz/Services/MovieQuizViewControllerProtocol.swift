//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by artem on 24.10.2023.
//

import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func blockButtons()
    func unblockButtons()
    func presentAlert(alert: UIAlertController?)
}


