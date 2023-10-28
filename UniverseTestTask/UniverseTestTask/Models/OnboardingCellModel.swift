//
//  OnboardingCellModel.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 28.10.2023.
	

import Foundation

struct OnboardingCellModel {
    
    let title: String
    let description: String
    let imageName: String
    
    static let data: [OnboardingCellModel] = [
        OnboardingCellModel(
            title: "Your Personal Assistant",
            description: "Simplify your life with an AI companion",
            imageName: "Illustration1"
        ),
        OnboardingCellModel(
            title: "Get assistance with any topic",
            description: "From daily tasks to complex queries, we've got you covered",
            imageName: "Illustration2"
        ),
        OnboardingCellModel(
            title: "Perfect copy you can rely on",
            description: "Generate professional texts effortlessly",
            imageName: "Illustration3"
        ),
        OnboardingCellModel(
            title: "Upgrade for Unlimited AI Capabilities",
            description: "7-Day Free Trial, then $19,99/month, autorenewable",
            imageName: "Illustration4"
        )
    ]
}
