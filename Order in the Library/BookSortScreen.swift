//
//  BookSortScreen.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct BookSortScreen: View {
    let level: Int

    private var description: String {
        switch level {
        case 1: return "Sort by Dewey Decimal numbers 3 Books."
        case 2: return "Sort by Dewey Decimal numbers 5 Books."
        default: return "Sort by Dewey Decimal numbers 8 Books."
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "books.vertical")
                .font(.system(size: 48))
                .foregroundStyle(.blue)
            Text("Book Sorting - Level \(level)")
                .font(.title)
                .fontWeight(.bold)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Level \(level)")
    }
}

#Preview {
    NavigationStack {
        BookSortScreen(level: 1)
    }
}
