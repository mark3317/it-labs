import Foundation
import SwiftUI

struct ContentView: View {
    @State private var expression: String = ""
    @State private var result: String = "Введите выражение"

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Отображение результата
            Text(result)
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()

            // Поле ввода выражения
            TextField("Введите выражение", text: $expression)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Кнопка "Посчитать"
            Button(action: calculateResult) {
                Text("Посчитать")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }.padding()
    }

    // Функция для вычисления результата
    func calculateResult() {
        do {
            // Регулярное выражение для допустимых символов: цифры, операторы и скобки
            let validMathRegex = "^[0-9\\+\\-\\*\\/\\(\\)\\. ]+$"
            // Проверка на допустимые символы
            let regexTest = NSPredicate(format: "SELF MATCHES %@", validMathRegex)
            if !regexTest.evaluate(with: expression) {
                throw CalculationError.invalidExpression
            }
            // Добавляем .0 ко всем числам в строке
            let modifiedExpression = expression.replacingOccurrences(
                of: "(\\d+)(?!\\.\\d)",
                with: "$1.0",
                options: .regularExpression
            )
            // Пытаемся вычислить значение
            let exp = NSExpression(format: modifiedExpression)
            if let resultValue = exp.expressionValue(with: nil, context: nil) as? Double {
                // Проверяем, является ли результат целым числом
                if resultValue.truncatingRemainder(dividingBy: 1) == 0 {
                    result = "Результат: \(Int(resultValue))"
                } else {
                    result = "Результат: \(resultValue)"
                }
            } else {
                throw CalculationError.invalidExpression
            }
        } catch {
            // Обрабатываем ошибку и выводим сообщение
            result = "Ошибка: Некорректное выражение"
        }
    }
}

// Определяем enum для ошибок
enum CalculationError: Error {
    case invalidExpression
}
