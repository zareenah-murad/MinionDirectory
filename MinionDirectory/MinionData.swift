//
//  MinionData.swift
//  Minion
//
//  Created by Alexandra Geer on 9/22/24.
//

import Foundation

// Define the Minion struct if it's not already defined
struct MinionQuiz {
    let name: String
    let age: Int
    let bananaLove: Float
    let image: String
}

// Create the MinionData struct with a static minions array
struct MinionData {
    static let minions = [
        MinionQuiz(name: "Kevin", age: 9, bananaLove: 0.9, image: "Kevin"),
        MinionQuiz(name: "Bob", age: 6, bananaLove: 0.5, image: "Bob"),
        MinionQuiz(name: "Stuart", age: 7, bananaLove: 0.7, image: "Stuart"),
        MinionQuiz(name: "Carl", age: 7, bananaLove: 0.8, image: "Carl"),
        MinionQuiz(name: "Dave", age: 8, bananaLove: 0.6, image: "Dave")
    ]
}

