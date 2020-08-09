//
//  DecoderService.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation

final class DecoderService
{
    // MARK: - Property list

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // MARK: - Internal methods

    func decode<T: Decodable>(from data: Data, modelType: T.Type, callback: @escaping (Result<T, Error>) -> () ) {
        do {
            callback(.success(try decoder.decode(modelType, from: data)))
        } catch {
            callback(.failure(error))
        }
    }
}
