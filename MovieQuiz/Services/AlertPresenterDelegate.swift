//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by artem on 25.10.2023.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func didPresent(alert: UIAlertController?)
}
