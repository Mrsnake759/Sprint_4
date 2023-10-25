import Foundation

private enum Keys: String {
    case correct, total, bestGame, gamesCount
}

final class StatisticServiceImplementation: StatisticService {
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    private let userDefaults = UserDefaults.standard

    // MARK: - Public methods
    func store(correct count: Int, total amount: Int) {
        self.correct += count
        self.total += amount
        self.gamesCount += 1

        let game = GameRecord(correct: count, total: amount, date: Date())

        if game.isBetterThan(bestGame) {
            bestGame = game
        }
    }

    // MARK: - Public properties
    var totalAccuracy: Double {
        Double(correct) / Double(total) * 100
    }

    private(set) var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }

        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }


    private(set) var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
            let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }

            return record
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }

            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }

    // MARK: - Private properties
    internal var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }

        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }

    internal var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }

        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
}
