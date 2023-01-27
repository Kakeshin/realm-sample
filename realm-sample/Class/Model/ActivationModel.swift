//
//  ActivationModel.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

struct ActivationModel {
    var activationId: String
    var activationCode: Int
    var names: [NameModel]

    init() {
        self.activationId = ""
        self.activationCode = -1
        self.names = [NameModel()]
    }

    init(activationId: String, activationCode: Int) {
        self.activationId = activationId
        self.activationCode = activationCode
        self.names = [NameModel()]
    }

    init(object: ActivationObject) {
        self.activationId = object.activationId
        self.activationCode = object.activationCode
        self.names = object.names.map { object in
            return NameModel(object: object)
        }
    }
}


struct NameModel {
    var name: String

    init() {
        self.name = ""
    }

    init(object: NameObject) {
        self.name = object.name
    }
}
