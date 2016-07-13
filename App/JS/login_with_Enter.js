// JavaScript code snippet for loggin in with "Enter" keypress
document.onkeypress = function(e) {
  var number = e.which;
  Shiny.onInputChange("pressedKey", number);
};
