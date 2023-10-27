//
//  NetworkServiceContainable.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import Foundation

protocol NetworkServiceContainable {

    associatedtype Service: NetworkSessionProcessable
}

extension NetworkServiceContainable {

    typealias Service = NetworkService
}
