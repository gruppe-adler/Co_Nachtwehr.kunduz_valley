params ["_type"];

private _params = [];


switch (_type) do { 
	case "borderBottom" : { 
		_params = [0,[25,25,2],[0,0,0],3,0.5,[0,0,0,0],0,0];
	}; 
	
	case "borderTop" : { 
		_params = [0,[0,0,2],[0,0,0],3,0.5,[0,0,0,0],0,0];
	};

	case "close": {
		_params = [0,[0,0,2],[0,0,0],1,0.5,[0,0,0,0],0,0];
	};

	case "filler": {
		_params = [0,[100,100,0],[0,0,0],10,0.5,[0.1,0.1,0.1,0.1],0,0];
	};

	case "fillerSmall": {
		_params = [0,[0,0,2],[0,0,0],1,0.5,[0,0,0,0],0,0];
	};
	
	default { 
		hint "error: no random emitter type defined";
		diag_log format ["error: no random emitter type defined"];
	}; 
};

_params