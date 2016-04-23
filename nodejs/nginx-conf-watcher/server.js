var fs = require('fs');
var path = require('path');
const exec = require('child_process').exec;

function restartNginx() {
    const child = exec('/usr/local/nginx/script/restart.sh',
    (error, stdout, stderr) => {
        if (stdout)
            console.log(`stdout: ${stdout}`);

        if (stderr)
            console.log(`stderr: ${stderr}`);

        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
    });
}

var watcher = fs.watchFile('/vagrant/nginx/conf/nginx.conf', (curr, prev) => {
    console.log('Nginx config file changed!');
    restartNginx();
});