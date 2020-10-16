const fs = require('fs');
const readable = fs.createReadStream('./read.txt');
const writeable = fs.createWriteStream('./write.txt');

// readable.pipe(writeable);

// end 读取结束时终止写入流，默认值是 true
readable.pipe(writeable, {
  end: false,
});
readable.on('end', function() {
  writeable.end('结束');
});

readable.on('error', function(err) {
  console.log('error', err);
  // writeable.close();
});