//
//  Activation.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation
import RealmSwift

final class NameObject: Object {
    @objc dynamic var name: String = ""
    let activations = LinkingObjects(fromType: ActivationObject.self, property: "names")

    init(name: String) {
        self.name = name
    }
}

final class ActivationObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var activationId: String = ""
    @objc dynamic var activationCode: Int = -1
    var names = List<NameObject>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(model: ActivationModel) {
        self.init()

        activationId = model.activationId
        activationCode = model.activationCode
    }

    private let kRealmSchemeVersion: UInt64 = 1

    private func getRealm() -> Realm? {
        var realm: Realm?

        do {
            var config = Realm.Configuration()
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

extension ActivationObject: ActivationProtocol {
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

    func updateNames(model: ActivationModel) -> Bool {
        guard let realm = getRealm() else {
            print("create realm failed")
            return false
        }
        let object = ActivationObject()
        do {
            try realm.write {
                object.names = model.toList()
                realm.add(object, update: .modified)
            }
        } catch {
            print("add realm failed")
            return false
        }
        return true
    }
}

private extension ActivationModel {
    func toList() -> List<NameObject> {
        let ret = List<NameObject>()
        let namesObject = self.names.map { model in
            return NameObject(name: model.name)
        }
        ret.append(objectsIn: namesObject)
        return ret
    }
}
