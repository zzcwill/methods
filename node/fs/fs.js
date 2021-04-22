let fs = require('fs')
let os = require('os')

//文件是否存在-不推荐使用
let judgeIsExists = (dir) => {
	return new Promise((resolve,reject) => {
		fs.exists(dir,(err,exists) =>{
			console.info(exists)
			if(err) {
				return reject(err)
			}		
			resolve(exists)
		})		
	})
}

//是否目录
let judgeIsDirectory = (dir) => {
	return new Promise((resolve,reject) => {
		fs.stat(dir,(err,data) =>{
			if(err) {
				return reject(err)
			}

			// console.info(data.isFile())
			// console.info(data.isDirectory())			
			resolve(data.isDirectory())
		})		
	})
}

//创建目录
let mkdir = (dir) => {
	return new Promise((resolve,reject) => {
		fs.mkdir(dir,(err) =>{
			if(err) {
				return reject(err)
			}
			resolve(dir)
		})		
	})
}

//创建写入文件-不断创建会被覆盖
let writeFile = (filename,data) => {
	return new Promise((resolve,reject) => {
		fs.writeFile(filename,data,(err) =>{
			if(err) {
				return reject(err)
			}
			resolve(true)
		})		
	})
}

//读文件数据
let readFile = (filename) => {
	return new Promise((resolve,reject) => {
		fs.readFile(filename,'utf8',(err,data) =>{
			if(err) {
				return reject(err)
			}
			resolve(data)
		})		
	})
}

//追加文件数据
let appendFile = (filename) => {
	return new Promise((resolve,reject) => {
		fs.appendFile(filename,'appendFileData' + os.EOL,(err) =>{
			if(err) {
				return reject(err)
			}
			resolve(true)
		})		
	})
}

//文件重命名
let rename = async (filename) => {
	let isExists = await judgeIsExists(filename)
	
	if(!isExists) {
		return false
	}

	return new Promise((resolve,reject) => {
		fs.rename(filename,__dirname + '/fs/renameData3.txt',(err) =>{
			if(err) {
				return reject(err)
			}
			resolve(true)
		})		
	})
}

//目录删除
let rmdir = async (dirname) => {
	let isExists = await judgeIsDirectory(dirname)
	
	if(!isExists) {
		return false
	}

	return new Promise((resolve,reject) => {
		fs.rmdir(dirname,(err) =>{
			if(err) {
				return reject(err)
			}
			resolve(true)
		})		
	})
}

let getData = async () => {
	let isDirectory = await judgeIsDirectory(__filename)
	// console.info(isDirectory)

	// let dir = await mkdir(__dirname + '/fs')	
	// console.info(dir)

	let isNew = await writeFile(__dirname + '/fs/'+ 'newsFs.txt','zzc')
	//console.info(isNew)

	let readData = await readFile(__dirname + '/fs/'+ 'fsData.txt')
	//console.info(readData)

	let appendFileData = await appendFile(__dirname + '/fs/'+ 'fsData2.txt')
	//console.info(appendFileData)

	// console.info('--')

	let renameData = await rename(__dirname + '/fs/'+ 'fsData3.txt')
	//console.info(renameData)	

	let rmdirData = await rmdir(__dirname + '/fs/fs2')
	console.info(rmdirData)	
}


getData()
