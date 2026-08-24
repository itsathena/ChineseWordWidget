import Foundation

struct Word: Codable, Hashable {
    let hanzi: String
    let pinyin: String
    let meaning: String
    let example: String
    let examplePinyin: String
    let exampleMeaning: String
}
