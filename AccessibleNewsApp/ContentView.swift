//
//  ContentView.swift
//  AccessibleNewsApp
//
//  Created by nika razmadze on 29.12.23.
//

import SwiftUI
import UIKit

//Mark: SwiftUI - View
struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var userText = "Default Text"

    var body: some View {
        ListWrapper(articles: $viewModel.articles) 
    }
}

//Mark: View Representable
struct ListWrapper: UIViewRepresentable {
    @Binding var articles: [Article]

    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        return tableView
    }

    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

//Mark: Coordinator
class Coordinator: NSObject, UITableViewDataSource {
    var parent: ListWrapper

    init(_ parent: ListWrapper) {
        self.parent = parent
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parent.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let article = parent.articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        return cell
    }
}

#Preview {
    ContentView()
}
