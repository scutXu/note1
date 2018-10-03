function nameReducer(previousState = "", action) {

}

function ageReducer(previousState = 0, action) {

}

function friendReducer(previousState = [], action) {

}

//成员变量名对应state
const reducer = combineReducers({
	name: nameReducer,
	age: ageReducer,
	friends: friendReducer
})



//reducer函数名和state成员变量名一致时的写法
function name(previousState = "", action) {}
function age(previousState = 0, action) {}
function friends(previousState = [], action) {}
const reducer = combineReducers({
	name,
	age,
	friends
})

//combineReducer等价于
function reducer(state = {}, action) {
	return {
		name: nameReducer(state.name, action),
		age: ageReducer(state.age, action),
		friends: friendReducer(state.friends, action)
	};
}