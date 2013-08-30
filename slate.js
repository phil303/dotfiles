// Configs
S.cfga({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.1,
  "checkDefaultsOnLoad" : true,
  "focusCheckWidthMax" : 3000
});

// Displays
var lapDisplay = "1440x900"
var cinemaDisplay = "2560x1440"
var auxDisplay = "1920x1080"

// Common Placements
halfX = {"x": "screenSizeX/2"};

// Laptop Config
var lapLeft = slate.operation("move", {
  "screen": lapDisplay,
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width": "screenSizeX/2",
  "height": "screenSizeY"
});

var lapRight = lapLeft.dup(halfX);

var lapBottomLeft = slate.operation("corner", {
  "screen": lapDisplay,
  "direction": "bottom-left",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var macbookMonitorLayout = slate.layout("macbookMonitor", {
  "MacVim" : {
    "operations": [lapRight],
    "ignore-fail": true,
    "repeat-last": true
  },
  "Google Chrome": {
    "operations": [lapLeft],
    "ignore-fail": true,
    "repeat-last": true
  },
  "iTerm": {
    "operations": [lapBottomLeft],
    "ignore-fail": true,
    "repeat-last": true
  }
});

// Two Monitor Config
var auxLeft = slate.operation("move", {
  "screen": auxDisplay,
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width": "screenSizeX/2",
  "height": "screenSizeY"
});

var auxRight = auxLeft.dup(halfX);
var cinemaLeft = auxLeft.dup({"screen": cinemaDisplay});
var cinemaRight = cinemaLeft.dup(halfX);

var auxTopRight = slate.operation("corner", {
  "screen": auxDisplay,
  "direction": "top-right",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var auxBottomRight = auxTopRight.dup({"direction": "bottom-right"});

var cinemaTopLeft = slate.operation("corner", {
  "screen": cinemaDisplay,
  "direction": "top-left",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var cinemaBottomLeft = cinemaTopLeft.dup({"direction": "bottom-left"});

var createWarntap = slate.operation("shell", {
  "command": "/usr/bin/osascript /Users/Philly/.dotfiles/scripts/create_warntap.scpt",
  "wait": true,
});

var warntapSequence = slate.operation("sequence", {
  "operations": [createWarntap, auxLeft]
});

var iTermHandling = function(windowObject) {
  // create warntap window and move current ones
  var warntap = new RegExp("warntap");
  var title = windowObject.title();
  if (title.match(warntap)) {
    windowObject.doOperation(auxLeft);
  } else {
    windowObject.doOperation(warntapSequence);
    windowObject.doOperation(cinemaBottomLeft);
  }
};

var iTermToggle = slate.operation("toggle", {
  "app": ["iTerm"]
});

// generalize this
// TODO: Doesn't work
var moreiTermHandling = function(windowObject) {
  // only hide non warntap windows
  var warntap = new RegExp("warntap");
  var title = windowObject.title();
  if (!(title.match(warntap))) {
    //windowObject.doOperation(iTermToggle);
  }
};

var twoMonitorLayout = slate.layout("twoMonitors", {
  "MacVim": {
    "operations": [cinemaRight],
    "ignore-fail": true,
    "repeat-last": true
  },
  "Google Chrome": {
    "operations": [cinemaTopLeft],
    "ignore-fail": true,
    "repeat-last": true
  },
  "HipChat": {
    "operations": [auxBottomRight],
    "ignore-fail": true,
    "repeat-last": true
  },
  "iTerm": {
    "operations": [iTermHandling],
    "ignore-fail": true,
    "repeat-last": true
  }
});

// Detect monitor setup
slate.default([lapDisplay], macbookMonitorLayout);
slate.default([cinemaDisplay, auxDisplay], twoMonitorLayout);

var oneMonitor = slate.operation('layout', {"name": macbookMonitorLayout});
var twoMonitor = slate.operation('layout', {"name": twoMonitorLayout});
var universalLayout = function() {
  if (S.screenCount() === 1) {
    oneMonitor.run()
  }
  if (S.screenCount() === 2) {
    twoMonitor.run()
  }
};

S.bnda({
  "1:ctrl": universalLayout,
  "2:ctrl": warntapSequence,
  "':cmd": moreiTermHandling
});