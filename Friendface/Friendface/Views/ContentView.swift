//
//  ContentView.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 23..
//

import SwiftUI

struct ContentView: View {
//    @StateObject var users = Users()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    let layout = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(users, id: \.self) { user in
                        NavigationLink {
                            UserDetailsView(user: user, users: users)
                        } label: {
                            UserCardView(user: user)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Friendface")
        }
        .task { @MainActor in
            let users = await fetchUsers()
            users.forEach { user in
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = UUID(uuidString: user.id)
                cachedUser.name = user.name
                cachedUser.age = Int16(user.age)
                cachedUser.about = user.about
                cachedUser.address = user.address
                
                user.friends.forEach { friend in
                    let cachedFriend = CachedFriend(context: moc)
                    cachedFriend.id = UUID(uuidString: friend.id)
                    cachedFriend.name = friend.name
                    cachedFriend.user = cachedUser
                }
            }
            
            try? moc.save()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
