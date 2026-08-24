//
//  ChineseWordWidgetLiveActivity.swift
//  ChineseWordWidget
//
//  Created by Adheena Dev on 23/08/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ChineseWordWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ChineseWordWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ChineseWordWidgetAttributes.self) { context in
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ChineseWordWidgetAttributes {
    fileprivate static var preview: ChineseWordWidgetAttributes {
        ChineseWordWidgetAttributes(name: "World")
    }
}

extension ChineseWordWidgetAttributes.ContentState {
    fileprivate static var smiley: ChineseWordWidgetAttributes.ContentState {
        ChineseWordWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ChineseWordWidgetAttributes.ContentState {
         ChineseWordWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ChineseWordWidgetAttributes.preview) {
   ChineseWordWidgetLiveActivity()
} contentStates: {
    ChineseWordWidgetAttributes.ContentState.smiley
    ChineseWordWidgetAttributes.ContentState.starEyes
}
