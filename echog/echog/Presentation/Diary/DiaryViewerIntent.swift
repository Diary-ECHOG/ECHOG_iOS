//
//  DiaryViewerIntent.swift
//  echog
//
//  Created by minsong kim on 1/13/25.
//

enum DiaryViewerIntent {
    case goBack
    case showDetail
    case tapFix
    case tapRemove
    
    var reducer: DiaryViewerState {
        switch self {
        case .goBack:
                .back
        case .showDetail:
                .detail
        case .tapFix:
                .fix
        case .tapRemove:
                .remove
        }
    }
}
