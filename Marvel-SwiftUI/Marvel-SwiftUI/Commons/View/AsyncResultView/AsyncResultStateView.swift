//
//  AsyncResultStateView.swift
//  Gamefic
//
//  Created by Guilherme Silva on 17/06/24.
//

import SwiftUI
import Shimmer

struct AsyncResultStateView<Success, Content: View>: View {
    let result: AsyncResultState<Success>
    let content: (_ item: Success) -> Content

    init(result: AsyncResultState<Success>,
         @ViewBuilder content: @escaping (_ item: Success) -> Content) {
        self.result = result
        self.content = content
    }

    var body: some View {
        switch result {
            case .empty:
                Text("No results found!")
            case .loading:
                ProgressView()
            case let .success(value):
                content(value)
            case let .failure(error):
                Text(error.localizedDescription)
        }
    }
}

#Preview {
    var result: AsyncResultState<String> = .success("Success!!!")
    return AsyncResultStateView(result: result) { result in
            Text(result)
    }
}
