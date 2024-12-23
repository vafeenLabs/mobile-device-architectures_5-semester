import Foundation

// Структура для игры
struct Concentration {
    
    // Массив карточек, доступных в игре
    private (set) var cards = [Card]()
    
    // Счет игры
    var score = 0
    
    // Флаг, который указывает, была ли использована подсказка
    private (set) var isHintUsed = false
    
    // Индекс одной перевернутой карточки
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        // Геттер: Получаем индекс карточки, которая перевернута лицом вверх
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly 
        }
        
        // Сеттер: Устанавливаем одну перевернутую карточку
        set {
            // Переворачиваем только ту карточку, которая соответствует новому значению индекса
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue) 
            }
        }
    }
    
    // Метод для выбора карточки
    mutating func chooseCard(at index: Int) {
        // Проверка, что индекс карточки валиден (находится в пределах массива)
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        // Проверяем, что карточка не совпала (не имеет метки isMatched)
        if !cards[index].isMatched {
            
            // Если есть одна перевернутая карточка, то пытаемся найти пару
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // Если карточки совпали, помечаем их как совпавшие
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true  // Помечаем первую карточку как совпавшую
                    cards[index].isMatched = true      // Помечаем вторую карточку как совпавшую
                    score += 1  // Увеличиваем счет на 1
                    cards[matchIndex].isGuessed = true // Помечаем первую карточку как угаданную
                    cards[index].isGuessed = true      // Помечаем вторую карточку как угаданную
                    
                } else {
                    score -= 2  // Если карточки не совпали, уменьшаем счет на 2
                }
                
                // Переворачиваем выбранную карточку лицом вверх
                cards[index].isFaceUp = true
                
                // Сбрасываем индекс перевернутой карточки
                indexOfOneAndOnlyFaceUpCard = nil 
            } else {
                // Если нет перевернутой карточки, переворачиваем текущую
                indexOfOneAndOnlyFaceUpCard = index 
            }
        }
    }
    
    // Метод для переворачивания всех карточек лицом вверх
    mutating func flipAllCardsFaceUp() {
        // Проходим по всем карточкам и переворачиваем их лицом вверх, если они не совпали
        for index in cards.indices {
            if !cards[index].isMatched {
                cards[index].isFaceUp = true 
            }
        }
    }
    
    // Метод для переворачивания всех карточек лицом вниз
    mutating func flipAllCardsFaceDown() {
        // Проходим по всем карточкам и переворачиваем их лицом вниз
        for index in cards.indices {
            cards[index].isFaceUp = false 
        }
    }
    
    // Метод для перемешивания карточек
    mutating func shuffleCards() {
        // Перемешиваем массив карточек случайным образом
        cards.shuffle() 
    }
    
    // Метод для использования подсказки
    mutating func useHint() {
        isHintUsed = true  // Помечаем, что подсказка была использована 
    }
    
    // Инициализатор для создания игры с заданным количеством пар карточек
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): must have at least one pair of cards") 
       
        for _ in 1...numberOfPairsOfCards { 
            let card = Card()  // Создаем новую карточку 
            cards += [card, card]  // Добавляем пару одинаковых карточек в массив 
        }
        
        cards.shuffle()  // Перемешиваем карточки, чтобы они не шли подряд 
    }
}

// Расширение для коллекций, чтобы получить единственный элемент 
extension Collection { 
    var oneAndOnly: Element? { 
        return count == 1 ? first : nil  // Если коллекция состоит из одного элемента, возвращаем его 
    } 
}
