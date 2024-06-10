//
//  LoadFileStrategy.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

protocol LoadFileStrategy {
    associatedtype Params
    associatedtype ResultType
     
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error>
}

protocol FileParams {
    var data: Data? {get set}
}

// MARK: - LOADER user

struct FileParams_user: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_user: LoadFileStrategy {
    typealias Params = FileParams_user
    typealias ResultType = FileParams_user
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER friend

struct FileParams_friend: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_friend: LoadFileStrategy {
    typealias Params = FileParams_friend
    typealias ResultType = FileParams_friend
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}


// MARK: - LOADER message

struct FileParams_message: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_message: LoadFileStrategy {
    typealias Params = FileParams_message
    typealias ResultType = FileParams_message
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER amount saving

struct FileParams_amountSaving: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_amountSaving: LoadFileStrategy {
    typealias Params = FileParams_amountSaving
    typealias ResultType = FileParams_amountSaving
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER amount fixed deposit

struct FileParams_amountFixedDeposit: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_amountFixedDeposit: LoadFileStrategy {
    typealias Params = FileParams_amountFixedDeposit
    typealias ResultType = FileParams_amountFixedDeposit
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER amount digital

struct FileParams_amountDigital: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_amountDigital: LoadFileStrategy {
    typealias Params = FileParams_amountDigital
    typealias ResultType = FileParams_amountDigital
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER favorite

struct FileParams_favorite: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_favorite: LoadFileStrategy {
    typealias Params = FileParams_favorite
    typealias ResultType = FileParams_favorite
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER adBanner

struct FileParams_adBanner: FileParams {
    var fileName: String
    var fileExt: String
    var data: Data?
    
    var cacheKey: String {
        return "\(fileName).\(fileExt)"
    }
}

class LoadFileStrategy_adBanner: LoadFileStrategy {
    typealias Params = FileParams_adBanner
    typealias ResultType = FileParams_adBanner
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        let fileName = params.fileName
        let fileExt = params.fileExt
        
        return await withCheckedContinuation { continuation in
            let url = "\(RequestStruct.DOMAIN)/\(fileName).\(fileExt)"
            RequestManager.shared.httpGet(url: url, parameters: nil, httpClosure: { data, response, error in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}

// MARK: - LOADER file

struct FileParams_file: FileParams {
    var url: String
    var data: Data?
    
    var cacheKey: String {
        return "\(url)"
    }
}

class LoadFileStrategy_file: LoadFileStrategy {
    typealias Params = FileParams_file
    typealias ResultType = FileParams_file
    
    func loadSingleFile(params: Params) async throws -> Result<ResultType, Error> {
        guard let url = URL(string: params.url) else {
            return .failure(LoadError.paramError)
        }
        return await withCheckedContinuation { continuation in
            RequestManager.shared.downloadFile(from: url, completion: { data in
                if let data = data {
                    var resultParams = params
                    resultParams.data = data
                    continuation.resume(returning: .success(resultParams))
                } else {
                    let error = NSError(domain: "RequestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request failed or no data"])
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
}
