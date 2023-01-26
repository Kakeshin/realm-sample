//
//  ActivationRepository.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import Foundation

final class ActivationRepository {
    private let dao = Activation()
}

extension ActivationRepository: ActivationRepositoryProtocol {
    func addActivation(model: ActivationModel) -> Bool {
        return dao.addActivation(object: ActivationObject(model: model))
    }
}
