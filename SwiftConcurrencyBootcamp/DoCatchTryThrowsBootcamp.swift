//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Vlastimir Radojevic on 07.03.2024.
//

import SwiftUI

// do
// try catch
// throws

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive = true
    
    func getTitle() -> (String?, Error?) {
        if isActive {
            return ("NEW TEXT", nil)
        }
        return (nil, URLError(.badURL))
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT")
        }
        return .failure(URLError(.badURL))
    }
    
    func getTitle3() throws -> String? {
//        if isActive {
//            return "NEW TEXT"
//        }
        throw URLError(.badServerResponse)
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT"
        }
        throw URLError(.badServerResponse)
    }
}

class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    @Published var text: String = "Starting text."
    private let manager: DoCatchTryThrowsBootcampDataManager
    
    init(manager: DoCatchTryThrowsBootcampDataManager = .init()) {
        self.manager = manager
    }
    
    func fetchTitle() {
//        if let newTitle = manager.getTitle() {
//            text = newTitle
//        }
        /*
        let result = manager.getTitle2()
        switch result {
        case .success(let success):
            text = success
        case .failure(let failure):
            text = failure.localizedDescription
        }*/
        do {
            if let newTitle = try? manager.getTitle3() {
                text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            text = finalTitle
        } catch let error {
            text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(minWidth: 300, minHeight: 300)
            .background(.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowsBootcamp()
}
