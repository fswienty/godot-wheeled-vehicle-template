# Godot Wheeled Vehicle Template

This repository contains files to allow making arbitrary 2D wheeled vehicles in the Godot game engine. The basic concept is to simulate each wheel individually, which makes it possible to make a wide variaty vehicle with this, regardless of the amount of wheels or the steering.

The repository contains a couple example vehicles: a simple car, a motorbike, a truck with four-wheel-steering, a forklift with rear wheel steering, and the chassis of a crane with 12 wheels, 10 of which steer.

#### Structure
Vehicles are build like this:

- Rigidbody2D (with Vehicle.gd)
	- Node2D (named "Wheels")
		- [several wheels] (all with Wheel.gd)
	- Sprite2D (vehicle body texture)
	- CollisionShape2D
	
#### Vehicle.gd
The Vehicle.gd script receives the player's drive and steering input (wasd) and sends it along to each wheel. The variables do the following:

Grip: The grip of the tires, lower values cause more sliding

Steering Speed: How quickly the steering wheels steer

Steering Speed Decay: How much the maximum steering angle decreases with increasing velocity. Can be used to make the wheels steer less when at high speeds.

Center Steering: If true, the steering wheels return to their forward position when no steering input is given anymore. If false, they will stay at their current angle.

#### Wheel.gd
A single wheel is a Sprite2D with a wheel texture and a Wheel.gd script attached. Each wheel has several variables:

Is Steering: If true, the wheel will react to steering input.

Max Angle: The maximum angle the wheel can turn to

Power: How much force the wheel exerts when it is given drive input


#### You are free to use this for whatever you want, but I would be happy to hear about it if you make something cool out if this!
