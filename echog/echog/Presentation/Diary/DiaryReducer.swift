//
//  DiaryReducer.swift
//  echog
//
//  Created by minsong kim on 2/17/25.
//

import Combine
import Foundation
import NetworkFeatureKit

struct DiaryReducer: ReducerProtocol {
    enum Intent {
        case presentDiaryList(page: Int)
        case goToVoteListPage
        case goToMyPage
        case goToCreateNewDiary
        case goToEditDiary
        case goToDiaryViewer(id: UUID, title: String, content: String, date: String)
        case popPage
        case createNewDiary(title: String, content: String)
        case deleteDiary(id: UUID)
        case updateDiary(id: UUID, title: String, content: String)
    }
    
    enum Mutation {
        case newDiaryCreateSuccess
        case newDiaryCreateFailure
        case diaryUpdateSuccess(title: String, content: String)
        case diaryUpdateFailure
        case presentDiaryList(list: [DiaryContent],page: Int)
        case deleteDiaryFailure
        case goToDiaryViewer(id: UUID, title: String, content: String, date: String)
        case popPage
    }
    
    struct State {
        var page: Int = 0
        var diaryList: [DiaryContent] = []
        var diary: DiaryContent?
        var isNewDiaryUploadSuccess: TryState = .notYet
        var isDiaryDeleted: TryState = .notYet
        var isDiaryUpdated: TryState = .notYet
    }
    
    var initialState = State()
    
    weak var delegate: DiaryCoordinator?
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .presentDiaryList(let page):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        let diaryList = try await DiaryNetwork.shared.requestDiaryList(page: page, size: 10)
                        promise(.success(.presentDiaryList(list: diaryList.content, page: diaryList.pageNumber)))
                    } catch {
                        print(error)
                    }
                }
            }
            .eraseToAnyPublisher()
        case .goToVoteListPage:
            delegate?.goToVoteCoordinator()
            return nil
        case .goToMyPage:
            delegate?.goToMyPageCoordinator()
            return nil
        case .goToCreateNewDiary:
            delegate?.pushDiaryEditorViewController()
            return nil
        case .goToEditDiary:
            delegate?.pushDiaryEditorViewController()
            return nil
        case .goToDiaryViewer(let id, let title, let content, let date):
            return Just(Mutation.goToDiaryViewer(id: id, title: title, content: content, date: date)).eraseToAnyPublisher()
        case .popPage:
            return Just(Mutation.popPage).eraseToAnyPublisher()
        case .createNewDiary(let title, let content):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        _ = try await DiaryNetwork.shared.createDiary(title: title, content: content)
                        promise(.success(.newDiaryCreateSuccess))
                        delegate?.popViewController()
                    } catch {
                        promise(.success(.newDiaryCreateFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .deleteDiary(let id):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        _ = try await DiaryNetwork.shared.deleteDiary(id: id)
                        delegate?.popViewController()
                    } catch {
                        promise(.success(.deleteDiaryFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .updateDiary(let id, let title, let content):
            return Future<Mutation, Never> { promise in
                Task { @MainActor in
                    do {
                        _ = try await DiaryNetwork.shared.uploadDiary(id: id, title: title, content: content)
                        promise(.success(.diaryUpdateSuccess(title: title, content: content)))
                    } catch {
                        promise(.success(.diaryUpdateFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .presentDiaryList(let list, let page):
            newState.page = page
            if page == 0 {
                newState.diaryList = list
            } else {
                newState.diaryList += list
            }
        case .newDiaryCreateSuccess:
            newState.isNewDiaryUploadSuccess = .success
        case .newDiaryCreateFailure:
            newState.isNewDiaryUploadSuccess = .failure
        case .diaryUpdateSuccess(let title, let content):
            newState.diary?.title = title
            newState.diary?.content = content
            delegate?.popViewController()
        case .diaryUpdateFailure:
            newState.isDiaryUpdated = .failure
        case .deleteDiaryFailure:
            newState.isDiaryDeleted = .failure
        case .goToDiaryViewer(let id, let title, let content, let date):
            newState.diary = DiaryContent(id: id, title: title, content: content, createdAt: date)
            delegate?.pushDiaryViewerViewController()
        case .popPage:
            newState.diary = nil
            delegate?.popViewController()
        }
        
        return newState
    }
}
