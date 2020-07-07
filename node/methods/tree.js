function convert(list) {
	var res = []
	var map = list.reduce(
		(res, v) => {
			res[v.id] = v;
			return res
		}, 
		{}
	)
	for (var item of list) {
		if (item.parentId === 0) {
			res.push(item)
			continue
		}
		if (item.parentId in map) {
			var parent = map[item.parentId]
			parent.children = parent.children || []
			parent.children.push(item)
		}
	}
	return res
}

var list =[
	{id:1,name:'部门A',parentId:0},
	{id:2,name:'部门B',parentId:0},
	{id:11,name:'部门C',parentId:1},
	{id:12,name:'部门D',parentId:1},
	{id:21,name:'部门E',parentId:2},
	{id:111,name:'部门F',parentId:11},
	{id:211,name:'部门G',parentId:21},
	{id:121,name:'部门H',parentId:12}
];
var result = convert(list);
console.info(result)