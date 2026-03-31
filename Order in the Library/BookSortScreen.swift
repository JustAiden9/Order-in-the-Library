//
//  BookSortScreen.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct BookSortScreen: View {
    let level: Int

    private var bookCount: Int { // Figures out how many books this level should show
        switch level { // Choose a number based on the current level
        case 1: return 3
        case 2: return 5
        default: return 8
        }
    }

    private var description: String { // using the book count
        "Sort \(bookCount) books by their Dewey Decimal numbers."
    }

    @State private var books: [Book] = []
    @State private var isLoading = true
    @AppStorage("highestUnlockedLevel") private var highestUnlockedLevel: Int = 1 // Saved in UserDefaults and updates the UI automatically
    @State private var showingResult = false
    @State private var isCorrect = false

    // controls showing the certificate popup
    @State private var showingCertificate = false

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
                ProgressView("Loading books...")
                    .padding()
            } else {
                List {
                    ForEach(books) { book in // Loop over each book to make a row
                        HStack {
                            BookCardView(
                                title: book.title ?? "Unknown",
                                author: book.author_name?.first ?? "Unknown",
                                ddc: book.ddc?.first ?? "No DDC"
                            )
                            Spacer()
                        }
                    }
                    .onMove { source, destination in // Allows drag-to-reorder by moving items in the array
                        books.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .environment(\.editMode, .constant(.active)) // Force the list into reordering mode so the drag handles show
                .frame(height: min(CGFloat(bookCount) * 80, 400)) // Limit the list height based on how many books there are
                .cornerRadius(12)

                Text("Sort these by DDC number, smallest to largest!")
                    .foregroundStyle(.secondary)

                Button("Check My Order!") { // When tapped, we check if the books are in the right order
                    let correctOrder = books.sorted { // Make a sorted copy of the books by comparing their DDC numbers as Doubles
                        (Double($0.ddc?.first ?? "0") ?? 0) < (Double($1.ddc?.first ?? "0") ?? 0)
                    }
                    isCorrect = books.map { $0.id } == correctOrder.map { $0.id } // Compare the current order to the correct order by matching IDs

                    if isCorrect {
                        if level >= highestUnlockedLevel { // If this is the highest level you've reached, unlock the next one
                            highestUnlockedLevel = level + 1
                        }
                        // if this is level 3, show the certificate popup
                        if level == 3 {
                            showingCertificate = true
                        } else {
                            showingResult = true
                        }
                    } else {
                        showingResult = true
                    }
                }
                .buttonStyle(.borderedProminent)
                // Regular result alert for non-level-3 or wrong answers
                .alert(isCorrect ? "Correct!" : "Not quite...", isPresented: $showingResult) {
                    Button("OK") { }
                } message: {
                    Text(isCorrect ? "Level \(level) complete! Next level unlocked." : "Try rearranging the books again.")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Level \(level)")
        .task { // Runs when the view appears to load data asynchronously
            await loadBooks() // Call the async function to set up the books
        }
        // NEW: certificate sheet, shown when level 3 is completed correctly
        .sheet(isPresented: $showingCertificate) { // Shows a popup sheet when you finish level 3
            CertificateView()
        }
    }

    func loadBooks() async { // Asynchronously fetch and prepare the books for this level
        isLoading = true
        let allBooks = await fetchBooks() // Ask for all available books (async)
        let shuffled = allBooks.shuffled() // Randomize the order so each game feels different
        let picked = Array(shuffled.prefix(bookCount)) // Take only as many as this level needs
        books = picked
        isLoading = false
    }
}
