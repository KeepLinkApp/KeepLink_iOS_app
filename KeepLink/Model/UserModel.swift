//
//  UserModel.swift
//  keeplinkskelenot
//
//  Created by Андрей Степанов on 15.01.2025.
//

import Foundation
import RealmSwift

final class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var email: String
    @Persisted var username: String
    @Persisted var passwordHash: Data // Для хранения [UInt8]
    @Persisted var role: String
    @Persisted var contacts = List<Contact>() // Связь один-ко-многим
}
