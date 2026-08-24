import WidgetKit
import SwiftUI

@main
struct ChineseWordWidgetBundle: WidgetBundle {
    var body: some Widget {
        ChineseWordWidget()
        ChineseWordWidgetControl()
        ChineseWordWidgetLiveActivity()
    }
}
