const { Router } = require('express');

const router = Router();

router.get('/_status', (req, res) => {
  res.send('I am up and running');
});

router.get('/test', (req, res) => {
  res.json({ message: 'hi' });
});



module.exports = router;
