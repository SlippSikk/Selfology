//
//  DynamicHeightTextEditor.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 13/3/2024.
//

import SwiftUI


struct DynamicHeightTextEditor: View {
    @Binding var text: String
    @State private var height: CGFloat = 0 // Default height

    var body: some View {
        TextEditor(text: $text)
            .font(.subheadline)
            .frame(height: height)
            .onChange(of: text) { _ in
                // Recalculate height whenever text changes
                self.height = self.calculateHeight()
            }
            .onAppear {
                // Initial calculation on appear
                self.height = self.calculateHeight()
            }
    }

    private func calculateHeight() -> CGFloat {
        let textView = UITextView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: .greatestFiniteMagnitude))
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textView.text = self.text
        textView.sizeToFit()
        return textView.frame.height
    }
}


