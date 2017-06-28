<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Capture Journeys</title>

<link rel="shortcut icon" type="image/x-icon" href="Images/favicon.ico"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="main.css">

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script type="text/javascript">

function addPlotLine() {	 	 
	  
	  var startDate = document.getElementById('event_startdate').value;
	  var endDate = document.getElementById('event_enddate').value;
	  
	  startDate = Date.UTC(startDate.substring(0, 4), startDate.substring(5, 7), startDate.substring(8, 10));
	  endDate = Date.UTC(endDate.substring(0, 4), endDate.substring(5, 7), endDate.substring(8, 10));
	  
	  if(startDate > Highcharts.charts[0].xAxis[0].max || startDate < Highcharts.charts[0].xAxis[0].min)
		  alert('Date not within chart limit');
	  
	  if(startDate === endDate) {
	  
		  Highcharts.charts[0].xAxis[0].addPlotLine({
		        value: startDate,
		        color: (document.getElementById('event_color').value == "3")?("red"):((document.getElementById('event_color').value == "2")?("yellow"):("green")),
		      	zIndex: 1,
				label: {
					text: document.getElementById('event_name').value,
			        verticalAlign: 'middle',
			        textAlign: 'center'
		        },
		        width: 2
	    	});
	  }
	  else if(endDate < startDate)
		  alert('End date is before the start date');
	  else {
		  
		  Highcharts.charts[0].xAxis[0].addPlotBand({
			  	from: startDate,
			  	to: endDate,
		        color: (document.getElementById('event_color').value == "3")?("red"):((document.getElementById('event_color').value == "2")?("yellow"):("green")),
		      	zIndex: 1,
				label: {
					text: document.getElementById('event_name').value,
			        verticalAlign: 'middle',
			        textAlign: 'center'
		        },
		        width: 2
		  });
		  
	  }
	  
}

function buildChart() {
	  Highcharts.chart('container', {
		  	chart: {
		        events: {
		            click: function (e) {
		                // find the clicked values and the series
		                var x = Math.round(e.xAxis[0].value),
		                    y = Math.round(e.yAxis[0].value),
		                    series = this.series[0];

		                // Add it
		                series.addPoint([x, y]);

		            }
		        },
		        
		        backgroundColor:'rgba(255, 255, 255, 0.5)'
		    },
		    
		  	title: {
		        text: 'John Doe\'s journey'
		    },
		    
		    subtitle: {
		        text: 'Add points by clicking anywhere on the white space - Remove by clicking the points themselves'
		    },
		    
		    legend: {
	            enabled: false
	        },
		    
		    /* tooltip: {
		        positioner: function (labelWidth, labelHeight, point) {
		            return { x: point.plotX, y: point.plotY - 20 };
		        }
		    }, */
		    
		    xAxis: {
		    	tickInterval: 31 * 24 * 3600 * 1000,
		        type: 'datetime',
		        plotLines: [{
		            color: 'yellow',
		            width: 2,
		            zIndex: 1,
		            value: Date.UTC(2015, 4, 1),
		            label: {
		                text: 'First symptoms: Services on campus',
		                verticalAlign: 'middle',
		                textAlign: 'center'
		            }
		        },{
		        	color: 'red',
		            width: 2,
		            zIndex: 1,
		            value: Date.UTC(2015, 7, 1),
		            label: {
		                text: 'Psychiatrist: Major depression diagnosis',
		                verticalAlign: 'middle',
		                textAlign: 'center'
		            }
		        },{
		        	color: 'yellow',
		            width: 2,
		            zIndex: 1,
		            value: Date.UTC(2015, 10, 1),
		            label: {
		                text: 'Started taking Antidepressants',
		                verticalAlign: 'middle',
		                textAlign: 'center'
		            }
		        },{
		        	color: 'red',
		            width: 2,
		            zIndex: 1,
		            value: Date.UTC(2016, 5, 1),
		            label: {
		                text: 'Insurance dropped Psychiatrist',
		                verticalAlign: 'middle',
		                textAlign: 'center'
		            }
		        }],
		        dateTimeLabelFormats: { // don't display the dummy year
                  month: '%b %y',
                  year: '%Y'
              }
		    },
	
		    yAxis: {
		    	title: {
		            text: 'Intensity of the event (0-10)'
		        },
		        min: 0,
		        max: 10
		    },
	
		    series: [{
		    	name: 'Mental health journey',
		        data: [0, 2, 5, 9, 10, 10, 10, 9, 9, 9, 8, 8, 7, 6, 5, 5, 4, 7, 6, 6, 5, 5, 4],
		        pointStart: Date.UTC(2015, 1, 1),
		        pointInterval: 31 * 24 * 3600 * 1000
		    }],
		    
		    plotOptions: {
		        series: {
		            lineWidth: 1,
		            point: {
		                events: {
		                    'click': function () {
		                        if (this.series.data.length > 1) {
		                            this.remove();
		                        }
		                    }
		                }
		            }
		        }
		    },
		    
		    exporting: {
		        enabled: true
		    },
		    
		    credits: {
		        enabled: false
		    },
		});
}

window.onload = function() {
	
	buildChart();
	
}

</script>

</head>
<body class="w3-theme-l5" style="overflow: hidden; background-size:cover;" background="Images/Cover-page.png">

<!-- Navbar -->
<div class="w3-top">
 <div class="w3-bar w3-theme-d2 w3-left-align w3-large">
  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large w3-theme-d4"><i class="fa fa-home w3-margin-right"></i>Home</a>
 </div>
</div>

<!-- Navbar on small screens -->
<div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium w3-large">
  <a href="#" class="w3-bar-item w3-button w3-padding-large">Sign in</a>
</div>

	<div class="w3-padding">
	     <div class="w3-row">
	     	<br><br><br>
			  <div id="container" style="height: 400px"></div>	
			  <h4>Add major events</h4>		  			  
			  <table>
			  	<tr>			  		
			  		<td>
			  			<label>Event name: &nbsp;</label>
			  		</td>
			  		<td>
			  			<input type="text" id="event_name" style="width: 169px"> &nbsp;
			  		</td>			  		
			  		<td>
			  			<label>Importance (1-low) (3-high): &nbsp;</label>
			  		</td>
			  		<td>
			  			<input type="number" id="event_color" min="1" max="3" value="1">
			  		</td>			  		
			  	</tr>			  
			  	<tr>			  		
			  		<td>
			  			<label>Event start date:</label>
			  		</td>
			  		<td>
			  			<input type="date" id="event_startdate" onchange="document.getElementById('add_plotLine').disabled = false; document.getElementById('event_enddate').value = document.getElementById('event_startdate').value;">
			  		</td>
			  		<td>
			  			<label>Event end date:</label>
			  		</td>
			  		<td>
			  			<input type="date" id="event_enddate">
			  		</td>
			  		<td>
			  			<button id="add_plotLine" onclick="addPlotLine()" disabled="disabled">Add event line</button>
			  		</td>			  		
			  	</tr>
			  	</table>
			  <br>

		  </div>
		
      </div>
      
<!-- Footer -->
<footer class="w3-container w3-theme-d3 w3-padding-16">
  <h5>1,000 Journeys</h5>
</footer>

<footer class="w3-container w3-theme-d5">
  <p>Powered by <a href="http://affectmh.org" target="_blank">Affect</a></p>
</footer>

</body>
</html>