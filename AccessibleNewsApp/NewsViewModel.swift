//
//  NewsViewModel.swift
//  AccessibleNewsApp
//
//  Created by nika razmadze on 29.12.23.
//

import Foundation


class NewsViewModel: ObservableObject {
    @Published var articles = [Article]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-11-29&sortBy=publishedAt&apiKey=65dae9fca8a44369b2297014f1e710ce") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.articles
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

}
