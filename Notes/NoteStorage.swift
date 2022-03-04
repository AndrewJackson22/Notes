//
//  NoteStorage.swift
//  Notes
//
//  Created by Андрей Михайлов on 04.03.2022.
//

import UIKit

public final class Notes: Codable {
    
    public var name: String
    
    public init (name: String) {
        self.name = name
    }
}

extension Notes: Equatable {
    public static func == (lhs: Notes, rhs: Notes) -> Bool {
        lhs.name == rhs.name
    }
    
    
}

public final class NoteStorage {
    //Singleton
    public static let shared: NoteStorage = .init()
    
    //Array my notes
    public var notes: [Notes] = [] {
        didSet{
            save()
        }
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    public func save() {
        do {
            let data = try encoder.encode(notes)
            userDefaults.setValue(data, forKey: "notes")
        }
        catch {
            print("Ошибка кодирования привычек для сохранения", error)
        }
    }
}
