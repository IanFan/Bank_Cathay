//
//  AmountViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

protocol AmountViewModelProtocol: AnyObject {
    func updateAmountUI()
}

class AmountViewModel: NSObject {
    weak var delegate: AmountViewModelProtocol?
    var savingsDic = [String: [AmountSavingModel]]()
    var fixedDepositsDic = [String: [AmountFixedDepositModel]]()
    var digitalsDic = [String: [AmountDigitalModel]]()
    
    func loadData(isRefresh: Bool = false) {
        let mainGroup = DispatchGroup()
        var loadError: Error?
        
        // Load USD account data
        mainGroup.enter()
        loadAccountData(account: "usd", isRefresh: isRefresh) { result in
            if case .failure(let error) = result {
                loadError = error
            }
            mainGroup.leave()
        }
        
        // Load KHR account data
        mainGroup.enter()
        loadAccountData(account: "khr", isRefresh: isRefresh) { result in
            if case .failure(let error) = result {
                loadError = error
            }
            mainGroup.leave()
        }
        
        // Notify when all tasks are complete
        mainGroup.notify(queue: .main) {
            if let error = loadError {
//                self.delegate?.showError(error)
            } else {
                self.delegate?.updateAmountUI()
            }
        }
    }
    
    func loadAccountData(account: String, isRefresh: Bool = false, completion: @escaping (Result<Void, Error>) -> Void) {
        let group = DispatchGroup()
        var loadError: Error?
        
        // Load savings
        group.enter()
        loadSavings(account: account, isRefresh: isRefresh) { result in
            if case .failure(let error) = result {
                loadError = error
            }
            group.leave()
        }
        
        // Load fixed deposits
        group.enter()
        loadFixedDeposits(account: account, isRefresh: isRefresh) { result in
            if case .failure(let error) = result {
                loadError = error
            }
            group.leave()
        }
        
        // Load digitals
        group.enter()
        loadDigitals(account: account, isRefresh: isRefresh) { result in
            if case .failure(let error) = result {
                loadError = error
            }
            group.leave()
        }
        
        // Notify when all tasks are complete
        group.notify(queue: .main) {
            if let error = loadError {
//                self.delegate?.showAmountError(error)
            } else {
                self.delegate?.updateAmountUI()
            }
        }
    }
    
    private func loadSavings(account: String, isRefresh: Bool, completion: @escaping (Result<[AmountSavingModel], Error>) -> Void) {
        var fileName: String
        if isRefresh {
            fileName = "\(account)Savings2"
        } else {
            fileName = "\(account)Savings1"
        }
        let fileExt = "json"
        
        let params = FileParams_amountSaving(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: AmountSavingLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.savingsList, !objs.isEmpty else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.savingsDic[objs[0].curr] = objs
                    completion(.success(objs))
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                }
            }
        })
    }
    
    private func loadFixedDeposits(account: String, isRefresh: Bool, completion: @escaping (Result<[AmountFixedDepositModel], Error>) -> Void) {
        var fileName: String
        if isRefresh {
            fileName = "\(account)Fixed2"
        } else {
            fileName = "\(account)Fixed1"
        }
        let fileExt = "json"
        
        let params = FileParams_amountFixedDeposit(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: AmountFixedDepositLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.fixedDepositList, !objs.isEmpty else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.fixedDepositsDic[objs[0].curr] = objs
                    completion(.success(objs))
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                }
            }
        })
    }
    
    private func loadDigitals(account: String, isRefresh: Bool, completion: @escaping (Result<[AmountDigitalModel], Error>) -> Void) {
        var fileName: String
        if isRefresh {
            fileName = "\(account)Digital2"
        } else {
            fileName = "\(account)Digital1"
        }
        let fileExt = "json"
        
        let params = FileParams_amountDigital(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: AmountDigitalLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.digitalList, !objs.isEmpty else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.digitalsDic[objs[0].curr] = objs
                    completion(.success(objs))
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                }
            }
        })
    }
}

extension AmountViewModel {
    func getSumByCurr(_ curr: String) -> Double {
        var sum: Double = 0
        if let objs = savingsDic[curr] {
            for obj in objs {
                sum += obj.balance
            }
        }
        if let objs = fixedDepositsDic[curr] {
            for obj in objs {
                sum += obj.balance
            }
        }
        if let objs = digitalsDic[curr] {
            for obj in objs {
                sum += obj.balance
            }
        }
        return sum
    }
}
