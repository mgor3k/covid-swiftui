//
//  Created by Maciej Gorecki on 31/12/2020.
//

import Combine

extension Publisher {
    /// A single value sink function that coalesces either one `Output` or one `Failure` as a `Result`-type.
    public func sink(result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                result(.failure(error))
            case .finished:
                break
            }
        }, receiveValue: { output in
            result(.success(output))
        })
    }
}
