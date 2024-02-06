//
//  ViewModel.swift
//  normalGithubUserSearch
//
//  Created by 여성일 on 2/6/24.
//

import Foundation

class ViewModel {
    
    var users: [Users] = []
    var item: [Item] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchData() {
        self.eventHandler?(.fetchData)
        APIManager.shared.request(modelType: Users.self, type: EndPointItems.initUsers) {  result  in
            switch result {
            case .success(let users):
                self.users = [users]
                self.item = users.items
                self.eventHandler?(.dataLoaded)
            case.failure(let error):
                self.eventHandler?(.fetchError(error))
            }
        }
    }
    
    func serachData(_ inputSearchData: String) {
        self.eventHandler?(.fetchData)
        APIManager.shared.request(modelType: Users.self, type: EndPointItems.Users(inputSearchData)) { result in
            switch result {
            case .success(let users):
                self.users = [users]
                self.item = users.items
                self.eventHandler?(.searchLoaded)
            case.failure(let error):
                self.eventHandler?(.fetchError(error))
            }
        }
    }
}

extension ViewModel {
    enum Event {
        case fetchData
        case dataLoaded
        case fetchError(Error)
        case searchLoaded
    }
}
