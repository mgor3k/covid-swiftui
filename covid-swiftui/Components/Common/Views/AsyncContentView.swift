//
//  Created by Maciej Gorecki on 01/01/2021.
//

import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    init(source: Source,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retry: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}
