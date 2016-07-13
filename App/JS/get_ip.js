document.onclick = function httpGet(e)
{
    var theUrl = "https://api.ipify.org/?format=txt";
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
    xmlHttp.send( null );
    // return xmlHttp.responseText;
    Shiny.onInputChange("ipResponse", xmlHttp.responseText);
}; 
