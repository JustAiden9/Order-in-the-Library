//
//  BookSortScreen.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct BookSortScreen: View {
    let level: Int

    // how many books depends on the level
    private var bookCount: Int {
        switch level {
        case 1: return 3
        case 2: return 5
        default: return 8
        }
    }

    private var description: String {
        "Sort \(bookCount) books by their Dewey Decimal numbers."
    }

    // these hold our data
    @State private var books: [Book] = []
    @State private var isLoading = true

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

            if isLoading {
                // show a spinner while we wait for the api
                ProgressView("Loading books...")
                    .padding()
            } else {
                // show the books in a scrollable row like a shelf
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(books) { book in
                            BookCardView(
                                title: book.title ?? "Unknown",
                                author: book.author_name?.first ?? "Unknown",
                                ddc: book.ddc?.first ?? "No DDC"
                            )
                        }
                    }
                    .padding(.horizontal)
                }

                // lil hint for the player
                Text("Sort these by DDC number, smallest to largest!")
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Level \(level)")
        .task {
            // this runs when the screen shows up
            await loadBooks()
        }
    }

    // pulls books from the api and picks random ones for the specific level
    func loadBooks() async {
        isLoading = true
        let allBooks = await fetchBooks()

        // shuffle and pick the right amount for this level
        let shuffled = allBooks.shuffled()
        let picked = Array(shuffled.prefix(bookCount))

        books = picked
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        BookSortScreen(level: 1)
    }
}
