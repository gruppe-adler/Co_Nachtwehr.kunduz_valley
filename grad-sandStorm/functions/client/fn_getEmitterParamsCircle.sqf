params ["_type"];

private _params = [];


switch (_type) do { 
	case "borderBottom" : { 
		_params = [5,[random 2 - random 4, random 2 - random 4,0]];
	}; 
	
	case "borderTop" : { 
		_params = [5,[0,0,0]];
	};

	case "close": {
		_params = [10,[0,0,0]];
	};

	case "filler": {
		_params = [30,[0,0,0]];
	};

	case "fillerSmall": {
		_params = [30,[0,0,0]];
	};
	
	default { 
		hint "error: no circle emitter type defined";
		diag_log format ["error: no circle emitter type defined"];
	}; 
};

_params