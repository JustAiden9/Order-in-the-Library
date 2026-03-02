//
//  PickMenuView.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct PickMenuView: View {
    var body: some View {
        List {
            Section("Choose a Level") {
                NavigationLink {
                    BookSortScreen(level: 1)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Level 1")
                            .font(.headline)
                        Text("Sort by Dewey numbers 3 Books")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                NavigationLink {
                    BookSortScreen(level: 2)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Level 2")
                            .font(.headline)
                        Text("Sort by Dewey numbers 5 Books")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                NavigationLink {
                    BookSortScreen(level: 3)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Level 3")
                            .font(.headline)
                        Text("Sort by Dewey numbers 8 Books")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Pick a Level")
    }
}

#Preview {
    NavigationStack { PickMenuView() }
}
