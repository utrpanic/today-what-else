import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var showLaunchDate: Bool = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    MissionListView(mission: mission, showLaunchDate: self.showLaunchDate)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button("Toggle") {
                    self.showLaunchDate = !self.showLaunchDate
                }
            )
        }
    }
}


struct MissionListView: View {
    
    let mission: Mission
    let showLaunchDate: Bool
    
    var astronautNames: String {
        return self.mission.crew.map { $0.name }.joined(separator: ", ")
    }
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(self.showLaunchDate ? mission.formattedLaunchDate : self.astronautNames)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
