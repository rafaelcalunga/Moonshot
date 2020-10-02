//
//  MissionView.swift
//  Moonshot
//
//  Created by Rafael Calunga on 2020-10-02.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.primary, lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var maches = [CrewMember]()
        
        for member in mission.crew {
            
            if let match = astronauts.first(where: { $0.id == member.name }) {
                maches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missin astronaut \(member)")
            }
            
            /*for astronaut in astronauts {
                if astronaut.id == member.name {
                    maches.append(CrewMember(role: member.role, astronaut: astronaut))
                }
            }*/
        }
        
        self.astronauts = maches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[4], astronauts: astronauts)
    }
}
