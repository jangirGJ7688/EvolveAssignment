//
//  HomeDataModel.swift
//  EvolveAssignment
//
//  Created by Ganpat Jangir on 01/12/24.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Decodable {
    let status: Bool
    let data: [ItemModel]?
    let totalPages, premiumStatus: Int?
    let problemFilter: [ProblemFilter]?

    enum CodingKeys: String, CodingKey {
        case status, data
        case totalPages = "total_pages"
        case premiumStatus = "premium_status"
        case problemFilter = "problem_filter"
    }
}


// MARK: - Datum
struct ItemModel: Decodable {
    let id: Int?
    let title, juLabel, promoText: String?
    let description: String
    let juType: String?
    let juPremium: JuPremium?
    let numDays: Int?
    let thumbImage, coverImage: String?
    let juLink: String?
    let problems: [String]?
    let days: [Day]?
    let details: String?
    let sessions: String?
    let mins: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case juLabel = "ju_label"
        case promoText = "promo_text"
        case description
        case juType = "ju_type"
        case juPremium = "ju_premium"
        case numDays = "num_days"
        case thumbImage = "thumb_image"
        case coverImage = "cover_image"
        case juLink = "ju_link"
        case problems, days, details, sessions, mins
    }
}

// MARK: - ProblemFilter
struct ProblemFilter: Decodable {
    let title: String?
    let id: Int?
}

// MARK: - Day
struct Day: Decodable {
    let id: Int?
    let title, description: String?
    let numSteps: Int?
    let dayCompleted: DayCompleted?
    let completedSteps: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case numSteps = "num_steps"
        case dayCompleted = "day_completed"
        case completedSteps = "completed_steps"
    }
}


enum JuPremium: String, Decodable {
    case free = "Free"
    case premium = "Premium"
}

enum DayCompleted: String, Decodable {
    case no = "no"
    case yes = "yes"
}
