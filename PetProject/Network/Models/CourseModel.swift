//
//  CourseModel.swift
//  PetProject
//
//  Created by Жансая Шакуали on 02.05.2024.
//


import SwiftUI

struct CourseEntity: Codable {
    struct GroupInfo: Codable {
        let group: String
        let advisor: Int
    }
    
    struct Module: Codable, Identifiable {
        let id: Int
        let subject, description: String
    }
    
    let course: Int
    let groupInfo: GroupInfo
    let modules: [Module]
}

final class CoursesModel: ObservableObject {
    @Published var course: CourseEntity?
    
    private let networkService = NetworkService.shared
    
    func getCourses() async {
        course = await networkService.getCourses()
    }
}
