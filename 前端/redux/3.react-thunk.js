import thunk from 'redux-thunk'

const store = createStore(
  reducer,
  applyMiddleware(thunk)
)

setTimeout(() => {
  store.dispatch(action)
}, 5000)


//传给store.dispatch的参数类型是函数
//该函数会以dispatch作为参数，被立即执行
store.dispatch(dispatch => {
	setTimeout(() => {
		dispatch(action)
	}, 5000)
})