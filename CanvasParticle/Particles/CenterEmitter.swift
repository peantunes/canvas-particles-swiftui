//
//  Emitter.swift
//  CanvasParticle
//
//  Created by Pedro Antunes on 24/02/2022.
//

import SwiftUI

class CenterEmitter {
    var active = true
    var particles: [Particle] = []
    var position: CGPoint
    init(position: CGPoint) {
        self.position = position
    }

    var finished: Bool {
        particles.isEmpty
    }

    func emit(num: Int) {
        if active {
            (0..<num).forEach { _ in particles.append(Particle(pos: position)) }
        }
    }

    func applyForce(_ force: CGPoint) {
        particles.forEach { $0.applyForce(force) }
    }

    func update(_ date: Date) {
        particles.forEach { $0.update() }
        for i in (0..<particles.count).reversed() {
            if particles[i].finished {
                particles.remove(at: i)
            }
        }
    }

    func show(context: GraphicsContext) {
        particles.reversed().forEach { $0.show(context: context) }
    }
}
