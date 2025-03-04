const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs'); // To handle file system operations
const app = express();

// Ensure uploads directory exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Set up storage engine for Multer for saving files to `uploads` folder
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads/'); // Save uploaded images in the `uploads` folder
  },
  filename: function (req, file, cb) {
    const safeFileName = file.originalname.replace(/\s+/g, '_'); // Replace spaces with underscores
    cb(null, safeFileName); // Save the image with the modified name
  }
});

const upload = multer({ storage: storage });

// Endpoint to handle image upload
app.post('/upload', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).send('No file uploaded.');
  }

  // Return the new image URL (from `uploads` folder)
  res.status(200).json({
    imageUrl: `http://localhost:3000/uploads/${req.file.filename}`
  });
});

// DELETE endpoint to remove an image from the `uploads` folder
app.delete('/uploads/:filename', (req, res) => {
  const filePath = path.join(__dirname, 'uploads', req.params.filename);

  // Check if file exists
  fs.unlink(filePath, (err) => {
    if (err) {
      return res.status(404).send(`Cannot DELETE ${req.params.filename}`);
    }
    res.status(200).send(`Deleted ${req.params.filename}`);
  });
});

// Serve the uploaded images from the `uploads` folder
app.use('/uploads', express.static('uploads'));  // This serves images from `uploads` folder

// Start the server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
