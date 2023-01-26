//
//  ActivationPresenter.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

final class ActivationPresenter {
    private var repository: ActivationRepositoryProtocol

    init(repository: ActivationRepository) {
        self.repository = repository
    }
}

extension ActivationPresenter {
    func activationButtonTapped(activationId: String, activationCode: Int) -> String {
        return repository.addActivation(model: ActivationModel(activationId: activationId,
                                                               activationCode: activationCode)) ? "成功" : "失敗"
    }
}
