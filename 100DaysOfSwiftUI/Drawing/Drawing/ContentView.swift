import SwiftUI

struct ContentView: View {
    
    var body: some View {
//        Triangle()
//            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .strokeBorder(Color.blue, lineWidth: 10)
        Circle()
            .strokeBorder(Color.blue, lineWidth: 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
