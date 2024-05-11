//
//  ScheduleModel.swift
//  PetProject
//
//  Created by Жансая Шакуали on 02.05.2024.
//

import Foundation

import SwiftUI

struct ScheduleEntity: Codable {
    struct Schedule: Codable {
        let schedules: [ScheduleElement]
    }
    
    struct ScheduleElement: Codable, Identifiable {
        let id = UUID()
        let day: Int
        let hour, audience: String
        let userID, moduleID: Int
        let module: Module
        
        var weekday: String {
            DatesKit.weekday(from: day)
        }

        enum CodingKeys: String, CodingKey {
            case day, hour, audience
            case userID = "userId"
            case moduleID = "moduleId"
            case module
        }
    }
    
    struct Module: Codable {
        let id: Int
        let subject, description: String
    }
    
    let schedule: Schedule
}

final class ScheduleModel: ObservableObject {
    
    @Published var schedules: [ScheduleEntity.ScheduleElement]?
    
    private let netwrokService = NetworkService.shared
    
    @MainActor
    func getSchedule() async {
        schedules = await netwrokService.getSchedule()?.schedule.schedules
    }
}
