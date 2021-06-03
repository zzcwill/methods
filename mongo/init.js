/*
 Navicat Premium Data Transfer

 Source Server         : mongo-local
 Source Server Type    : MongoDB
 Source Server Version : 40404
 Source Host           : localhost:27017
 Source Schema         : shop

 Target Server Type    : MongoDB
 Target Server Version : 40404
 File Encoding         : 65001

 Date: 03/06/2021 17:01:01
*/


// ----------------------------
// Collection structure for comments
// ----------------------------
db.getCollection("comments").drop();
db.createCollection("comments");

// ----------------------------
// Documents of comments
// ----------------------------
session = db.getMongo().startSession();
session.startTransaction();
db = session.getDatabase("shop");
db.getCollection("comments").insert([ {
    _id: ObjectId("5ae20a927aec117179c68468"),
    lists: [
        {
            userId: "tom1",
            content: "tom评论1",
            commentTime: "2018-04-22 22:50:48.39"
        },
        {
            userId: "tom2",
            content: "tom评论2",
            commentTime: "2018-04-22 22:51:48.39"
        },
        {
            userId: "tom3",
            content: "tom评论3",
            commentTime: "2018-04-22 22:52:48.39"
        }
    ]
} ]);
db.getCollection("comments").insert([ {
    _id: ObjectId("5ae20a947aec117179c68469"),
    lists: [
        {
            userId: "tony1",
            content: "tony评论1",
            commentTime: "2018-04-22 22:50:48.39"
        },
        {
            userId: "tony2",
            content: "tony评论2",
            commentTime: "2018-04-22 22:51:48.39"
        },
        {
            userId: "tony3",
            content: "tony评论3",
            commentTime: "2018-04-22 22:52:48.39"
        }
    ]
} ]);
session.commitTransaction(); session.endSession();

// ----------------------------
// Collection structure for users
// ----------------------------
db.getCollection("users").drop();
db.createCollection("users");

// ----------------------------
// Documents of users
// ----------------------------
session = db.getMongo().startSession();
session.startTransaction();
db = session.getDatabase("shop");
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c880"),
    name: "xiaobu",
    country: "china",
    comments: [
        {
            userId: "001",
            content: "评论1",
            commentTime: "2018-04-22 22:50:48.39"
        },
        {
            userId: "002",
            content: "评论2",
            commentTime: "2018-04-22 22:51:48.39"
        },
        {
            userId: "003",
            content: "评论3",
            commentTime: "2018-04-22 22:52:48.39"
        },
        {
            userId: "004",
            content: "评论4",
            commentTime: "2018-04-22 22:53:48.39"
        },
        {
            userId: "005",
            content: "评论5",
            commentTime: "2018-04-22 22:54:48.39"
        },
        {
            userId: "006",
            content: "评论6",
            commentTime: "2018-04-22 22:55:48.39"
        },
        {
            userId: "007",
            content: "评论7",
            commentTime: "2018-04-22 22:56:48.39"
        },
        {
            userId: "008",
            content: "评论8",
            commentTime: "2018-04-22 22:57:48.39"
        },
        {
            userId: "009",
            content: "评论9",
            commentTime: "2018-04-22 22:58:48.39"
        }
    ],
    address: {
        aCode: "001",
        aName: "长沙"
    },
    favorites: {
        books: [
            "西游记",
            "红楼梦",
            "三国演义",
            "水浒传"
        ],
        cites: [
            "韶关",
            "深圳",
            "佛山"
        ],
        fruits: [
            "apple",
            "banana",
            "watermelon"
        ]
    },
    age: 26,
    salary: NumberDecimal("18889.09"),
    height: 1.7
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c881"),
    name: "juyi",
    country: "china",
    comments: [
        {
            userId: "101",
            content: "评论101",
            commentTime: "2018-04-22 22:50:48.39"
        },
        {
            userId: "102",
            content: "评论102",
            commentTime: "2018-04-22 22:51:48.39"
        }
    ],
    address: {
        aCode: "002",
        aName: "韶关"
    },
    favorites: {
        movies: [
            "肖生克的救赎",
            "阿甘正传",
            "头号玩家"
        ],
        cites: [
            "衡阳",
            "南宁",
            "上海",
            "深圳"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 25,
    salary: NumberDecimal("18889.09"),
    height: 1.5
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c882"),
    name: "tom",
    country: "USA",
    comments: DBRef("comments", ObjectId("5ae20a927aec117179c68468"), "test"),
    address: {
        aCode: "003",
        aName: "纽约"
    },
    favorites: {
        movies: [
            "头号玩家",
            "肖生克的救赎",
            "阿甘正传"
        ],
        cites: [
            "旧金山",
            "纽约"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 18,
    height: 1.88
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c883"),
    name: "tom",
    country: "USA",
    address: {
        aCode: "001",
        aName: "纽约"
    },
    favorites: {
        movies: [
            "头号玩家",
            "肖生克的救赎",
            "阿甘正传"
        ],
        cites: [
            "旧金山",
            "纽约"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 18,
    height: 1.88
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c884"),
    name: "tony",
    country: "USA",
    address: {
        aCode: "004",
        aName: "洛杉矶"
    },
    favorites: {
        books: [
            "权利的游戏",
            "飘",
            "谁动了我的奶酪"
        ],
        cites: [
            "芝加哥",
            "洛杉矶"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 28,
    height: 1.79
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c885"),
    name: "xiaoxiaobu",
    country: "USA",
    address: {
        aCode: "005",
        aName: "费城"
    },
    favorites: {
        books: [
            "权利的游戏",
            "教父"
        ],
        cites: [
            "芝加哥",
            "芝加哥",
            "洛杉矶"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 20,
    height: 1.71
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c886"),
    name: "lily",
    country: "USA",
    address: {
        aCode: "001",
        aName: "费城"
    },
    favorites: {
        books: [
            "权利的游戏",
            "飘",
            "谁动了我的奶酪"
        ],
        cites: [
            "芝加哥",
            "芝加哥",
            "洛杉矶"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 20,
    height: 1.71
} ]);
db.getCollection("users").insert([ {
    _id: ObjectId("60b88dfb30053217d852c887"),
    name: "xiaoxiao",
    country: "USA",
    address: {
        aCode: "001",
        aName: "费城"
    },
    favorites: {
        books: [
            "权利的游戏",
            "飘",
            "谁动了我的奶酪"
        ],
        cites: [
            "芝加哥",
            "芝加哥",
            "洛杉矶"
        ],
        fruits: [
            "durian",
            "watermelon"
        ]
    },
    age: 21,
    height: 1.71
} ]);
session.commitTransaction(); session.endSession();
