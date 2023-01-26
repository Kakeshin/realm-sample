//
//  Activation.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation
import RealmSwift

final class Activation {
    private let kRealmSchemeVersion: UInt64 = 1

    private func getRealm() -> Realm? {
        var realm: Realm?

        do {
            var config = Realm.Configuration()
            // Realmファイルを保存する場所を指定する
            let libraryDirectory = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
                                                                       .userDomainMask,
                                                                       true).first!
            let filePath = "\(libraryDirectory)/Realm"
            try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true)

            var fileUrl = URL(string: filePath)
            fileUrl = fileUrl?.appendingPathComponent("realm-sample").appendingPathExtension("realm")

            config.fileURL = fileUrl
            config.schemaVersion = self.kRealmSchemeVersion
            config.migrationBlock = { (migration, oldMigration) in
                guard self.kRealmSchemeVersion > oldMigration else {
                    print("Not migration")
                    return
                }
            }
            realm = try Realm(configuration: config)
        } catch {
            print("!! Realm Instance Error !!")
        }

        return realm
    }
}

extension Activation {
    func addActivation(object: ActivationObject) -> Bool {
        guard let realm = getRealm() else {
            print("create realm failed")
            return false
        }
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("add realm failed")
            return false
        }
        return true
    }
}
