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
    @AppStorage("highestUnlockedLevel") private var highestUnlockedLevel: Int = 1
    @State private var showingResult = false
    @State private var isCorrect = false

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
                List {
                    ForEach(books) { book in
                        HStack {
                            BookCardView(
                                title: book.title ?? "Unknown",
                                author: book.author_name?.first ?? "Unknown",
                                ddc: book.ddc?.first ?? "No DDC"
                            )
                            Spacer()
                        }
                    }
                    .onMove { source, destination in
                        books.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .environment(\.editMode, .constant(.active))
                .frame(height: min(CGFloat(bookCount) * 80, 400))
                .cornerRadius(12)
                
                // lil hint for the player
                Text("Sort these by DDC number, smallest to largest!")
                    .foregroundStyle(.secondary)
                
                Button("Check My Order!") {
                    // compare the current order to what the sorted order should be
                    let correctOrder = books.sorted {
                        (Double($0.ddc?.first ?? "0") ?? 0) < (Double($1.ddc?.first ?? "0") ?? 0)
                    }
                    isCorrect = books.map { $0.id } == correctOrder.map { $0.id }

                    if isCorrect {
                        // unlock the next level if this is the furthest they've gotten
                        if level >= highestUnlockedLevel {
                            highestUnlockedLevel = level + 1
                        }
                    }

                    showingResult = true
                }
                .buttonStyle(.borderedProminent)
                .alert(isCorrect ? "Correct! 🎉" : "Not quite...", isPresented: $showingResult) {
                    Button("OK") { }
                } message: {
                    Text(isCorrect ? "Level \(level) complete! Next level unlocked." : "Try rearranging the books again.")
                }
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
