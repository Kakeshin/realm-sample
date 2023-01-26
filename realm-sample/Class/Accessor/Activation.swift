//
//  Activation.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation
import RealmSwift

final class Activation {
    private static let kRealmSchemeVersion: UInt64 = 0

    private func settingRealm() -> Realm? {
        var realm: Realm?

        do {
            var config = Realm.Configuration()
            let libraryDic = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
                                                                 .userDomainMask,
                                                                 true).first!
            let filePath = "\(libraryDic)/Realm"

            try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true)

            var fileUrl = URL(string: filePath)
            fileUrl = fileUrl?.appendingPathComponent("realm-sample").appendingPathExtension("realm")

            config.fileURL = fileUrl
        } catch {

        }

        return realm
    }
}

extension Activation {
    func addActivation(object: ActivationObject) -> Bool {
        guard let realm = settingRealm() else { return false }
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            return false
        }
        return true
    }
}
