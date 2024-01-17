const express = require('express');
const morgan = require('morgan');

const port = parseInt(process.env.PORT) || 3000;

console.log("Starting...")

const getRoute = (req, res, next) => {
    next();
}

// Start express server
const app = express();
app.get('/', getRoute);

app.use(morgan('combined'));
app.listen(port, () => console.log(`Server listening on port ${port}!`));
 