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

// 7
db.users.find({name: { $regex : /bu/ }});

// 8
db.users.find({name: { $regex : /^ju/ }});
db.users.find({name: { $regex : /bu$/ }});

// 9
db.users.find({},{_id: 0, name:1, age:1});

// 10
db.users.find({},{"comments":0});

// 11
db.users.find({ age: {$gt:25}},{ age:1, name:1});

// 12
db.users.find().sort({age:1});
db.users.find().sort({age:-1});

// 13
db.users.find().limit(3);

// 14
db.users.find().skip(3);

// 15
db.users.find().skip(3).limit(3);

// 16
db.users.find(
	{
		age:{
			$in: [25,26]
		}
	},
	{
		_id:0,
		name: 1,
		age:1	
	}
);
db.users.find(
	{
		$or:[
			{
				age: 25
			},
			{
				age: 26
			}
		]
	},
	{
		_id:0,
		name: 1,
		age:1	
	}
);

// 18
db.users.find({comments:{$exists:true}});
db.users.aggregate([
	{ 
		$project: { 
			_id: 0,
			name: 1,
			rname:"$name",
			comments: 1
		},
	},
	{
		$match: {
		  comments: {
				$nin: [null]
			}
		},
	}	
]);

// 20
db.users.find(
{ 
	name: { $regex : /bu/ },
	age: { $in: [25, 26] }
}
);

// 21
db.users.distinct('age');

// 22
db.users.find({name: 'xiaobu'},{'comments':{$slice: [0, 3]}});

// 23
db.users.find({name: 'xiaobu'},{'comments':{$slice: [3, 3]}, $id :1});

// 24
db.users.find({comments:{'userId': '101', 'content': '评论101', 'commentTime' : '2018-04-22 22:50:48.39'}});

// 25
db.users.find({"comments.userId":{$in:["001", "101"]}});

// 26
db.users.find({"comments":{$elemMatch:{"userId": "101", "content": "评论101"}}});

// 27
var tom = db.users.findOne({_id :ObjectId( "60b88dfb30053217d852c882")});
var dbref = tom.comments;
db[dbref.$ref].findOne({_id :dbref.$id});





