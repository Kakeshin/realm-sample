//
//  ActivationObject.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation
import RealmSwift

final class ActivationObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var activationId: String = ""
    @objc dynamic var activationCode: Int = -1

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(model: ActivationModel) {
        self.init()

        activationId = model.activationId
        activationCode = model.activationCode
    }
}
