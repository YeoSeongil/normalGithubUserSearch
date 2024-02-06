//
//  ViewController.swift
//  normalGithubUserSearch
//
//  Created by 여성일 on 2/6/24.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "검색할 사용자의 이름을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var serachResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(searchResultCollectionViewCell.self, forCellWithReuseIdentifier: searchResultCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
        setConstraint()
        viewModel.fetchData()
        bind()
    }
    
    private func setView() {
        self.view.backgroundColor = .black
        [searchTextField, serachResultCollectionView].forEach {
            self.view.addSubview($0)
        }
        serachResultCollectionView.delegate = self
        serachResultCollectionView.dataSource = self
        searchTextField.delegate = self
    }
    
    private func setConstraint() {
        searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        serachResultCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        serachResultCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        serachResultCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        serachResultCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func bind() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .dataLoaded:
                print("dataLoaded")
                DispatchQueue.main.async {
                    self.serachResultCollectionView.reloadData()
                }
            case .fetchData:
                print("fetchData")
            case.fetchError(let error):
                print("error !!")
                print(error.localizedDescription)
            case .searchLoaded:
                DispatchQueue.main.async {
                    self.serachResultCollectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchResultCollectionViewCell.id, for: indexPath) as? searchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let items = self.viewModel.item[indexPath.row]
        cell.users = items
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 30) / 3
        let height: CGFloat = 150
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
            viewModel.serachData(text)
        }
}
