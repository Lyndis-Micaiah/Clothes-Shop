require('dotenv').config();
const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const cors = require('cors');

const app = express();

// Enable CORS for frontend integration
app.use(cors());

// Ensure uploads directory exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Allowed file types for upload (security measure)
const allowedFileTypes = ['image/jpeg', 'image/png', 'image/webp'];

// Set up Multer storage engine
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads/'); // Save uploaded images in the `uploads` folder
  },
  filename: function (req, file, cb) {
    const safeFileName = file.originalname.replace(/\s+/g, '_'); // Replace spaces with underscores
    cb(null, safeFileName);
  }
});

// Multer file filter to allow only images
const fileFilter = (req, file, cb) => {
  if (allowedFileTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type. Only JPG, PNG, and WEBP are allowed!'), false);
  }
};

const upload = multer({ storage: storage, fileFilter: fileFilter });

// ✅ Upload an image
app.post('/upload', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded or invalid file type.' });
  }

  // Return the new image URL
  res.status(200).json({
    imageUrl: `http://localhost:3000/uploads/${req.file.filename}`
  });
});

// ✅ Delete an image
app.delete('/uploads/:filename', (req, res) => {
  const filePath = path.join(__dirname, 'uploads', req.params.filename);

  // Check if file exists before deleting
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      return res.status(404).json({ error: `File ${req.params.filename} not found.` });
    }

    fs.unlink(filePath, (err) => {
      if (err) {
        return res.status(500).json({ error: `Failed to delete ${req.params.filename}.` });
      }
      res.status(200).json({ message: `Deleted ${req.params.filename}` });
    });
  });
});

// ✅ Serve uploaded images
app.use('/uploads', express.static('uploads'));

// ✅ Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
