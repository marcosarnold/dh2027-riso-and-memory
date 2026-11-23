let blue;
let red;
let yellow;

function setup() {
  pixelDensity(1);
  frameRate(1);
  createCanvas(2000, 800);

  // create riso layers!
  red = new Riso('red');
  blue = new Riso('blue');
  yellow = new Riso('yellow');
}

// function to get quadrant modifier!
function quadrantShade(x, y) {
  let midX = width / 2;
  let midY = height / 2;
  
  if (x < midX && y < midY) return 0;
  else if (x >= midX && y < midY) return 20;
  else if (x < midX && y >= midY) return 40;
  else return 60
}

function draw() {
  // reset layers every 10 frames!
  if (frameCount % 10 === 1) {
    red.clear();
    blue.clear();
    yellow.clear();
  }

  let s = 100;
  background("white");

  red.noStroke();
  blue.noStroke();
  yellow.noStroke();

  for (let x = 140; x < width - 140; x += 140) {
    for (let y = 140; y < height - 140; y += 140) {

      // small random jitter for natural feel!
      let px = x + random(-20, 20);
      let py = y + random(-20, 20);

      // get quadrant modifier!
      let q = quadrantShade(x, y);

      red.fill(constrain(map(x, 0, width, 20 + q, 220 + q), 0, 255));
      red.ellipse(px, py, s + random(-20, 20), s + random(-20, 20));

      blue.fill(constrain(map(y, 0, height, 20 + q, 220 + q), 0, 255));
      blue.ellipse(px, py, s + random(-20, 20), s + random(-20, 20));

      yellow.fill(constrain(map(x, 0, width, 220 - q, 20 - q), 0, 255));
      yellow.ellipse(px, py, s + random(-20, 20), s + random(-20, 20));
    }
  }

  drawRiso();
}