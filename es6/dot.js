let a = {
	ok: false
}

let b = {
	...a,
	ok:!a.ok	
}
console.info(b)

let aa =[{
	ok2: 1	
}]

let bb = [
	...aa,
	{
		ok2: 2
	}	
]

console.info(bb)