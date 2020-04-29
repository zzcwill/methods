var fs = require('fs');

fs.readFile('./copy.js', function(err, data){
    if(err) return false;
    console.log('read done!');

    fs.writeFile('./copy2.js', data, (err) => {
        if(err) return false;
        console.log('write done!');
    });

    console.log('hi');
});

console.log('ok');