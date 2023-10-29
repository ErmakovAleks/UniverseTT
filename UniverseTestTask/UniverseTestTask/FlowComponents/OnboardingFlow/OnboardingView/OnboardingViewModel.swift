//
//  OnboardingViewModel.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import Foundation

enum OnboardingViewModelOutputEvents: Events {
    
    case termsOfUse
    case privacyPolicy
    case subscriptionTerms
}

final class OnboardingViewModel: BaseViewModel<OnboardingViewModelOutputEvents> {
    
    // MARK: -
    // MARK: Internal functions
    
    func handleTermsOfUse() {
        self.outputEventsEmiter.accept(.termsOfUse)
    }
    
    func handlePrivacyPolicy() {
        self.outputEventsEmiter.accept(.privacyPolicy)
    }
    
    func handleSubscriptionTerms() {
        self.outputEventsEmiter.accept(.subscriptionTerms)
    }
}