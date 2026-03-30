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

struct Book: Codable, Identifiable {
    var id: String { title ?? UUID().uuidString }

    let title: String?
    let author_name: [String]?
    let ddc: [String]?
}

func fetchBooks() async -> [Book] {
    let url = URL(string: "https://openlibrary.org/search.json?q=subject:science&fields=title,author_name,ddc,cover_i&limit=20")!

    // the try! means it will pull the data down read it then try to decode it and then pass it off to the next function calling. If it is unable to decode it, it will crash the app
    let (data, _) = try! await URLSession.shared.data(from: url)
    let result = try! JSONDecoder().decode(SearchResult.self, from: data)

    return result.docs
}
