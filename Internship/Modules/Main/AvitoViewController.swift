//
//  AvitoViewController.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

class AvitoViewController: UIViewController, AvitoViewProtocol {

    var presenter: AvitoPresenterProtocol?
    var configurator: AvitoConfiguratorProtocol = AvitoConfigurator()
    
    private let closeButton = UIButton()
    private let textLabel = UILabel()
    private let cellIdentifier = String(describing: CustomCollectionViewCell.self)
    private let chooseButton = UIButton()
    private var marks: [Bool] = Array(repeating: false, count: 2)
    private var numberOfCells = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 40, height: 10)
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
        
        view.backgroundColor = .white
    }
    
    // MARK: - AvitoViewProtocol methods
    
    func addCloseButton() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)])

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    func addTextLabel() {
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([textLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor,constant: 30),textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20)])
        
        textLabel.font = UIFont.boldSystemFont(ofSize: 30)
        textLabel.numberOfLines = 0
        textLabel.text = "Сделайте объявление заметнее на 7 дней"
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,constant: 25),collectionView.bottomAnchor.constraint(equalTo: chooseButton.topAnchor,constant: -30),collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        collectionView.backgroundColor = .white
    }
    
    func addChooseButton() {
        
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(chooseButton)
        
        NSLayoutConstraint.activate([chooseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),chooseButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),chooseButton.heightAnchor.constraint(equalToConstant: 50)])
        
        chooseButton.backgroundColor = UIColor(redS: 69, greenS: 173, blueS: 255)
        chooseButton.layer.cornerRadius = 5
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.setTitleColor(.white, for: .normal)
        chooseButton.setTitleColor(UIColor.init(redS: 230, greenS: 230, blueS: 230), for: .highlighted)
        chooseButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        presenter?.showChooseButtonAlert()
    }
}

// MARK: - UICollectionViewDataSource
extension AvitoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let avitoData = presenter?.loadAvitoData() {
            cell.configure(avitoData: avitoData, index: indexPath.row, mark: marks[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.marks[indexPath.row] {
            self.setFalseToMarks()
        } else {
            self.setFalseToMarks()
            self.marks[indexPath.row] = true
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomCollectionViewCell {
                
                cell.configureMark(mark: self.marks[indexPath.row] )
            }
        }

        let range = Range(uncheckedBounds: (0, collectionView.numberOfSections))
        let indexSet = IndexSet(integersIn: range)
        collectionView.reloadSections(indexSet)
    }
    
    private func setFalseToMarks() {
        self.marks = Array(repeating: false, count: 2)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AvitoViewController: UICollectionViewDelegateFlowLayout {

}
