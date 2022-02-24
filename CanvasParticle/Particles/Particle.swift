//
//  Particle.swift
//  CanvasParticle
//
//  Created by Pedro Antunes on 24/02/2022.
//

import SwiftUI
import Accelerate
import simd

class Particle {
    let id = UUID()
    var pos: SIMD2<Float>
    var vel: SIMD2<Float>
    var acc: SIMD2<Float>
    var r: Double = 32
    var lifetime: Double = 255
    let color: Color = .init(.sRGB, red: Double.random(in: 0.5...1.0), green: Double.random(in: 0.5...1), blue: Double.random(in: 0...1.0))

    init(pos: CGPoint) {
        self.pos = pos.simd2Float
        vel = SIMD2<Float>.random(in: -2.0...2.0)
        acc = SIMD2<Float>(arrayLiteral: 0, 0)
    }

    var finished: Bool {
        lifetime < 0
    }

    func applyForce(_ force: CGPoint) {
        acc = acc + force.simd2Float
    }

    func update() {
        vel = vel + acc
        pos = pos + vel
        acc = SIMD2<Float>(arrayLiteral: 0, 0)
        lifetime -= 4
    }

    func show(context: GraphicsContext) {
        let circle = Path(ellipseIn: CGRect(origin: CGPoint(x: CGFloat(pos.x), y: CGFloat(pos.y)), size: CGSize(width: r, height: r)))
        context.fill(circle, with: .color(color.opacity(lifetime/255)))
    }
}
