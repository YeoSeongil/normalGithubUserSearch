//
//  ViewController.swift
//  normalGithubUserSearch
//
//  Created by 여성일 on 2/6/24.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchData()
        self.setView()
        bind()
    }
    
    private func setView() {
        self.view.backgroundColor = .white
    }

    private func bind() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .dataLoaded:
                print("dataLoaded")
            case .fetchData:
                print("fetchData")
            case.fetchError(let error):
                print(error)
            }
        }
    }

}

