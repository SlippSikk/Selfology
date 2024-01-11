//
//  PlusButton.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        Image(systemName: "plus")
            .font(.system(size: 80))
            .fontWeight(.thin)
            .foregroundColor(Color(#colorLiteral(red: 0.17, green: 0.17, blue: 0.17, alpha: 1))) // Hex #2b2b2b
            .padding(.top, 10)
            .padding(.trailing, 20)
    }
}

#Preview {
    PlusButton()
}
