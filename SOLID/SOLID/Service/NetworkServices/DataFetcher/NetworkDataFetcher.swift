//
//  NetworkDataFetcher.swift
//  SOLID
//
//  Created by dzmitry on 26.01.23.
//

import Foundation

// MARK: - DataFetcher

/*
 NetworkDataFetcher - Модуль нижнего уровня для DataFetcherService
 NetworkDataFetcher - Модуль высшего  уровня для NetworkService
 */

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

// MARK: - NetworkDataFetcher

class NetworkDataFetcher: DataFetcher {

    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }

    // MARK: Internal

    var networking: Networking

    // Когда будем вызывать, ф-я будет требовать возвращать обьект подписанный под Decodable
    // Что бы закрыь метод для модификации используем протоколы
    // Пробуем теперь удалить ф-ю / изменить параметры)
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        print("fetchGenericJSONData: T.self: \(T.self)")
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, data: data)
            response(decoded)
        }
    }

    // Декодирование Data в любую модель
    func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
