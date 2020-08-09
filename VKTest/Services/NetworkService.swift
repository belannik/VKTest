//
//  NetworkService.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Alamofire

final class FeedsNetworkService
{
    // MARK: - Property list

    private let token: String
    private let apiString = "https://api.vk.com/method/newsfeed.get"
	private let apiVersion = "5.122"

    // MARK: - Initialization

    init(token: String) {
        self.token = token
    }
    
    func fetchFeeds(nextFrom: String? = nil, callback: @escaping(Result<Data, Error>) -> () ) {
        var parameters: Parameters = [
            "filters": "post",
            "count": 40,
            "access_token": token,
            "v": "5.122"
        ]
		if let nextFrom = nextFrom { parameters["start_from"] = nextFrom }
        AF.request(apiString,
                   method: .get,
                   parameters: parameters,
            encoding: URLEncoding.default).responseData(completionHandler: { dataResponse in
                switch dataResponse.result {
                case .success(let data): callback(.success(data))
                case .failure(let error): callback(.failure(error))
                }
			})
    }
}
