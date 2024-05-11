//
//  ProfileModel.swift
//  PetProject
//
//  Created by Жансая Шакуали on 02.05.2024.
//

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let code: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let role: String
    let user: DataUser
}

// MARK: - DataUser
struct DataUser: Codable {
    let id: Int
    let firstName, lastName, patronymic, createdAt: String
    let updatedAt: String
    let student: Student
    
    var createdAtDate: String {
        DatesKit.format(createdAt, with: .weekdayMonthDayYear) ?? ""
    }
    
    var updatedAtDate: String {
        DatesKit.format(updatedAt, with: .weekdayMonthDayYear) ?? ""
    }
    
    enum CodingKeys: CodingKey {
        case id, firstName, lastName, patronymic, createdAt, updatedAt, student
    }
}

// MARK: - Student
struct Student: Codable {
    let faculty, specialization: String
 
}
