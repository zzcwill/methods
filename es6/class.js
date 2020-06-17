class PersonClass{
	constructor(name) {
		this._name = name
		console.info(`Hi I am ${this._name}`)
	}
	eat(type) {
		console.info(`I am eating ${type}`)
		return this
	}
	wait(time) {
		return new Promise((resolve,reject) => {
			setTimeout(()=>{
				resolve(true)
			},time*1000)
		})
	}
	async sleep(time) {
		await this.wait(time)
		console.info(`等待了${time}秒...`)
		return new Promise((resolve,reject) => {
			resolve(this)
		})
	}	
}

let LazyMan = (name) => {
	return new PersonClass(name)
}

// 1
// LazyMan('Tony').eat('lunch').eat('dinner')

// 2
// LazyMan('Tony').sleep(3).then((data)=>{
// 	data.eat('junk food')
// })

// 3
let godo = async () => {
	let lazyman = await LazyMan('Tony').sleep(3)
	lazyman.eat('junk food')
}
godo()

