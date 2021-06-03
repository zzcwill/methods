// 1
db.users.find().pretty();
db.users.find({}, { _id: 0, name:1, country: 1 }).pretty();
db.users.find({ name: 'tom'}, { _id: 0, name:1, country: 1 }).pretty();
db.users.aggregate([
	{ 
		$project: { 
			_id: 0,
			name: 1,
			rname:"$name",
			country: 1
		},
	},
	{
		$match: {
			name: 'tom'
		},
	}	
]).pretty();

// 2
db.users.distinct('name');
db.users.distinct('name').length;

// 3
db.users.find({age: 25});

// 4-$gte
db.users.find({age: { $gt: 25 }});

// 5-$lte
db.users.find({age: { $lt: 25 }});

// 6
db.users.find({age: { $gte: 25, $lte: 25 }});


