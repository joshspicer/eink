const express = require('express');
const morgan = require('morgan');
const serveStatic = require('serve-static');

const port = parseInt(process.env.PORT) || 3000;
const debug = process.env.DEBUG || false;

console.log("Starting...")

process.on('SIGINT', function () {
    console.log("Caught interrupt signal");
    process.exit();
});

const updateNewspaper = (req, res) => {
    const { exec } = require('child_process');
    const mode = req.query.mode;

    // JSON request body
    let jsonData = '';
    req.on('data', (chunk) => {
        jsonData += chunk;
    });

    req.on('end', () => {
        if (!mode) {
            res.sendStatus(400);
            return;
        }
        exec(`/opt/build.sh ${mode} "${jsonData}"`, (error, stdout, stderr) => {

            if (debug || error) {
                console.log(`stdout: ${stdout}`);
                console.error(`stderr: ${stderr}`);
            }

            if (error) {
                console.error(`exec error: ${error}`);
                res.sendStatus(500);
            } else {
                res.sendStatus(202);
            }
        });
    });
}

const app = express();
app.use(morgan('combined'));
app.use(serveStatic('/usr/src/app/static'));

app.patch('/update', updateNewspaper);

app.listen(port, () => console.log(`Server listening on port ${port}!`));
