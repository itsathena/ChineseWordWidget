import WidgetKit

struct Provider: TimelineProvider {
    
    // MARK: - Placeholder
    
    func placeholder(in context: Context) -> ChineseWordEntry {
        ChineseWordEntry(
            date: Date(),
            word: Word(
                hanzi: "你好",
                pinyin: "nǐ hǎo",
                meaning: "hello",
                example: "你好！很高兴认识你。",
                examplePinyin: "Nǐ hǎo! Hěn gāoxìng rènshi nǐ.",
                exampleMeaning: "Hello! Nice to meet you."
            )
        )
    }
    
    // MARK: - Snapshot
    
    func getSnapshot(in context: Context, completion: @escaping (ChineseWordEntry) -> Void) {
        let allWords = VocabularyStore.loadWords()
        let word = allWords.first ?? placeholder(in: context).word
        
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
                    policy: .after(Date().addingTimeInterval(30 * 60))
                )
            )
            return
        }
        
        let batchSize = 48
        let interval: TimeInterval = 30 * 60 // 30 minutes
        let now = Date()
        
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: now)
        let totalHalfHoursSinceReference = Int(now.timeIntervalSince(startOfToday) / interval)
        
        var entries: [ChineseWordEntry] = []
        
        for i in 0..<batchSize {
            let entryDate = now.addingTimeInterval(Double(i) * interval)
            let wordIndex = (totalHalfHoursSinceReference + i) % allWords.count
            let entry = ChineseWordEntry(date: entryDate, word: allWords[wordIndex])
            entries.append(entry)
        }
        
        let nextReloadDate = now.addingTimeInterval(Double(batchSize) * interval)
        
        completion(
            Timeline(
                entries: entries,
                policy: .after(nextReloadDate)
            )
        )
    }
}
