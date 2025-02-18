import PDFKit
import SwiftUI

struct PDFKitView: View {
    var url: URL
    var body: some View {
        NavigationStack {
            PDFKitRepresentedView(url)
        }
        .navigationBarTitle("Политика конфиденциальности", displayMode: .inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {}
}
