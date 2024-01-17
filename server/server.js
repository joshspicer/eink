const express = require('express');
const morgan = require('morgan');
const serveStatic = require('serve-static');

const port = parseInt(process.env.PORT) || 3000;

console.log("Starting...")

process.on('SIGINT', function() {
    console.log("Caught interrupt signal");
    process.exit();
});

const updateNewspaper = (req, res, next) => {
    const { exec } = require('child_process');
    const child = exec('/opt/build.sh newspaper', (error, stdout, stderr) => {

        console.log(`stdout: ${stdout}`);
        console.error(`stderr: ${stderr}`);

        if (error) {
            console.error(`exec error: ${error}`);
            res.status(500);
            return next();
        }

        res.status(200);
        next();
    });
}

const app = express();

app.get('/update', updateNewspaper);
app.use(serveStatic('/usr/src/app/static'));

app.use(morgan('combined'));
app.listen(port, () => console.log(`Server listening on port ${port}!`));
 