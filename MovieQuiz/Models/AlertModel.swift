//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by artem on 18.10.2023.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
}
