//
//  ContentView.swift
//  CanvasParticle
//
//  Created by Pedro Antunes on 24/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State var emitters: [CenterEmitter] = []

    let force = CGPoint(x: 0.0, y: 0.1)
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas(opaque: false, rendersAsynchronously: true) { context, size in
                for obj in emitters.enumerated() where !obj.element.finished {
                    obj.element.applyForce(force)
                    obj.element.emit(num: 10)
                    obj.element.show(context: context)
                    obj.element.update(timeline.date)
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 0).onEnded({ value in
            if emitters.count > 4 {
                emitters[emitters.count - 5].active = false
            }

            for i in (0..<emitters.count).reversed() where emitters[i].finished {
                emitters.remove(at: i)
            }
            emitters.append(CenterEmitter(position: value.location))
        }))
        .edgesIgnoringSafeArea(.all)
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension CGPoint {
    var simd2Float: SIMD2<Float> {
        SIMD2<Float>(arrayLiteral: Float(self.x), Float(self.y))
    }
}

