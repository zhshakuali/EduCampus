import Foundation

final class NetworkService {
    
    struct LoginResponse: Decodable {
        struct Payload: Decodable {
            let token: String
        }
        
        let payload: Payload
    }
    
    private struct Endpoints {
        static let loginURL = URL(string: "http://localhost:3000/login")!
        static let profileURL = URL(string: "http://localhost:3000/profile")!
        static let groupSchedule = URL(string: "http://localhost:3000/groupSchedule")!

                
        static let studentModule = URL(string: "http://localhost:3000/studentModule")!
    }
    
    static let shared = NetworkService()
    
    private var authorization = ""
    private let session = URLSession.shared
    private init() { }
    
    func login(id: String, password: String) async -> (Bool, String?) {
        let request = createURLRequest(
            for: Endpoints.loginURL, type: .POST,
            with: [
                "id": id,
                "password": password
            ]
        )
        do {
            let (data, response) = try await session.data(for: request)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data)
            else {
                return (false, nil)
            }
            
            authorization = loginResponse.payload.token
            
            return (true, nil)
        } catch {
            return (false, error.localizedDescription)
        }
    }
    
    func getProfile() async -> ProfileModel? {
        let request = createURLRequest(
            for: Endpoints.profileURL,
            type: .GET,
            headers: ["Authorization": authorization]
        )
        
        do {
            let (data, response) = try await session.data(for: request)
            print(request)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let profile = try? JSONDecoder().decode(ProfileModel.self, from: data)
                    
            else {
                return nil
            }
            
            return profile
        } catch {
            print(error)
            return nil
        }
    }
    

    func getSchedule() async -> ScheduleEntity? {
            let request = createURLRequest(
                for: Endpoints.groupSchedule,
                type: .GET,
                headers: ["Authorization": authorization]
            )
            
            do {
                let (data, response) = try await session.data(for: request)
                
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let scheduleResponse = try? JSONDecoder().decode(ScheduleEntity.self, from: data)
                else {
                    return nil
                }
                
                return scheduleResponse
            } catch {
                return nil
            }
        }
    
        
    func getCourses() async -> CourseEntity? {
            let request = createURLRequest(
                for: Endpoints.studentModule,
                type: .GET,
                headers: ["Authorization": authorization]
            )
            
            do {
                let (data, response) = try await session.data(for: request)
                
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let courseResponse = try? JSONDecoder().decode(CourseEntity.self, from: data)
                else {
                    return nil
                }
                
                return courseResponse
            } catch {
                return nil
            }
        }
    
    enum HTTPMethod: String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createURLRequest(
        for url: URL,
        type: HTTPMethod,
        headers: [String: String] = [:],
        with data: [String: Any] = [:]
    ) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = type.rawValue
        
        if !data.isEmpty { request.httpBody = try? JSONSerialization.data(withJSONObject: data) }
            
        
        
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
