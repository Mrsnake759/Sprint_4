import Foundation

protocol StatisticService {
    
    func store(correct count: Int, total amount: Int)
    
    var correct: Int { get }
    var total: Int { get }
    
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}
