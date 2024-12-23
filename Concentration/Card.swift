import Foundation

// Структура карточки, представляющая одну игровую карту
struct Card: Hashable {
    
    // Функция хэширования для уникального идентификатора карточки
    func hash(into hasher: inout Hasher) {
        // Передаём уникальный идентификатор карточки в хешер
        hasher.combine(identifier)
    }

    // Свойство hashValue возвращает уникальный идентификатор
    var hashValue: Int { return identifier }
    
    // Оператор сравнения для карточек (сравниваем по идентификатору)
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // Свойства для состояния карточки
    var isFaceUp = false      // Карточка ли перевернута лицом вверх
    var isMatched = false     // Совпала ли эта карточка с другой
    var isGuessed = false     // Были ли сделаны правильные предположения о карточке
    private var identifier: Int  // Уникальный идентификатор карточки
    
    // Статическая переменная для генерации уникальных идентификаторов
    private static var identifierFactory = 0
    
    // Функция для получения уникального идентификатора
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // Увеличиваем счётчик идентификаторов
        return identifierFactory // Возвращаем новый уникальный идентификатор
    }
    
    // Инициализатор, который присваивает уникальный идентификатор карточке
    init() {
        self.identifier = Card.getUniqueIdentifier() // Присваиваем уникальный идентификатор при создании карточки
    }
}
