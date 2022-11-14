//
//  Users.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 27..
//

import Foundation

class Users: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { @MainActor in
            users = await fetchUsers()
        }
    }
    
    func findUserBy(id: String) -> User? {
        return users.first { user in
            user.id == id
        }
    }
    
    func fetchUsers() async -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([User].self, from: data)
        } catch {
            print("Error while fetching or decoding json from internet", error.localizedDescription)
        }
        return []
    }
}
