d = document;
var Pixelate = function (imagePath, output, options) {
  if (!imagePath || !output) {return;}
  options = options || {};
  var self = this;
  this.pixelDensity = options.pixelDensity || 130;
  this.start = Math.round(pixelDensity / 2);
  this.container = d.getElementById(output);
}
Pixelate.prototype = {
  constuctor : Pixelate,
  setup : function () {
    this.wrapper = d.createElement('div');
    this.wrapper.className = 'image';
    this.canvas = d.createElement('canvas');
  },
  loadImage : function () {
    this.image = new Image();
    this.image.src = imagePath;
    this.image.onload = function () {
      self.canvas.width = this.width;
      self.canvas.height = this.height;
      self.context = canvas.getContext('2d');
      self.context.drawImage(image, 0, 0);
      self.imgData = context.getImageData(0, 0, this.width, this.height).data;
      self.inc = Math.round(this.height / pixelDensity);
      self.getRGB = function(i) { return [imgData[i], imgData[i + 1], imgData[i + 2]]; };
    };
  },
  clearOutput : function () {
    this.container.innerHTML = '';
  },
  changeBlockSize : function (blockSize) {
    var blocks = d.getElementsByClassName('block');
    for (var i = 0, imax = blocks.length; i < imax; i++) {
      var block = blocks[i];
      block.style.width = blockSize;
      block.style.height = blockSize;
    }
  },
  renderFrame : function () {
    for (var i = start, imax = image.height; i < imax; i += inc) {
      var row = d.createElement('div');
      row.className = 'row';
      for (var j = start, jmax = image.width; j < jmax; j += inc) {
        var colorValue = getRGB((i * (image.width * 4)) + (j * 4));
        var block = d.createElement('div');
        block.className = 'block';
        block.style.backgroundColor = 'rgb(' + (colorValue.join(',')) + ')';
        row.appendChild(block);
      }
      this.wrapper.appendChild(row);
    }
    this.clearOutput();
    this.container.appendChild(wrapper);
  }
};
