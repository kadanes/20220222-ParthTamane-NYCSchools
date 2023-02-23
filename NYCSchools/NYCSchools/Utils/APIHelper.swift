//
//  APIHelper.swift
//  NYCSchools
//
//  Created by Parth Tamane on 22/02/23.
//

import Foundation
import SODAKit

protocol APIHelping {
    func getSchoolDetails() async throws -> [SchoolInfo]
}

class APIHelper: APIHelping {
    private let DATASET_NAME = "s3k6-pzi2"
    private let DATASET_DOMAIN = "data.cityofnewyork.us"
    // Empty tokens are allowed if we make few requests
    // If we want to increase number of requests then we will need to register a token.
    private let TOKEN = ""
    
    private let client: SODAClient
    private let limit: Int

    init(limit: Int = 10) {
        client = SODAClient(domain: DATASET_DOMAIN, token: TOKEN)
        self.limit = limit
    }
    
    func getSchoolDetails() async throws -> [SchoolInfo] {
        try await withCheckedThrowingContinuation({ continuation in
            let schoolData = client.query(dataset: DATASET_NAME)
            schoolData.limit(limit).get { res in
                switch res {
                    case .dataset(let data):
                        NSLog("Successfully downloaded schools info.")
                        let decodedData = data.compactMap { try? SchoolInfo(dictionary: $0) }
                        continuation.resume(returning: decodedData)
                        
                    case .error(let error):
                        NSLog("Failed to download schools info \(error)")
                        continuation.resume(throwing: error)
                }
            }
        })
    }
}
