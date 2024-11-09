import SwiftUI

struct ContentView: View {
    @State private var expression: String = ""
    @State private var result: String = "Перевод"
    @State private var translationMode: TranslationMode = .rusToEmoji

    let emojiGroups: [EmojiGroup] =
        SmileEmoji.all + AnimalEmoji.all + FoodEmoji.all + ObjectEmoji.all + FlagEmoji.all

    var emojiDictionary: [String: String] {
        var emojiDict: [String: String] = [:]
        for emoji in emojiGroups {
            emojiDict["\(emoji)"] = emoji.value
        }
        return emojiDict
    }

    var body: some View {
        VStack(spacing: 20) {
            // Переключатель режима перевода
            Picker("Режим перевода", selection: $translationMode) {
                ForEach(TranslationMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            // Отображение результата
            Text(result)
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()

            // Поле ввода выражения
            TextField("Введите слова/эмоджи", text: $expression)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Кнопка "Перевести"
            Button(action: translate) {
                Text("Перевести")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    // Функция для перевода текста
    func translate() {
        var translatedWords: [String] = []
        // Разбиваем введенное выражение на слова
        switch translationMode {
        case .rusToEmoji:
            let words = expression.split(separator: " ")
            for word in words {
                if let emoji = emojiDictionary[String(word).lowercased()] {
                    translatedWords.append(emoji)
                } else {
                    translatedWords.append("❓")
                }
            }
        case .emojiToRus:
            // Создаем словарь с обратными ключами и значениями
            let reversedDictionary =
                Dictionary(uniqueKeysWithValues: emojiDictionary.map { ($1, $0) })
            let words = Array(expression.replacingOccurrences(of: " ", with: ""))
            for word in words {
                if let rus = reversedDictionary[String(word)] {
                    translatedWords.append(rus)
                } else {
                    translatedWords.append("неизвестное эмоджи")
                }
            }
        }
        // Соединяем слова в одну строку
        result = translatedWords.joined(separator: " ")
    }
}

enum TranslationMode: String, CaseIterable, Identifiable {
    case rusToEmoji = "Русский -> Эмоджи"
    case emojiToRus = "Эмоджи -> Русский"

    var id: String { rawValue }
}
