//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by artem on 04.04.2024.
//

import Foundation

struct GameRecord: Codable {
    // количество правильных ответов
    let correct: Int
    // количество вопросов квиза
    let total: Int
    // дата завершения раунда
    let date: Date
    
    func isBetterThan(_ another: GameRecord) -> Bool {
        correct > another.correct
    }
}
