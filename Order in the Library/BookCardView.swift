//
//  BookCardView.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import SwiftUI

struct BookCardView: View {
    let title: String
    let author: String
    let ddc: String

    var body: some View {
        VStack(spacing: 6) {
            // book icon at the top

            // title of the book
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            // author name
            Text(author)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)

            // the ddc number (this is what they sort by)
            Text(ddc)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(6)
        }
        .frame(width: 120, height: 160)
        .padding(8)
        .background(Color.gray)
        .cornerRadius(12)
    }
}

#Preview {
    BookCardView(title: "test science book", author: "aiden", ddc: "523.1")
}
