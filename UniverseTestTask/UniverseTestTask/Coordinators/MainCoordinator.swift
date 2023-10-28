//
//  MainCoordinator.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit
import RxSwift
import RxRelay

class MainCoordinator: BaseCoordinator {
    
    // MARK: -
    // MARK: Variables
    
    private var onboardingCoordinator: OnboardingCoordinator?
    
    // MARK: -
    // MARK: Overrided
    
    override func start() {
        self.onboardingCoordinator = onboardingFlow()
        self.onboardingCoordinator?.navController = self
        
        self.pushViewController(self.onboardingCoordinator ?? UIViewController(), animated: true)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func onboardingFlow() -> OnboardingCoordinator {
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.events.bind { [weak self] in
            self?.handle(events: $0)
        }
        .disposed(by: self.disposeBag)
        
        return onboardingCoordinator
    }
    
    private func handle(events: OnboardingCoordinatorOutputEvents) {
        
    }
}
