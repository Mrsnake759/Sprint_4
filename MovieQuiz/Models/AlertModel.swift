//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by artem on 02.04.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
}
