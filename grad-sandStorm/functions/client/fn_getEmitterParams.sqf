params ["_emitter", "_type"];

private _params = [];


switch (_type) do {

	case "borderBottom" : { 
		_params = [
				    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 10 + random 5, 
				    [0,0,0], //position
				    [random 1 - random 2,random 1 - random 2,100 + random 5], // move velocity
				    25,         // rotation
				    2000, // weight
				    30, // volume
				    15, // rubbing
				    [
				        30,
				        40,
				        50,
				        60,
				        70,
				        80,
				        100,
				        110,
				        120,
				        130,
				        130,
				        130
				    ],
				    [
				        [0,0,0,0],
				        [0,0,0,1],
				        [0.05,0.05,0.05,0.9],
				        [0.05,0.05,0.05,0.88],
				        [0.06,0.06,0.06,0.85],
				        [0.07,0.07,0.07,0.82],
				        [0.1,0.1,0.1,0.9],
				        [0.3,0.2,0.2,0.7],
				        [0.4,0.3,0.3,0.6],
				        [0.4,0.3,0.3,0.5],
				        [0.4,0.3,0.3,0.4],
				        [0.4,0.3,0.3,0]
				    ],
				    [0.08], 
				    0.1, 
				    0.1, "", "", _emitter
				];
	};


	case "borderTop" : { 
		_params = [
				    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 7 + random 3, 
				    [0,0,0], //position
				    [random 2 - random 4,random 2 - random 4,50 + random 5], // move velocity
				    random 6,         // rotation
				    150, // weight
				    15, // volume
				    0.001, // rubbing
				    [
				        30,
				        50,
				        60,
				        70,
				        80,
				        90
				    ],
				    [
				        [0,0,0,0],
				        [0.1,0.1,0.1,0.9],
				        [0.15,0.15,0.15,0.8],
				        [0.2,0.2,0.15,0.7],
				        [0.4,0.3,0.2,0.6],
				        [0.4,0.3,0.2,0]
				    ],
				    [0.08], 
				    0.1, 
				    0.1, "", "", _emitter
				];

	}; 

	case "fillerSmall" : { 
		_params = [
				    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 7 + random 3, 
				    [0,0,0], //position
				    [random 2 - random 4,random 2 - random 4,150 + random 50], // move velocity
				    25,         // rotation
				    2000, // weight
				    30, // volume
				    15, // rubbing
				    [
				        30,
				        40,
				        50,
				        60,
				        70,
				        80,
				        100,
				        110,
				        120,
				        130,
				        130,
				        130
				    ],
				    [
				        [0,0,0,0],
				        [0,0,0,1],
				        [0.05,0.05,0.05,0.9],
				        [0.05,0.05,0.05,0.88],
				        [0.06,0.06,0.06,0.85],
				        [0.07,0.07,0.07,0.82],
				        [0.9,0.75,0.6,0.5],
				        [0.9,0.75,0.6,0.5],
				        [0.9,0.75,0.6,0.5],
				        [0.9,0.75,0.6,0.5],
				        [0.9,0.75,0.6,0.5],
				        [0.9,0.75,0.6,0]
				    ],
				    [0.08], 
				    0.1, 
				    0.1, "", "", _emitter
				];

	}; 

	case "close": {
		_params = [
				    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 6,
				    [0,0,-35], //position
				    [0,0,-10], // move velocity
				    1,         // rotation
				    20, // weight
				    30, // volume
				    40, // rubbing
				    [
				        50,
				        50,
				        50,
				        50,
				        50,
				        50
				    ],
				    [
				        [0,0,0,0],
				        [0.01,0.01,0.01,0.1],
				        [0.05,0.05,0.05,0.2],
				        [0.02,0.02,0.15,0.1],
				        [0.02,0.02,0.15,0.1],
				        [0.02,0.02,0.15,0]
				    ],
				    [0.8], 
				    0.1, 
				    0.1, "", "", _emitter
				];
	};

	case "filler": {
		private _dustSize = 100;

		_params = [
				    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 7, 
				    [0,0,0], //position
				    [0,0,100], // move velocity
				    60,         // rotation
				    70, // weight
				    13, // volume
				    0.001, // rubbing
				    [
				        _dustSize*3,
				        _dustSize*3.2,
				        _dustSize*3.3,
				        _dustSize*3.4,
				        _dustSize*3.5,
				        _dustSize*4
				    ],
				    [
				        [0,0,0,0],
				        [0.3,0.2,0.1,0.6],
				        [0.9,0.75,0.6,0.5],
				        [0.95,0.8,0.7,0.5],
				        [0.9,0.8,0.65,0.3],
				        [0.9,0.8,0.65,0]
				    ],
				    [0.08], 
				    0.1, 
				    0.1, "", "", _emitter
				];
	};
	
	default { 
		hint "error: no emitter subtype defined";
		diag_log format ["error: no emitter subtype defined"];
	}; 
};

_params