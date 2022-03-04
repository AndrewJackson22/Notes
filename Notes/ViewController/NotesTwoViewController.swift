//
//  NotesTwoViewController.swift
//  Notes
//
//  Created by Андрей Михайлов on 04.03.2022.
//

import UIKit

class NotesTwoViewController: UIViewController {
    
    var notes: Notes? {
        didSet {
            createNote()
        }
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.toAutoLayout()
        return scroll
    }()
    
    
    private let textField: UITextField = {
        let text = UITextField()
        text.placeholder = "Наберите текст ..."
        text.font = UIFont(name: "SFProText-Semibold", size: 17)
        text.textColor = .black
        text.toAutoLayout()
        return text
    }()
    
    private let notesView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.toAutoLayout()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        navigationItem.title = "Создать"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
        createButton()
        createNote()
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(notesView)
        notesView.addSubview(textField)
        
        let constrains = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            notesView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            notesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            notesView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            notesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            notesView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            textField.topAnchor.constraint(equalTo: notesView.topAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: notesView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constrains)
    }
    func createNote() {
        if let changeNote = notes {
            textField.text = changeNote.name
        } else {
            textField.text = ""
        }
    }
    
    func createButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNotes))
    }
    
    @objc func returnBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveNotes() {
        if let changeNote = self.notes {
            changeNote.name = textField.text ?? ""
        } else {
            let newNote = Notes(name: textField.text ?? "")
            let store = NoteStorage.shared
            store.notes.append(newNote)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               
               scrollView.contentInset.bottom = keyboardSize.height
               scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
           }
       }
       
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
           scrollView.contentInset.bottom = .zero
           scrollView.verticalScrollIndicatorInsets = .zero
       }
    
}

extension NotesTwoViewController: UITextFieldDelegate {
    
    func textFieldReturnShould(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
