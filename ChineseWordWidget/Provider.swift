//
//  Provider.swift
//  ChineseWord
//
//  Created by Adheena Dev on 23/08/26.
//

import WidgetKit

struct Provider: TimelineProvider {
    
    // MARK: - Placeholder
    
    func placeholder(in context: Context) -> ChineseWordEntry {
        ChineseWordEntry(
            date: Date(),
            word: Word(
                hanzi: "你好",
                pinyin: "nǐ hǎo yes",
                meaning: "hello",
                example: "你好！很高兴认识你。",
                examplePinyin: "Nǐ hǎo! Hěn gāoxìng rènshi nǐ.",
                exampleMeaning: "Hello! Nice to meet you."
            )
        )
    }
    
    // MARK: - Snapshot
    
    func getSnapshot(in context: Context, completion: @escaping (ChineseWordEntry) -> Void) {
        let word = VocabularyStore.loadWords().first ?? placeholder(in: context).word
        
        let entry = ChineseWordEntry(
            date: Date(),
            word: word
        )
        
        completion(entry)
    }
    
    // MARK: - Timeline
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ChineseWordEntry>) -> Void) {
            let allWords = VocabularyStore.loadWords()
            
            // Fallback if the JSON fails to load or is empty
            guard !allWords.isEmpty else {
                completion(
                    Timeline(
                        entries: [placeholder(in: context)],
                        policy: .after(Date().addingTimeInterval(30 * 60)) // 30 minutes
                    )
                )
                return
            }
            
            let batchSize = 48
            let selectedWords = Array(allWords.shuffled().prefix(batchSize))
            
            let now = Date()
            
            // Generate timeline entries spaced 30 minutes apart
            let entries = selectedWords.enumerated().map { index, word in
                ChineseWordEntry(
                    date: now.addingTimeInterval(Double(index) * 30 * 60), // 30 minutes
                    word: word
                )
            }
            
            // Set policy to .atEnd so WidgetKit requests a new batch when this one finishes
            completion(
                Timeline(
                    entries: entries,
                    policy: .atEnd
                )
            )
        }
}
