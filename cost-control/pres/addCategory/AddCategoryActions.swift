import SwiftUI

protocol AddCategoryActions {
    func editName(_ name: String)
    func editColor(_ color: Color)
    func editType(_ type: TypeTransaction)
    func editIcon(_ icon: String)
    func onClickAddCategory()
}