//
//  PickMenuView.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct PickMenuView: View {
    // AppStorage saves this to UserDefaults automatically, so it persists!
    @AppStorage("highestUnlockedLevel") private var highestUnlockedLevel: Int = 1 // Stores this number in UserDefaults and keeps it in sync with the UI

    var body: some View {
        List {
            Section("Choose a Level") {
                LevelRow(level: 1, highestUnlocked: highestUnlockedLevel)
                LevelRow(level: 2, highestUnlocked: highestUnlockedLevel)
                LevelRow(level: 3, highestUnlocked: highestUnlockedLevel)
            }
        }
        .navigationTitle("Pick a Level")
    }
}

// broke this out into its own view to keep things clean
struct LevelRow: View {
    let level: Int
    let highestUnlocked: Int

    private var isLocked: Bool { // figures out if this level is locked
        level > highestUnlocked // If the level number is bigger than what you've unlocked, it's locked
    }

    private var bookCount: Int { // Decides how many books to sort for this level
        switch level { // Pick a number based on the level
        case 1: return 3
        case 2: return 5
        default: return 8
        }
    }

    var body: some View {
        if isLocked {
            // locked state — no NavigationLink, just a greyed out row
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Level \(level)")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text("Sort by Dewey numbers \(bookCount) Books")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "lock.fill")
                    .foregroundStyle(.secondary)
            }
        } else {
            NavigationLink { // This makes the row tappable and pushes a new screen
                BookSortScreen(level: level) // Create the game screen and tell it which level to load
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Level \(level)")
                        .font(.headline)
                    Text("Sort by Dewey numbers \(bookCount) Books")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview { 
    NavigationStack { PickMenuView() }
}
