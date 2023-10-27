//
//  NetworkSessionProcessable.swift
//  UniverseTestTask
//
//  Created by Aleksandr Ermakov on 27.10.2023.
	

import UIKit

typealias ResultCompletion<T> = (Result<T, RequestError>) -> ()

protocol NetworkSessionProcessable {

    static func sendRequest<T: URLContainable>(
        requestModel: T,
        completion: @escaping ResultCompletion<T.DecodableType>
    )
    
    static func sendDataRequest<T: URLContainable>(
        requestModel: T,
        completion: @escaping ResultCompletion<Data>
    )
    
    static func sendImageRequest<T: URLContainable>(
        requestModel: T,
        completion: @escaping ResultCompletion<UIImage>
    )
}
