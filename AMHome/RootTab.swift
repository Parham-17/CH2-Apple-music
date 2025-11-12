import SwiftUI

/// Represents the main tabs in the app.
enum RootTab: CaseIterable, Hashable {
    case home
    case new
    case radio
    case library

    var title: String {
        switch self {
        case .home: return "Home"
        case .new: return "New"
        case .radio: return "Radio"
        case .library: return "Library"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .new: return "square.grid.2x2.fill"
        case .radio: return "dot.radiowaves.left.and.right"
        case .library: return "music.note.list"
        }
    }
}
