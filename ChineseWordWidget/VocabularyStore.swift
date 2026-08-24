//
//  VocabularyStore.swift
//  ChineseWord
//
//  Created by Adheena Dev on 23/08/26.
//

import Foundation

struct VocabularyStore {

    static func loadWords() -> [Word] {
        guard let url = Bundle.main.url(
            forResource: "words",
            withExtension: "json"
        ) else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)

            return try JSONDecoder().decode(
                [Word].self,
                from: data
            )
        } catch {
            print("Failed to load vocabulary:", error)
            return []
        }
    }
}
