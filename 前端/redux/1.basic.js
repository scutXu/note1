let initialState = {
	name: '',
	age: 0,
	friends: []
}
function reducer(previousState = initialState, action) {
	switch(action.type) {
		case 'SET_NAME':
			return Object.assign({}, previousState, { name: action.name });
		case 'SET_AGE':
			return Object.assign({}, previousState, { age: action.age });
		case 'ADD_FRIEND':
			return Object.assign({}, previousState, { friends: [...previousState.friends, action.name] });
		default:
			return previousState;
	}
}
let store = createStore(reducer, initialState);


function listener() {
	console.log(store.getState());
}
store.subscribe(listener);


let setNameAction = {
	type: 'SET_NAME',
	name: "joe"
}

let setAgeAction = {
	type: 'SET_AGE',
	age: 20
}

let addFriendAction = {
	type: 'ADD_FRIEND',
	name: 'lisa'
}

store.dispatch(setNameAction);
store.dispatch(setAgeAction);
store.dispatch(addFriendAction);

