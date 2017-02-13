const spawn = require("child_process").spawn;
const children  = [];

process.on("exit", () => {
    process.stdout.write("killing", children.length, "child processes");
    children.forEach(child => {
        if(child){
            try {
                child.kill();
            } catch(e){
                process.stderr.write("failed to kill child process: " + e.Message);
            }
        }
    });
});

function spawnChild(cmd, args){

    const child = spawn(cmd, args);

    child.stdout.on("data", (data) => {
        process.stdout.write(data);
    });

    child.stderr.on("data", (data) => {
        process.stderr.write(data);
    });

    return child;
}

children.push(spawnChild("./cpp/async_server", [ "" ]));
setTimeout(() => {
    children.push(spawnChild("node", [ "./node/index.js" ]));
}, 100);