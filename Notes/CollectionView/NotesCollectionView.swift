//
//  NotesCollectionView.swift
//  Notes
//
//  Created by Андрей Михайлов on 04.03.2022.
//

import UIKit

class NotesCollectionView: UICollectionViewCell {
    
    var check: (() -> Void)?
    
    var note: Notes? {
        didSet {
            notesTextField.text = note?.name
        }
    }
    
    private let notesTextField: UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "SFProText-Semibold", size: 17)
        text.toAutoLayout()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(notesTextField)
        
        let constains = [
            notesTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            notesTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ]
        NSLayoutConstraint.activate(constains)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
