//
//  Themes.swift
//  Concentration
//
//  Created by nadya on 23.01.2024.
//

import Foundation
import UIKit

var currentTheme: Theme = FruitsTheme()

protocol Theme {
    var primaryColor: UIColor { get }
    var cardColor: UIColor { get }
    var cardBorderColor: CGColor { get }
    var buttonsColor: CGColor { get }
    var emojis: String { get }
}

struct FruitsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
    let cardColor: UIColor = #colorLiteral(red: 0.6695213895, green: 1, blue: 0.6821790153, alpha: 1)
    let cardBorderColor: CGColor = #colorLiteral(red: 0.5063639831, green: 0.9768045545, blue: 0.4476487256, alpha: 1)
    let buttonsColor: CGColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    let emojis: String = "🍓🍇🍑🍎🍉🍋🫐🍒🍏🥭🍌🥥🍍🥝🍐🍊🍈🥑🫑🥒🌶🌽🥕🥬"
}

struct ShapesAndColorsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    let cardColor: UIColor = #colorLiteral(red: 0.6707266117, green: 0.7145125138, blue: 1, alpha: 1)
    let cardBorderColor: CGColor = #colorLiteral(red: 0.4583597233, green: 0.4728832298, blue: 0.9768045545, alpha: 1)
    let buttonsColor: CGColor = #colorLiteral(red: 0, green: 0.3622836975, blue: 0.9768045545, alpha: 1)
    let emojis: String = "🔴🟡🟢🔵🟣⚫️🔶🔷🟥🟧🟩🟦🟪⬛️🟫🔺🔲🔘🟠🟤🟨♥️🔻🛑"
}

struct FlagsTheme: Theme {
    let primaryColor: UIColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
    let cardColor: UIColor = #colorLiteral(red: 1, green: 0.6451565758, blue: 0.6110407169, alpha: 1)
    let cardBorderColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.4360978603, blue: 0.4503793745, alpha: 1)
    let buttonsColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let emojis: String = "🇺🇳🇦🇺🇦🇹🇦🇿🇦🇽🇦🇱🇩🇿🇦🇸🇦🇷🇧🇾🇧🇪🇧🇬🇧🇷🇧🇯🇧🇭🇧🇼🇬🇧🏴󠁧󠁢󠁥󠁮󠁧󠁿🇭🇺🇻🇳🇬🇪🇬🇭🇬🇱🇬🇹"
}
