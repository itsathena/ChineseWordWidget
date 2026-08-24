import WidgetKit
import SwiftUI

struct ChineseWordWidgetEntryView: View {
    let entry: ChineseWordEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(entry.word.hanzi)
                .font(.system(size: 28, weight: .bold))

            Text(entry.word.pinyin)
                .font(.system(size: 13))
                .italic()

            Text(entry.word.meaning)
                .font(.system(size: 12))
                .lineLimit(1)
        }
        .privacySensitive(false)
        .containerBackground(.background, for: .widget)
    }
}

struct ChineseWordWidget: Widget {

    let kind = "ChineseWordWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            ChineseWordWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Chinese Word")
        .description("Learn Chinese vocabulary from your Lock Screen.")
        .supportedFamilies([
            .accessoryRectangular,
            .accessoryInline
        ])
    }
}
