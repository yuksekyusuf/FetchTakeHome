//
//  ErrorMessageTextView.swift
//  FetchTakeHome
//
//  Created by Ahmet Yusuf Yuksek on 13.12.2024.
//


import SwiftUI

struct ErrorMessageTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.center)
            .foregroundColor(.indigo)
            .padding(.top, UIScreen.main.bounds.height * 0.4)
    }
}
