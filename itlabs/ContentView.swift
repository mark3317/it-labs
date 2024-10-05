//
//  ContentView.swift
//  lab0
//
//  Created by Mark Nokhrin on 05.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(fibonacciSequence(count: 20), id: \.self) {
            Text("\($0)")
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

func fibonacciSequence(count: Int) -> [Int] {
    guard count > 0 else { return [] }
    var sequence = [0, 1]
    while sequence.count < count {
        let nextNumber = sequence[sequence.count - 1] + sequence[sequence.count - 2]
        sequence.append(nextNumber)
    }
    return Array(sequence.prefix(count))
}

#Preview {
    ContentView()
}
