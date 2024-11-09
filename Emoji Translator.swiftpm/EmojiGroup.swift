// Протокол для групп эмодзи
protocol EmojiGroup {
    var value: String { get }
    static var all: [Self] { get }
}

// Перечисление для смайлов
enum SmileEmoji: String, EmojiGroup {
    case улыбка = "😊"
    case смех = "😂"
    case подмигивание = "😉"
    case грусть = "😢"
    case злость = "😠"
    case удивление = "😲"
    case поцелуй = "😘"
    case задумчивость = "🤔"
    case сон = "😴"
    case страх = "😱"
    
    var value: String { rawValue }
    
    static var all: [SmileEmoji] = [.улыбка, .смех, .подмигивание, .грусть, .злость, .удивление, .поцелуй, .задумчивость, .сон, .страх]
}

// Перечисление для животных
enum AnimalEmoji: String, EmojiGroup {
    case собака = "🐶"
    case кошка = "🐱"
    case мышь = "🐭"
    case кролик = "🐰"
    case лиса = "🦊"
    case медведь = "🐻"
    case панда = "🐼"
    case тигр = "🐯"
    case лев = "🦁"
    case слон = "🐘"
    
    var value: String { rawValue }

    static var all: [AnimalEmoji] = [.собака, .кошка, .мышь, .кролик, .лиса, .медведь, .панда, .тигр, .лев, .слон]
}

// Перечисление для еды
enum FoodEmoji: String, EmojiGroup {
    case яблоко = "🍎"
    case банан = "🍌"
    case виноград = "🍇"
    case арбуз = "🍉"
    case клубника = "🍓"
    case лимон = "🍋"
    case пицца = "🍕"
    case бургер = "🍔"
    case суши = "🍣"
    case мороженое = "🍦"
    
    var value: String { rawValue }

    static var all: [FoodEmoji] = [.яблоко, .банан, .виноград, .арбуз, .клубника, .лимон, .пицца, .бургер, .суши, .мороженое]
}

// Перечисление для предметов
enum ObjectEmoji: String, EmojiGroup {
    case телефон = "📱"
    case компьютер = "💻"
    case часы = "⌚"
    case лампа = "💡"
    case книга = "📖"
    case ручка = "🖊️"
    case ключ = "🔑"
    case зонт = "☂️"
    case очки = "👓"
    case фотоаппарат = "📷"
    
    var value: String { rawValue }

    static var all: [ObjectEmoji] = [.телефон, .компьютер, .часы, .лампа, .книга, .ручка, .ключ, .зонт, .очки, .фотоаппарат]
}

// Перечисление для флагов
enum FlagEmoji: String, EmojiGroup {
    case россия = "🇷🇺"
    case сша = "🇺🇸"
    case канада = "🇨🇦"
    case бразилия = "🇧🇷"
    case китай = "🇨🇳"
    case япония = "🇯🇵"
    case германия = "🇩🇪"
    case франция = "🇫🇷"
    case италия = "🇮🇹"
    case индия = "🇮🇳"
    
    var value: String { rawValue }

    static var all: [FlagEmoji] = [.россия, .сша, .канада, .бразилия, .китай, .япония, .германия, .франция, .италия, .индия]
}
