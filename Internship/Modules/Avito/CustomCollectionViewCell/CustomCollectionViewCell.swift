//
//  CustomCollectionViewCell.swift
//  Internship
//
//  Created by Ildar on 12/30/20.
//

import UIKit

protocol CustomCollectionViewCellProtocol {
    func configure(avitoData: AvitoData, index: Int, mark: Bool)
    func configureMark(mark: Bool)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    let verticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20.0)
        label.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: label.text ?? "")
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: label.text?.count ?? 0))
        label.attributedText = attrString
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let imageCheck: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.init(redS: 248, greenS: 248, blueS: 248)
        contentView.layer.cornerRadius = 10
        
        addViewsInStack()
        addViews()
    }
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func addViewsInStack() {
        verticalStackView.axis = NSLayoutConstraint.Axis.vertical
        verticalStackView.alignment = UIStackView.Alignment.leading
        verticalStackView.spacing = 20
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.axis = NSLayoutConstraint.Axis.horizontal
        horizontalStackView.alignment = UIStackView.Alignment.top
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.addArrangedSubview(labelTitle)
        verticalStackView.addArrangedSubview(labelDescription)
        verticalStackView.addArrangedSubview(labelPrice)
        
        horizontalStackView.addArrangedSubview(imageIcon)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(imageCheck)
    }
    
    func addViews() {
        contentView.addSubview(horizontalStackView)
        
        labelDescription.setContentHuggingPriority(UILayoutPriority(rawValue: 95), for: .vertical)
        labelTitle.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: .vertical)
        
        NSLayoutConstraint.activate([horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 20),horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([verticalStackView.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor,constant: 0),verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor,constant: 0)])
        
        NSLayoutConstraint.activate([imageCheck.widthAnchor.constraint(equalToConstant: 20)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CustomCollectionViewCellProtocol
extension CustomCollectionViewCell: CustomCollectionViewCellProtocol {
    func configure(avitoData: AvitoData, index: Int, mark: Bool) {
        self.labelTitle.text = avitoData.result.list[index].title
        self.labelDescription.text = avitoData.result.list[index].description
        self.labelPrice.text = avitoData.result.list[index].price
        
        if let url = URL(string: avitoData.result.list[index].icon.url) {
            if let data = try? Data(contentsOf: url) {
                self.imageIcon.image = UIImage(data: data)
            }
        }
        if mark {
            self.imageCheck.image = UIImage(named: "checkmark")
        } else {
            self.imageCheck.image = UIImage()
        }
    }
    
    func configureMark(mark: Bool) {
        self.imageCheck.image = mark ? UIImage(named: "checkmark") : UIImage()
    }
    
}
