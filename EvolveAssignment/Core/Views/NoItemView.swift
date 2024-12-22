//
//  NoItemView.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 22/12/24.
//

import SwiftUI

struct NoItemView: View {
    private var title: String = "No Items to Show"
    var body: some View {
        ZStack {
            Color.black
            Text(title)
                .font(.custom(Fonts.Poppins_Bold, size: 28))
                .foregroundStyle(.white)
        }
        .background(Color.black)
    }
}

#Preview {
    NoItemView()
}
