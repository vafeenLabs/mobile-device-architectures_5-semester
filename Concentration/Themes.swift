import Foundation
import UIKit

var currentTheme: Theme = FruitsTheme() // Тема по умолчанию

protocol Theme {
    var primaryColor: UIColor { get }          // Основной цвет приложения
    var cardColor: UIColor { get }            // Цвет карточек
    var cardBorderColor: CGColor { get }      // Цвет рамки карточек
    var buttonsColor: CGColor { get }         // Цвет кнопок
    var emojis: String { get }                // Набор эмодзи для отображения в карточках
}

struct FruitsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) // Тёмно-зелёный цвет для фона.
    let cardColor: UIColor = #colorLiteral(red: 0.6695213895, green: 1, blue: 0.6821790153, alpha: 1)              // Светло-зелёный цвет для карточек.
    let cardBorderColor: CGColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)                   // Зелёный цвет для рамок карточек.
    let buttonsColor: CGColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)                      // Зелёный цвет для кнопок.
    let emojis: String = "🍓🍇🍑🍎🍉🍋🫐🍒🍏🥭🍌🥥🍍🥝🍐🍊🍈🥑🫑🥒🌶🌽🥕🥬"           // Эмодзи фруктов и овощей.
}

struct ShapesAndColorsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) // Тёмно-синий цвет для фона.
    let cardColor: UIColor = #colorLiteral(red: 0.6707266117, green: 0.7145125138, blue: 1, alpha: 1)                // Светло-голубой цвет для карточек.
    let cardBorderColor: CGColor = #colorLiteral(red: 0, green: 0.3622836975, blue: 0.9768045545, alpha: 1)         // Голубой цвет для рамок карточек.
    let buttonsColor: CGColor = #colorLiteral(red: 0, green: 0.3622836975, blue: 0.9768045545, alpha: 1)            // Голубой цвет для кнопок.
    let emojis: String = "🔴🟡🟢🔵🟣⚫️🔶🔷🟥🟧🟩🟦🟪⬛️🟫🔺🔲🔘🟠🟤🟨♥️🔻🛑"       // Эмодзи форм и цветов.
}

struct FlagsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1) // Тёмно-красный цвет для фона.
    let cardColor: UIColor = #colorLiteral(red: 1, green: 0.6451565758, blue: 0.6110407169, alpha: 1)               // Розовый цвет для карточек.
    let cardBorderColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) // Красный цвет для рамок карточек.
    let buttonsColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)    // Красный цвет для кнопок.
    let emojis: String = "🇺🇳🇦🇺🇦🇹🇦🇿🇦🇽🇦🇱🇩🇿🇦🇸🇦🇷🇧🇾🇧🇪🇧🇬🇧🇷🇧🇯🇧🇭🇧🇼🇬🇧🏴🇭🇺🇻🇳🇬🇪🇬🇭🇬🇱🇬🇹"       // Эмодзи флагов различных стран.
}
