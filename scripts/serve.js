const http = require("http");
const fs = require("fs");
const path = require("path");

const PORT = 5000;
const STATIC_DIR = path.join(__dirname, "..", "static-build");

const MIME_TYPES = {
  ".html": "text/html",
  ".js": "application/javascript",
  ".json": "application/json",
  ".css": "text/css",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
  ".woff": "font/woff",
  ".woff2": "font/woff2",
  ".ttf": "font/ttf",
  ".otf": "font/otf",
};

function getMimeType(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  return MIME_TYPES[ext] || "application/octet-stream";
}

const server = http.createServer((req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.setHeader("expo-protocol-version", "1");

  if (req.method === "OPTIONS") {
    res.writeHead(204);
    res.end();
    return;
  }

  let urlPath = req.url.split("?")[0];
  
  if (urlPath === "/" || urlPath === "") {
    urlPath = "/index.html";
  }

  const filePath = path.join(STATIC_DIR, urlPath);
  const normalizedPath = path.normalize(filePath);

  if (!normalizedPath.startsWith(STATIC_DIR)) {
    res.writeHead(403);
    res.end("Forbidden");
    return;
  }

  fs.stat(normalizedPath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404);
      res.end("Not Found");
      return;
    }

    const mimeType = getMimeType(normalizedPath);
    res.writeHead(200, { "Content-Type": mimeType });

    const readStream = fs.createReadStream(normalizedPath);
    readStream.pipe(res);
    readStream.on("error", () => {
      res.writeHead(500);
      res.end("Server Error");
    });
  });
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Static server running at http://0.0.0.0:${PORT}`);
  console.log(`Serving files from: ${STATIC_DIR}`);
});
