import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    // MARK: - Lifecycle
    
    // переменная, которая хранит в себе текущий индекс вопроса
    private var currentQuestionIndex = 0
    // переменная, которая хранит в себе количество правильных вопросов
    private var correctAnswer = 0
    // общее количество вопросов для квиза. Пусть оно будет равно десяти
    private let questionsAmount: Int = 10
    // фабрика вопросов. Контроллер будет обращаться за вопросами к ней
    private var questionFactory: QuestionFactoryProtocol = QuestionFactory()
    // вопрос, который видит пользователь
    private var currentQuestion: QuizQuestion?
    // для вызова алерта, контроллер будет обращаться к этой переменной
    private var alertPresenter: AlertPresenter?
    // переменная для показа статистики
    private var statisticService: StatisticServiceProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionFactory = QuestionFactory()
        questionFactory.setup(delegate: self)
        self.questionFactory = questionFactory
        
        questionFactory.requestNextQuestion()
        
        alertPresenter = AlertPresenter(view: self)
        
        statisticService = StatisticService()
    }

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }

        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    // метод конвертации мокового вопроса во вью модель для главного экрана
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }
    
    // метод показа мокового вопроса на главном экране
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    // метод для подсчета правильных вопросов и покраски рамки
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswer += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {return}
            
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
            self.showNextQuestionOrResults()
        }
    }
    
    // метод, который показывает резальтат квиза или же следующий вопрос
    private func showNextQuestionOrResults(){
        
        imageView.layer.borderWidth = 0
        
        if currentQuestionIndex == questionsAmount - 1 {
            var text = "Ваш результат: \(correctAnswer)/\(questionsAmount)"
            if let statisticService = statisticService {
                statisticService.store(correct: correctAnswer, total: questionsAmount)
                text += """
                       \nКоличество сыгранных квизов: \(statisticService.gamesCount)
                       Рекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total) (\(statisticService.bestGame.date.dateTimeString))
                       Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%
                       """
            }
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            
            questionFactory.requestNextQuestion()
        }
    }
    
    // метод финального алерта
    private func show(quiz result: QuizResultsViewModel) {
         let alert = AlertModel(
             title: result.title,
             message: result.text,
             buttonText: result.buttonText
         ) { [weak self] in
             guard let self = self else { return }
             
             self.currentQuestionIndex = 0
             self.correctAnswer = 0
             self.questionFactory.requestNextQuestion()
         }
         
         alertPresenter?.showAlert(alertModel: alert)
     }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        noButton.isEnabled = false
        yesButton.isEnabled = false
        
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        noButton.isEnabled = false
        yesButton.isEnabled = false
        
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }

    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
}
