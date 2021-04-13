// 守护进程

const spawn = require('child_process').spawn;

function startDaemon() {
    const daemon = spawn('node', ['app.js'], {
        cwd: '.',
        detached : true,
        stdio: 'ignore',
    });

    console.log('守护进程开启 父进程 pid: %s, 守护进程 pid: %s', process.pid, daemon.pid);
    daemon.unref();
}

startDaemon()