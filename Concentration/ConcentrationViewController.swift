import UIKit

class ConcentrationViewController: UIViewController {
    
    // Таймер для подсказок
    private var hintTimer: Timer? 
    
    // Инициализация игры с заданным количеством пар карт
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairesOfCards) 
    
    // Счётчик перевёрнутых карт
    private (set) var flipCount = 0 { 
        didSet { 
            updateFlipCountLabel() // Обновляем метку счётчика перевёрнутых карт при изменении значения
        } 
    }
    
    // Обновляем метку счётчика перевёрнутых карт
    private func updateFlipCountLabel() { 
        let attributes: [NSAttributedString.Key: Any] = [:] // Создаём атрибуты для строки
        let attributedString = NSAttributedString(string: " Flips: \(flipCount) ", attributes: attributes) // Формируем строку с количеством перевёрнутых карт
        flipCountLabel.attributedText = attributedString // Устанавливаем атрибутированный текст в метку счётчика перевёрнутых карт
    }
    
    // Счётчик очков
    private (set) var scoreCount = 0 { 
        didSet { 
            updateScoreCountLabel() // Обновляем метку счётчика очков при изменении значения
        } 
    }
    
    // Обновляем метку счётчика очков
    private func updateScoreCountLabel() { 
        let attributes: [NSAttributedString.Key: Any] = [:] // Создаём атрибуты для строки
        let attributedString = NSAttributedString(string: " Score: \(scoreCount) ", attributes: attributes) // Формируем строку с количеством очков
        scoreCountLabel.attributedText = attributedString // Устанавливаем атрибутированный текст в метку счётчика очков
    }
    
    // Возвращаем количество пар карт, исходя из числа кнопок
    var numberOfPairesOfCards: Int { 
        return (cardButtons.count + 1) / 2 // Вычисляем количество пар карт на основе количества кнопок
    }
    
    @IBOutlet private var cardButtons: [UIButton]! // Кнопки карт, связанные с интерфейсом через IBOutlet
    
    @IBOutlet private weak var cardButtonsStack: UIStackView! // Стек для отображения кнопок карт
    
    @IBOutlet private weak var restartButton: UIButton! // Кнопка перезапуска игры
    
    @IBOutlet private weak var shuffleCardsButton: UIButton! // Кнопка для перемешивания карт
    
    @IBOutlet weak var hintButton: UIButton! // Кнопка подсказки
    
    @IBOutlet private weak var flipCountLabel: UILabel! { // Метка для отображения счётчика перевёрнутых карт
        didSet { 
            updateFlipCountLabel() // Обновляем метку при установке
        } 
    }
    
    @IBOutlet private weak var scoreCountLabel: UILabel! { // Метка для отображения счётчика очков
        didSet { 
            updateScoreCountLabel() // Обновляем метку при установке
        } 
    }
    
    private var emojiChoices = "🍓🍇🍑🍎🍉🍋🫐🍒🍏🥭🍌🥥🍍🥝🍐🍊🍈🥑🫑🥒🌶🌽🥕🥬" // Список доступных эмодзи для карточек
    
    private var emoji = [Card: String]() // Словарь для сопоставления карточек и эмодзи
    
    private var numberOfCards = 8 // Количество карточек в игре
    
    private var currentTheme: Theme = FruitsTheme() // Тема по умолчанию
    
    // Уровень сложности игры
    var difficultyLevel: Difficulty? { 
        didSet { 
            switch difficultyLevel { // Устанавливаем количество карточек в зависимости от уровня сложности
            case .beginner:
                numberOfCards = 8
            case .medium:
                numberOfCards = 12
            case .master:
                numberOfCards = 24
            default:
                numberOfCards = 12 
            }
            
            if cardButtons != nil {
                updateNumberOfCardButtons() // Обновляем количество кнопок в интерфейсе
                
                game = Concentration(numberOfPairsOfCards: numberOfPairesOfCards) // Создаём новую игру
                
                updateViewFromModel() // Обновляем отображение на экране в соответствии с моделью игры
            }
        } 
    }
    
    // Устанавливаем тему игры на основе названия темы
    func setTheme(themeName: String) { 
        switch themeName {
        case " Fruits ": 
            currentTheme = FruitsTheme() // Устанавливаем тему "Фрукты"
        case " Shapes&Colors ": 
            currentTheme = ShapesAndColorsTheme() // Устанавливаем тему "Формы и цвета"
        case " Flags ": 
            currentTheme = FlagsTheme() // Устанавливаем тему "Флаги"
        default:
            break 
        }
        
        updateUIForTheme() // Обновляем пользовательский интерфейс для выбранной темы
    }
    
    // Обновляем UI в зависимости от выбранной темы
    func updateUIForTheme() { 
        view.backgroundColor = currentTheme.primaryColor // Устанавливаем цвет фона в зависимости от темы
        
        cardButtons.forEach { button in 
            button.backgroundColor = currentTheme.cardColor // Устанавливаем цвет фона кнопок карточек
            button.layer.borderColor = currentTheme.cardBorderColor // Устанавливаем цвет рамки кнопок карточек
        }
        
        restartButton.layer.backgroundColor = currentTheme.buttonsColor  // Устанавливаем цвет фона кнопки перезапуска игры
        hintButton.layer.backgroundColor = currentTheme.buttonsColor  // Устанавливаем цвет фона кнопки подсказки
        shuffleCardsButton.layer.backgroundColor = currentTheme.buttonsColor  // Устанавливаем цвет фона кнопки перемешивания карт
    }
    
    // Обновляем количество кнопок карточек в зависимости от количества карточек в игре
    func updateNumberOfCardButtons() {
        if cardButtons != nil {
            cardButtons.removeAll()  // Очищаем массив кнопок перед добавлением новых
            
        }
        
        cardButtonsStack.arrangedSubviews.forEach { buttonView in 
            cardButtonsStack.removeArrangedSubview(buttonView)  // Убираем старые кнопки из стека
            buttonView.removeFromSuperview()  // Удаляем старые кнопки из представления интерфейса
        }

        let rows = Int(numberOfCards / 4)  // Вычисляем количество строк для отображения карточек
        
        let cols = Int(numberOfCards / rows)  // Вычисляем количество столбцов для отображения карточек
        
        for _ in 1...rows {  // Добавляем новые кнопки в стек по строкам
            
            let rowCardStack = UIStackView()  // Создаём новый стек для строки
            
            rowCardStack.spacing = 10  // Задаём расстояние между кнопками
            
            rowCardStack.distribution = UIStackView.Distribution.fillEqually  // Задаём равное распределение пространства
            
            for _ in 1...cols {  
                let cardButton = UIButton()  // Создаём новую кнопку карточки
                
                cardButton.layer.cornerRadius = 8  // Закругляем углы кнопки
                
                cardButton.layer.borderWidth = 2  // Задаём ширину рамки кнопки
                
                cardButton.layer.borderColor = currentTheme.cardBorderColor  // Задаём цвет рамки кнопки
                
                cardButton.addTarget(self, action: #selector(touchCard(_:)), for: .touchUpInside)  // Добавляем обработчик нажатия на кнопку
                
                cardButtons.append(cardButton)  // Добавляем кнопку в массив карточек
                
                rowCardStack.addArrangedSubview(cardButton)  // Добавляем кнопку в стек строки
                
            }
            
            cardButtonsStack.addArrangedSubview(rowCardStack)  // Добавляем стек строки в основной стек карточек
            
        }
        
    }

    // Метод viewDidLoad вызывается после загрузки представления контроллера.
    // Здесь мы выполняем начальную настройку интерфейса и элементов управления.
   override func viewDidLoad() {
   
    super.viewDidLoad() // Вызываем метод родительского класса для выполнения стандартной инициализации

    flipCountLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)  
    // Устанавливаем цвет фона метки счётчика перевёрнутых карт в белый

    scoreCountLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)  
    // Устанавливаем цвет фона метки счётчика очков в белый

    view.backgroundColor = currentTheme.primaryColor  
    // Устанавливаем цвет фона основного представления в соответствии с основной цветовой схемой текущей темы

    updateNumberOfCardButtons()   // Обновляем количество кнопок карточек на экране

    for card in cardButtons {  
        card.layer.cornerRadius = 8   // Закругляем углы всех кнопок 
    }  

    restartButton.layer.backgroundColor = currentTheme.buttonsColor   // Устанавливаем цвет фона кнопки перезапуска в соответствии с темой
    hintButton.layer.backgroundColor = currentTheme.buttonsColor   // Устанавливаем цвет фона кнопки подсказки в соответствии с темой
    shuffleCardsButton.layer.backgroundColor = currentTheme.buttonsColor   // Устанавливаем цвет фона кнопки перемешивания в соответствии с темой

    restartButton.layer.cornerRadius = 10   // Закругляем углы кнопки перезапуска для улучшения внешнего вида
    hintButton.layer.cornerRadius = 10   // Закругляем углы кнопки подсказки для улучшения внешнего вида
    shuffleCardsButton.layer.cornerRadius = 10   // Закругляем углы кнопки перемешивания для улучшения внешнего вида

    updateViewFromModel()   // Обновляем отображение на экране в соответствии с текущим состоянием модели игры
}


   @IBAction private func touchRestartGame(_ sender: UIButton) {  
       game = Concentration(numberOfPairsOfCards: numberOfPairesOfCards)   // Создаём новую игру с заданным количеством пар карточек  
       
       emojiChoices = currentTheme.emojis   // Получаем эмодзи для текущей темы  
       
       flipCount = 0   // Сбрасываем счётчик перевёрнутых карточек  
       
       scoreCount = 0   // Сбрасываем счётчик очков  
       
       emoji = [:]   // Очищаем словарь эмодзи  
       
       hintButton.layer.backgroundColor = currentTheme.buttonsColor   // Устанавливаем цвет фона кнопки подсказки  
       game.flipAllCardsFaceDown()
       
       updateViewFromModel()   // Обновляем отображение на экране в соответствии с моделью игры  
   }

   @IBAction func touchShowHint(_ sender: Any) {  
       if !game.isHintUsed {   // Проверяем, была ли использована подсказка ранее  
           game.useHint()   // Используем подсказку  
           game.flipAllCardsFaceUp()   // Переворачиваем все карты лицом вверх  
           updateViewFromModel()   // Обновляем отображение на экране  

           hintTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in   
               self.game.flipAllCardsFaceDown()   // Переворачиваем карты обратно вниз   
               self.updateViewFromModel()   // Обновляем отображение на экране   
               timer.invalidate()   // Останавливаем таймер   
           }   
       }  

       hintButton.layer.backgroundColor =
           #colorLiteral(red :0.8039215803 , green :0.8039215803 , blue :0.8039215803 , alpha :1)   
   }

   @IBAction private func touchShuffleCards(_ sender: UIButton) {  
       game.shuffleCards()   // Перемешиваем карты   
       updateViewFromModel()   // Обновляем отображение на экране   
   }

   @IBAction private func touchCard(_ sender: UIButton) {  
       flipCount += 1   // Увеличиваем счётчик перевёрнутых карт  

       if let cardNumber = cardButtons.firstIndex(of: sender) {   
           game.chooseCard(at: cardNumber)   // Выбираем карту по индексу   
           updateViewFromModel()   // Обновляем отображение на экране   
       } else {   
           print("chosen card was not in cardButtons")   
       }   
   }

   private func updateViewFromModel() {
        emojiChoices = currentTheme.emojis
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]      // Получаем кнопку по индексу из массива
            
                let card = game.cards[index]      // Получаем карту по индексу из модели игры
            
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)      // Отображаем эмодзи карты на кнопке
            
                    button.backgroundColor =
                      #colorLiteral(red :1.0 , green :1.0 , blue :1.0 , alpha :1.0)      // Меняем цвет фона на белый при перевороте карты вверх
            
                } else {
                    button.setTitle("", for: UIControl.State.normal)      // Очищаем заголовок кнопки, если карта не перевернута
            
                    button.backgroundColor =
                        card.isMatched ? #colorLiteral(red :1 , green :1 , blue :1 , alpha :0)
                        : currentTheme.cardColor      // Меняем цвет фона на прозрачный, если карта совпала, или на цвет темы, если нет
            
                }
            }
            scoreCountLabel.text =
                " Score : \(game.score)"      // Обновляем текст метки счётчика очков
        
        }
    }
      
    
    
   // Получаем эмодзи для карты
    private func emoji(for card: Card) -> String {
    // Проверяем, есть ли уже эмодзи для данной карточки и есть ли доступные эмодзи
    if emoji[card] == nil, emojiChoices.count > 0 {
            // Генерируем случайный индекс для выбора эмодзи из доступных
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices. count.arc4random)
            // Устанавливаем выбранное эмодзи для карточки и удаляем его из списка доступных эмодзи
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        // Возвращаем эмодзи для карточки или знак вопроса, если эмодзи не найдено
        return emoji[card] ?? "?" // Если эмодзи нет, показываем знак вопроса
    }

}

extension Int {
    // Расширение для случайных чисел
    var arc4random: Int {
        // Проверяем, больше ли число нуля
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) // Генерируем случайное число от 0 до self
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self)))) // Генерируем случайное отрицательное число
        } else {
            return 0 // Если число равно нулю, возвращаем 0
        }
    }
}
