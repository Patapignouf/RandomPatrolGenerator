
params ["_smokePosition"];

private _src = "#particlesource" createVehicleLocal (_smokePosition); // Creates the local emitter on player

_src setParticleParams [
	["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1], // [0] ShapeName: Texture sheet layout
	"",                                                              // [1] AnimationName: Empty, obsolete
	"Billboard",                                                     // [2] Type: Textures face the camera
	1,                                                               // [3] TimerPeriod: Internal frame clock
	30,                                                              // [4] LifeTime: 90s duration for extreme altitude
	[0, 0, 0],                                                       // [5] Position: Relative spatial spawn offset
	[0, 0, 2],                                                     // [6] MoveVelocity: Vertical push vector on Z axis
	0.1,                                                             // [7] RotationVelocity: Texture spin rate
	1,                                                             // [8] Weight: Particle mass density
	1,                                                               // [9] Volume: Particle volume displacement
	0.45,                                                            // [10] Rubbing: Friction and wind drag coefficient
	[1.5, 5, 10, 20, 30],                                           // [11] Size: Width growth array over lifetime
	[[0, 0.4, 0, 0.6], [0.05, 0.3, 0.05, 0.4], [0.1, 0.2, 0.1, 0.2], [0.1, 0.1, 0.1, 0]], // [12] Color: RGBA transparency fade
	[0.5],                                                           // [13] AnimationPhase: Playback behavior
	1,                                                               // [14] RandomDirectionPeriod: Cycle refresh
	0,                                                               // [15] RandomDirectionIntensity: Power of shifts
	"",                                                              // [16] OnTimerScript: Script on animation step
	"",                                                              // [17] BeforeDestroyScript: Script upon death
	_src,                                                            // [18] Object: Emitter target handle binding
	0,                                                               // [19] Angle: Initial texture roll rotation
	false,                                                           // [20] OnSurface: Snapping to water or ground
	-1                                                               // [21] BounceOnSurface: Ground collision (-1 = disabled)
];

_src setParticleRandom [
	10,                                                              // 1. LifeTime variance
	[0.5, 0.5, 0.2],                                                 // 2. Position variance
	[0.4, 0.4, 0.2],                                                 // 3. Velocity variance (creates rolling volutes)
	2,                                                               // 4. Rotation variance
	0.3,                                                             // 5. Size variance
	[0, 0, 0, 0.1],                                                  // 6. Color alpha variance
	0,                                                               // 7. Direction period
	0                                                                // 8. Direction intensity
];

_src setDropInterval 0.05;                                           // Particle spawn density rate


"Chemlight_green" createVehicle (_smokePosition);
