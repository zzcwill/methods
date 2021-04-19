// 数组去重
// Set
// reduce
// _.uniqBy

// let arr = [1, 22, 33, 44, 22, 44];

// console.log([...new Set(arr)]); //[1, 22, 33, 44]


// let hash = {};

// function unique(arr, initialValue){
//     return arr.reduce(function(previousValue, currentValue, index, array){
//         hash[currentValue.name] ? '' : hash[currentValue.name] = true && previousValue.push(currentValue);
//         return previousValue
//     }, initialValue);
// }

// const uniqueArr = unique([{name: 'zs', age: 15}, {name: 'lisi'}, {name: 'zs'}], []);

// console.log(uniqueArr); // uniqueArr.length == 2