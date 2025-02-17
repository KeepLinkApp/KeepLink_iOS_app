//
//  KeepLinkApp.swift
//  KeepLink
//
//  Created by Андрей Степанов on 06.12.2024.
//

import SwiftUI
import RealmSwift

let config = Realm.Configuration(
    schemaVersion: 3,
    migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < 2 {
            migration.enumerateObjects(ofType: Contact.className()) { oldObject, newObject in
                newObject!["avatarData"] = nil
            }
        }
        if oldSchemaVersion < 3 {
            migration.enumerateObjects(ofType: User.className()) { oldObject, newObject in
                newObject!["phoneNumber"] = ""
            }
        }
    }
)

@main
struct KeepLinkApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Realm.Configuration.defaultConfiguration = config
                }
        }
    }
}
