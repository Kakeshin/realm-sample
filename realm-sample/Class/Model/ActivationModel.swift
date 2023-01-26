//
//  ActivationModel.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation

struct ActivationModel {
    var activationId: String
    var activationCode: Int

    init(activationId: String, activationCode: Int) {
        activationId = activationId
        activationCode = activationCode
    }

    init(object: ActivationObject) {
        activationId = object.activationId
        activationCode = object.activationCode
    }
}
