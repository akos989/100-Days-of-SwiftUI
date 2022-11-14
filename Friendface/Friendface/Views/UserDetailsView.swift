//
//  UserDetailsView.swift
//  Friendface
//
//  Created by Morvai Ákos on 2022. 09. 23..
//

import SwiftUI
import MapKit

struct UserDetailsView: View {
    let user: CachedUser
    var users: FetchedResults<CachedUser>
    @State var topExpanded = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: "https://100k-faces.glitch.me/random-image")!) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 150)
                            .padding(.all)
                        }
                        .frame(width: geo.size.width * 0.4)
                        
                        VStack(alignment: .leading) {
                            Text("Age: \(user.age)")
                                .font(.headline)
                            Text(user.email ?? "Unknown email")
                            Text(user.company ?? "Unknown company")
                        }
                        .frame(width: geo.size.width * 0.6, alignment: .leading)
                    }
//                    LazyVGrid(columns: [GridItem(.flexible(minimum: 80))]) {
//                        ForEach(user.tags, id: \.self) { tagName in
//                            Text(verbatim: tagName)
//                                .padding(8)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.gray.opacity(0.2))
//                                )
//                        }
//                    }
                    
                    DisclosureGroup("Address: \(user.address ?? "Unknown address")", isExpanded: $topExpanded) {
                        Map(coordinateRegion: $region)
                            .frame(width: geo.size.width * 0.8, height: 300)
                    }
                    .padding(.horizontal)
                    Text(user.about ?? "")
                        .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(getFriendsFor(user: user)) { friend in
                                Text(friend.name ?? "Unkown name")
//                                NavigationLink {
//                                    if let user = users.findUserBy(id: friend.id) {
//                                        UserDetailsView(user: user, users: users)
//                                    }
//                                } label: {
//                                    Text(friend.name)
//                                }
                                
                            }
                        }
                    }
                    Spacer()
                    Text(user.registered?.formatted(date: .long, time: .omitted) ?? "Unknown registerd date")
                        .frame(alignment: .bottom)
                }
                .frame(maxWidth: geo.size.width, minHeight: geo.size.height)
            }
        }
        .navigationTitle(user.name ?? "Unknown name")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getFriendsFor(user: CachedUser) -> [CachedFriend] {
        let set = user.friends as? Set<CachedFriend> ?? []
        return set.sorted {
            ($0.name ?? "") < ($1.name ?? "")
        }
    }
}
