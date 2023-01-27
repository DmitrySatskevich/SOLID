//
//  NetworkService.swift
//  SOLID
//
//  Created by dzmitry on 26.01.23.
//

import Foundation

// Модуль нижнего уровня для NetworkDataFetcher

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

// MARK: - NetworkService

final class NetworkService: Networking {

    // Что бы закрыь метод для модификации используем протокол Networking
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    // MARK: Private

    func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: requst, completionHandler: { data, _, error in
            DispatchQueue.main.async { completion(data, error) }
        })
    }
}
