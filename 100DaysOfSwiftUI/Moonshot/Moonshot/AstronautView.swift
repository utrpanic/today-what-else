import SwiftUI

struct AstronautView: View {
    
    let wholeAstronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let wholeMissions: [Mission] = Bundle.main.decode("missions.json")
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        self.missions =  self.wholeMissions.filter { mission in
            mission.crew.contains { $0.name == astronaut.id }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
                ForEach(self.missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.wholeAstronauts)) {
                        MissionListView(mission: mission, showLaunchDate: true)
                            .frame(width: geometry.size.width, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
