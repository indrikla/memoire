//
//  ContentView.swift
//  Memoire
//
//  Created by Risa on 22/02/25.
//

import SwiftUI

struct InteractiveParticleExplosion: View {
    @State private var particles: [Particle] = []
    
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                for particle in particles {
                    let rect = CGRect(
                        x: particle.position.x,
                        y: particle.position.y,
                        width: particle.size,
                        height: particle.size
                    )
                    let path = Path(ellipseIn: rect)
                    context.fill(path, with: .color(particle.color.opacity(particle.opacity)))
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        explode(at: value.location)
                    }
            )
            .onReceive(timer) { _ in
                updateParticles()
            }
        }
    }
    
    private func updateParticles() {
        let now = Date().timeIntervalSinceReferenceDate
        for index in particles.indices {
            particles[index].position.x += particles[index].velocity.dx
            particles[index].position.y += particles[index].velocity.dy
            
            let elapsed = now - particles[index].birthTime
            let progress = elapsed / particles[index].lifetime
            particles[index].opacity = max(0, 1 - progress)
            
            particles[index].velocity.dy += 0.05 // Simulate gravity
        }
        
        particles.removeAll { now - $0.birthTime >= $0.lifetime }
    }
    
    private func explode(at location: CGPoint) {
        let now = Date().timeIntervalSinceReferenceDate
        for _ in 0..<100 {
            let angle = Double.random(in: 0..<(2 * Double.pi))
            let speed = Double.random(in: 2...6)
            let velocity = CGVector(dx: cos(angle) * speed, dy: sin(angle) * speed)
            let particle = Particle(position: location, velocity: velocity, birthTime: now)
            particles.append(particle)
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGVector
    var size: CGFloat = CGFloat.random(in: 5...15)
    var color: Color = [.red, .orange, .yellow, .green, .blue, .purple].randomElement()!
    var opacity: Double = 1.0
    var lifetime: Double = Double.random(in: 1...3)
    var birthTime: TimeInterval
    
    init(position: CGPoint, velocity: CGVector, birthTime: TimeInterval) {
        self.position = position
        self.velocity = velocity
        self.birthTime = birthTime
    }
}
