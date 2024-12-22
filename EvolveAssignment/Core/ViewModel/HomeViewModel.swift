//
//  HomeViewModel.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 01/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private var totalItems = [ItemModel]()
    @Published var bottomItems: [ItemModel] = []
    @Published var filterKeywords: [ProblemFilter] = [ProblemFilter(title: "All", id: 100)]
    @Published var filerSelected = "All" {
        didSet {
            filterData()
        }
    }
    @Published var searchedText = ""
    @Published var isAPICallInProgress = false
    private var currentPage = 0
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.fetchData()
        $searchedText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { string in
                self.searchFilter(filterText: string)
            }
            .store(in: &cancellable)
    }
    
    func fetchData() {
        if self.isAPICallInProgress == true {
            return
        }
        self.isAPICallInProgress = true
        self.currentPage += 1
        NetworkManager.shared.fetchData(pageNumber: self.currentPage) { result in
            switch result {
            case .success(let data):
                if let bottomItems = data.data {
                    self.totalItems.append(contentsOf: bottomItems)
                    DispatchQueue.main.async {
                        self.isAPICallInProgress = false
                        self.filterKeywords.append(contentsOf: data.problemFilter ?? [])
                        self.filterData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func filterData() {
        if self.filerSelected == "All" {
            self.bottomItems = self.totalItems
        } else {
            self.bottomItems = self.totalItems.filter({ item in
                if let problems = item.problems {
                    return problems.contains(where: {$0 == self.filerSelected})
                }
                return false
            })
        }
    }
    
    private func searchFilter(filterText: String) {
        if filterText == "" {
            self.bottomItems = self.totalItems
        } else {
            self.bottomItems = self.totalItems.filter { item in
                if let title = item.title {
                    return title.lowercased().contains(filterText.lowercased())
                }
                return true
            }
        }
    }
    
    func hasReachedLast(_ item: ItemModel) -> Bool {
        if let last = self.totalItems.last {
            return last.id == item.id
        }
        return false
    }
}
