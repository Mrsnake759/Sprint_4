//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by artem on 02.04.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
