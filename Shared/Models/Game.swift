//
//  Game.swift
//  Bullseye (iOS)
//
//  Created by Neelam Gurnani on 12/12/22.
//

import Foundation

struct Game {
    var target: Int = Int.random(in: 1...100)
    var score = 0
    var round = 1
    var leaderboardEntries: [LeaderboardEntry] = []
    
    init(loadTestData: Bool = false) {
        if loadTestData {
            leaderboardEntries.append(LeaderboardEntry(score: 100, date:Date()))
            leaderboardEntries.append(LeaderboardEntry(score: 30, date:Date()))
            leaderboardEntries.append(LeaderboardEntry(score: 200, date:Date()))
        }
    }
    
    func points(sliderValue: Int) -> Int {
        var points: Int
        var difference = abs(sliderValue - self.target)
        points = 100 - difference
        if (difference == 0) {
            points += 100
        } else if (difference <= 2) {
            points += 50
        }
        
        return points
    }
    
    mutating func startNewRound(points: Int) {
        score += points
        round += 1
        target = Int.random(in: 1...100)
        addToLeaderboard(point: points)
    }
    
    mutating func restart() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
    }
    
    mutating func addToLeaderboard(point: Int) {
        leaderboardEntries.append(LeaderboardEntry(score: point, date: Date()))
        leaderboardEntries.sort {$0.score > $1.score}
    }
}

struct LeaderboardEntry {
    let score: Int
    let date: Date
    
}
