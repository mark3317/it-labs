import SwiftUI

extension Color {    
    // Преобразование Color в Hex-строку
    func toHex() -> String {
        let components = self.cgColor?.components ?? [0, 0, 0]
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
