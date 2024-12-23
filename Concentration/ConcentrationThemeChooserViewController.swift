import UIKit // Импортируем UIKit для работы с пользовательским интерфейсом

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    // Массив с возможными темами для игры
    let themes: [String] = [
        "Fruits", // Тема "Фрукты"
        "Shapes&Colors", // Тема "Формы и цвета"
        "Flags" // Тема "Флаги"
    ]
    
    // Вычисляемое свойство для получения детального контроллера в Split View
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController // Возвращаем последний контроллер в Split View
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController? // Переменная для хранения последнего контроллера
    
    // IBOutlet для кнопок выбора уровня сложности и темы
    @IBOutlet weak var beginnerDifficultyLevelButton: UIButton! // Кнопка выбора уровня сложности "Начинающий"
    @IBOutlet weak var mediumDifficultyLevelButton: UIButton! // Кнопка выбора уровня сложности "Средний"
    @IBOutlet weak var masterDifficultyLevelButton: UIButton! // Кнопка выбора уровня сложности "Мастер"
    @IBOutlet weak var randomThemeButton: UIButton! // Кнопка выбора случайной темы
    @IBOutlet weak var fruitsThemeButton: UIButton! // Кнопка выбора темы "Фрукты"
    @IBOutlet weak var shapesAndColorsThemeButton: UIButton! // Кнопка выбора темы "Формы и цвета"
    @IBOutlet weak var flagsThemeButton: UIButton! // Кнопка выбора темы "Флаги"

    // Этот метод вызывается после того, как контроллер загружен из интерфейсного файла (Storyboard или XIB).
    override func viewDidLoad() {
        super.viewDidLoad() // Вызываем метод родительского класса
        
        view.backgroundColor = currentTheme.primaryColor // Устанавливаем цвет фона в соответствии с текущей темой
        
        // Устанавливаем цвет фона для кнопок в соответствии с текущей темой
        randomThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        fruitsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        shapesAndColorsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        flagsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        
        // Устанавливаем радиус закругления углов для кнопок
        [beginnerDifficultyLevelButton, mediumDifficultyLevelButton, masterDifficultyLevelButton, randomThemeButton, fruitsThemeButton, shapesAndColorsThemeButton, flagsThemeButton].forEach {
            $0?.layer.cornerRadius = 10 
        }
    }

    // Этот метод вызывается, когда контроллер загружен из интерфейсного файла, но до того, как он будет показан на экране.
    override func awakeFromNib() {
        super.awakeFromNib() // Вызываем метод родительского класса
        splitViewController?.delegate = self // Устанавливаем делегата для Split View Controller
    }

    // Метод делегата UISplitViewControllerDelegate для обработки коллапса представлений
    func splitViewController(_: UISplitViewController, topColumnForCollapsingToProposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary // Возвращаем основной столбец при сжатии представлений
    }

    // Метод для получения уровня сложности по названию кнопки
    private func getDifficultyFromTitle(_ title: String?) -> Difficulty? {
        switch title {
            case " Beginner ": return .beginner // Возвращаем уровень сложности "Начинающий"
            case " Medium ": return .medium // Возвращаем уровень сложности "Средний"
            case " Master ": return .master // Возвращаем уровень сложности "Мастер"
            default: return nil // Если название не соответствует, возвращаем nil
        }
    }

    // Метод действия для выбора уровня сложности
    @IBAction func chooseDifficulty(_ sender: Any) {
        let difficultyLevel = (sender as? UIButton)?.currentTitle // Получаем название уровня сложности из нажатой кнопки
        
        if let cvc = splitViewDetailConcentrationViewController {
            cvc.difficultyLevel = getDifficultyFromTitle(difficultyLevel) // Устанавливаем уровень сложности в детальном контроллере
        } else if let cvc = lastSeguedToConcentrationViewController {
            cvc.difficultyLevel = getDifficultyFromTitle(difficultyLevel) // Устанавливаем уровень сложности в последнем контроллере
            navigationController?.pushViewController(cvc, animated: true) // Переходим к последнему контроллеру
        } else {
            performSegue(withIdentifier: "Choose Difficulty", sender: sender) // Выполняем переход к экрану выбора уровня сложности
        }
    }

    // Метод для обновления пользовательского интерфейса в соответствии с темой
    private func updateUIForTheme() {
        view.backgroundColor = currentTheme.primaryColor // Устанавливаем цвет фона в соответствии с текущей темой
        
        // Устанавливаем цвет фона для кнопок в соответствии с текущей темой
        randomThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        fruitsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        shapesAndColorsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
        flagsThemeButton.layer.backgroundColor = currentTheme.buttonsColor
    }

    // Метод действия для изменения темы игры
    @IBAction func changeTheme(_ sender: Any) {
        let themeName = (sender as? UIButton)?.currentTitle // Получаем название темы из нажатой кнопки
        
        if themeName == " Random " { 
            let randomTheme = themes.randomElement()! // Выбираем случайную тему из массива тем
            
            if let cvc = splitViewDetailConcentrationViewController {
                cvc.setTheme(themeName: randomTheme) // Устанавливаем случайную тему в детальном контроллере
            } else if let cvc = lastSeguedToConcentrationViewController {
                cvc.setTheme(themeName: randomTheme) // Устанавливаем случайную тему в последнем контроллере
                navigationController?.pushViewController(cvc, animated: true) // Переходим к последнему контроллеру
            } else {
                performSegue(withIdentifier: "Choose Theme", sender: sender) // Выполняем переход к экрану выбора темы
            }
        } else { 
            if let cvc = splitViewDetailConcentrationViewController {
                if let themeName = (sender as? UIButton)?.currentTitle {
                    cvc.setTheme(themeName: themeName) // Устанавливаем тему в детальном контроллере
                }
            } else if let cvc = lastSeguedToConcentrationViewController {
                if let themeName = (sender as? UIButton)?.currentTitle {
                    cvc.setTheme(themeName: themeName) // Устанавливаем тему в последнем контроллере
                }
                navigationController?.pushViewController(cvc, animated: true) // Переходим к последнему контроллеру
            } else {
                performSegue(withIdentifier: "Choose Theme", sender: sender) // Выполняем переход к экрану выбора темы
            }
        }
    }

    // Используется для подготовки данных перед переходом (сегвеем) от одного контроллера к другому
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Choose Theme" { 
            var themeName = (sender as? UIButton)?.currentTitle  // Получаем название темы из нажатой кнопки
            
            if themeName == " Random " { 
                themeName = themes.randomElement()  // Выбираем случайную тему из массива тем
                
                if let cvc = segue.destination as? ConcentrationViewController { 
                    cvc.setTheme(themeName: themeName!)  // Устанавливаем случайную тему в контроллере назначения
                    lastSeguedToConcentrationViewController = cvc  // Сохраняем ссылку на последний контроллер 
                }
            } else { 
                if let cvc = segue.destination as? ConcentrationViewController { 
                    cvc.setTheme(themeName: themeName!)  // Устанавливаем выбранную тему в контроллере назначения 
                    lastSeguedToConcentrationViewController = cvc  // Сохраняем ссылку на последний контроллер 
                }
            }
        }

        if segue.identifier == "Choose Difficulty" { 
            let difficultyLevel = (sender as? UIButton)?.currentTitle  // Получаем уровень сложности из нажатой кнопки
            
            if let cvc = segue.destination as? ConcentrationViewController { 
                cvc.difficultyLevel = getDifficultyFromTitle(difficultyLevel)  // Устанавливаем уровень сложности в контроллере назначения 
                lastSeguedToConcentrationViewController = cvc  // Сохраняем ссылку на последний контроллер 
            }
        }
    }
}

// Перечисление для уровней сложности игры Концентрация
enum Difficulty: Int { 
    case beginner = 8  // Уровень сложности начинающий с 8 парами карт 
    case medium = 12   // Уровень сложности средний с 12 парами карт 
    case master = 24   // Уровень сложности мастер с 24 парами карт 
}
