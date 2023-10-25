import Foundation

protocol AlertPresenterProtocol {
    var delegate: AlertPresenterDelegate? { get set}
    func show(model: AlertModel)
}
