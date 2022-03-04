//
//  NotesViewController.swift
//  Notes
//
//  Created by Андрей Михайлов on 04.03.2022.
//

import UIKit

class NotesViewController: UIViewController {
    
    private let layout = UICollectionViewLayout()
    private lazy var notesCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let apperance = UINavigationBarAppearance()
    let store = NoteStorage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        apperance.configureWithDefaultBackground()
        apperance.backgroundColor = .systemGray4
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().scrollEdgeAppearance = apperance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNotes))
    }
    
    func setupCollection() {
        notesCollection.toAutoLayout()
        notesCollection.backgroundColor = .white
        notesCollection.dataSource = self
        notesCollection.delegate = self
    }
    
    @objc func createNewNotes() {
        if let notesTwoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "notesVC") as? NotesTwoViewController {
            let navigationController = UINavigationController(rootViewController: notesTwoViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
    }
}

extension NotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0:
            return CGSize(width: (notesCollection.frame.width - 33), height: 60)
        default:
            return  CGSize(width: (notesCollection.frame.width - 33), height: 130)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: .zero, bottom: .zero, right:.zero)
        default:
            return UIEdgeInsets(top: 18, left: .zero, bottom: .zero, right: .zero)
        }
    }
}

extension NotesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let notesCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NotesCollectionView.self), for: indexPath) as! NotesCollectionView
            
            notesCell.note = store.notes[indexPath.item]
            notesCell.check = { self.notesCollection.reloadData() }
            return notesCell
        default:
            return UICollectionViewCell()
            
        }
    }    
        
}
