//
//  CommonAPIManager.swift
//  groby
//
//  Created by Daeyun Ethan on 08/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct CommonAPIManager {
    static func execute(_ request: RequestData,
                        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping ([String: Any]?) -> Void = { _ in },
                        onError: @escaping (Error) -> Void = { _ in }
    ) {
        dispatcher.dispatch(request: request,
                            onSuccess: {(responseData: Data) in
                                if responseData.isEmpty {
                                    onSuccess(nil)
                                } else {
                                    do {
                                        let result = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                                        DispatchQueue.main.async {
                                            onSuccess(result)
                                        }
                                    } catch let error {
                                        DispatchQueue.main.async {
                                            onError(error)
                                        }
                                    }
                                }
        },
                            onError: { (error: Error) in
                                DispatchQueue.main.async {
                                    onError(error)
                                }
        })
    }

    static func execute(_ request: RequestData,
                        imageData: Data,
                        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping ([String: Any]?) -> Void = { _ in },
                        onError: @escaping (Error) -> Void = { _ in }
        ) {
        dispatcher.dispatch(request: request,
                            onSuccess: {(responseData: Data) in
                                if responseData.isEmpty {
                                    onSuccess(nil)
                                } else {
                                    do {
                                        let result = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                                        DispatchQueue.main.async {
                                            onSuccess(result)
                                        }
                                    } catch let error {
                                        DispatchQueue.main.async {
                                            onError(error)
                                        }
                                    }
                                }
        },
                            onError: { (error: Error) in
                                DispatchQueue.main.async {
                                    onError(error)
                                }
        })
    }
}
