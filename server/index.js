const express = require('express');
const app = express();

const PORT = 3003;

app.use(express.static('public'));
app.use('/images', express.static('images'));

app.get('/image/:imageName', (req, res) => {
    const imageName = req.params.imageName;
    const imagePath = `/images/${imageName}`;
    const faviconPath = '../favicon.png';

    // Construct HTML with image and metadata
    const htmlContent = `
    <!DOCTYPE html>
    <html>
      <head>
        <title>s.justinjongstra.nl | ${imageName}</title>
        <link rel="icon" type="image/png" href="${faviconPath}">
        <meta name="twitter:image" content="${imagePath}">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="Justin">
        <meta name="twitter:description" content=" ">
        <meta name="theme-color" content="#fa5560">
      </head>
      <body>
        <img src="${imagePath}" alt="${imageName}">
      </body>
    </html>
  `;

    res.send(htmlContent);
});

app.listen(PORT, () => {
    console.log(`Running server on PORT ${PORT}...`);
});

