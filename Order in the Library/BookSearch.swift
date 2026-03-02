//
//  BookSearch.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/2/26.
//

import Foundation

struct SearchResult: Codable {
    let docs: [Book]
}

struct Book: Codable {
    let title: String?
    let author_name: [String]?
    let ddc: [String]?
}

func fetchBooks() {
    let url = URL(string: "https://openlibrary.org/search.json?q=subject:science&fields=title,author_name,ddc,cover_i&limit=20")!

    // Call the API
    let data = try! Data(contentsOf: url)
    let result = try! JSONDecoder().decode(SearchResult.self, from: data)

    for book in result.docs {
        let title  = book.title ?? "Unknown Title"
        let author = book.author_name?.first ?? "Unknown Author"
        let ddc    = book.ddc?.first ?? "No DDC"
    }
}
