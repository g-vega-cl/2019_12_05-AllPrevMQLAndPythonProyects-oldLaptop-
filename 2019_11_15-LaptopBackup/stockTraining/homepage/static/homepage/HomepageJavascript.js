function removeFooterBelowHeight(minimumHeight, minimumWidth) {
  if (minimumHeight.matches) { // If media query matches
    document.getElementById("homepageFooter").style.display = "none";
  }else{
  	document.getElementById("homepageFooter").style.display = "block";	
  }

  if (minimumWidth.matches) { // If media query matches
    document.getElementById("homepageFooter").style.display = "none";
  }else{
  	document.getElementById("homepageFooter").style.display = "block";	
  }
}

var minimumHeight = window.matchMedia("(max-height: 580px)")
var minimumWidth = window.matchMedia("(max-width: 992px)")
removeFooterBelowHeight(minimumHeight,minimumWidth) // Call listener function at run time
minimumHeight.addListener(removeFooterBelowHeight) // Attach listener function on state changes
minimumWidth.addListener(removeFooterBelowHeight) // Attach listener function on state changes

function hideLargeWebsiteContent(minimumHeight, minimumWidth) {
  if (minimumHeight.matches) { // If media query matches
    document.getElementById("mainSiteContainer").style.display = "none";
  }else{
  	document.getElementById("mainSiteContainer").style.display = "block";	
  }

  if (minimumWidth.matches) { // If media query matches
    document.getElementById("mainSiteContainer").style.display = "none";
  }else{
  	document.getElementById("mainSiteContainer").style.display = "block";	
  }
}

var minimumHeightSite = window.matchMedia("(max-height: 580px)")
var minimumWidthSite = window.matchMedia("(max-width: 992px)")
removeFooterBelowHeight(minimumHeightSite,minimumWidthSite) // Call listener function at run time
minimumHeightSite.addListener(hideLargeWebsiteContent) // Attach listener function on state changes
minimumWidthSite.addListener(hideLargeWebsiteContent) // Attach listener function on state changes

function hideLargeWebMobileContent(minimumHeight, minimumWidth) {
  if (minimumHeight.matches) { // If media query matches
    document.getElementById("mainMobileContainer").style.display = "block";
  }else{
  	document.getElementById("mainMobileContainer").style.display = "none";	
  }

  if (minimumWidth.matches) { // If media query matches
    document.getElementById("mainMobileContainer").style.display = "block";
  }else{
  	document.getElementById("mainMobileContainer").style.display = "none";	
  }
}

var minimumHeightMobile = window.matchMedia("(max-height: 580px)")
var minimumWidthMobile = window.matchMedia("(max-width: 992px)")
removeFooterBelowHeight(minimumHeightMobile,minimumWidthMobile) // Call listener function at run time
minimumHeightMobile.addListener(hideLargeWebMobileContent) // Attach listener function on state changes
minimumWidthMobile.addListener(hideLargeWebMobileContent) // Attach listener function on state changes

//////////////////////////////////////////////////////////


//JAVASCRIPT CHART.
var trace1 = {
  
  x: [ "2016-04-20", "2016-04-21", "2016-04-22", "2016-04-23", "2016-04-24"  ], 
  
  close: [116.019997, 116.610001, 117.910004, 118.989998, 119.110001], 
  
  decreasing: {line: {color: '#7F7F7F'}}, 
  
  high: [116.510002, 116.860001, 118.160004, 119.43, 119.379997], 
  
  increasing: {line: {color: '#17BECF'}}, 
  
  line: {color: 'rgba(31,119,180,1)'}, 
  
  low: [115.75, 115.809998, 116.470001, 117.940002, 118.300003], 
  
  open: [115.849998, 115.919998, 116.779999, 117.949997, 118.769997], 
  
  type: 'candlestick', 
  xaxis: 'x', 
  yaxis: 'y',
  hoverinfo: "none",
};

trace2 = {
  line: {width: 1}, 
  mode: 'lines', 
  name: 'Moving Average', 
  type: 'scatter', 
  x: [ "2016-04-20", "2016-04-21", "2016-04-22", "2016-04-23", "2016-04-24"  ], 
  y: [116.019997, 116.610001, 117.910004, 118.989998, 119.110001], 
  yaxis: 'y',
  marker: {color: '#E377C2'},
  hoverinfo: "none",
};

var plotlyData = [trace1,trace2];

var layout = {
  dragmode: 'zoom', 
  margin: {
    r: 10, 
    t: 25, 
    b: 40, 
    l: 60
  }, 
  showlegend: false, 
  xaxis: {
    autorange: true, 
    domain: [0, 1], 
    range: ['2017-01-03 12:00', '2017-02-15 12:00'], 
    title: 'Date', 
    type: 'date',
    rangeslider: {
		 visible: false
	 }
  }, 
  dragmode: "pan",
  yaxis: {
    type: 'linear',
    autorange: true
  },
  title: "USDCHF",
};

var config = {
	'scrollZoom': true,
};

Plotly.plot('IndexChartToolDiv', plotlyData, layout, config = config);