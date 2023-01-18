console.log("Hello World");
//print ("hELLO wORLD")

const express = require('express');
const port = 3000
const app = express();


//Creating an API
app.listen(port,"0.0.0.0",()=>{
    console.log('Connected at port' + port);
});

