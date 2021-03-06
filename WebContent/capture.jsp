<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

function updatePoint() {
	
	var chart = Highcharts.charts[0];
    var selectedPoint = chart.getSelectedPoints()[0];
    
    selectedPoint.myData = document.getElementById('point_comment').value;
	
}

function deletePoint() {
	
	var chart = Highcharts.charts[0];
    var selectedPoint = chart.getSelectedPoints()[0];
    
    if(chart.series[0].data.length > 1)
    	selectedPoint.remove();
    
   	document.getElementById('delete_point').disabled = true;
   	document.getElementById('point_comment').disabled = true;
   	document.getElementById('update_point').disabled = true;
	
}

function addPlotLine() {	 	 
	  
	  var startDate = document.getElementById('annotation_startdate').value;
	  var endDate = document.getElementById('annotation_enddate').value;
	  
	  startDate = Date.UTC(startDate.substring(0, 4), startDate.substring(5, 7), startDate.substring(8, 10));
	  endDate = Date.UTC(endDate.substring(0, 4), endDate.substring(5, 7), endDate.substring(8, 10));
	  
	  if(startDate > Highcharts.charts[0].xAxis[0].max || startDate < Highcharts.charts[0].xAxis[0].min)
		  alert('Date not within chart limit');
	  
	  if(startDate === endDate) {
	  
		  Highcharts.charts[0].xAxis[0].addPlotLine({
		        value: startDate,
		        color: (document.getElementById('annotation_color').value == "3")?("red"):((document.getElementById('annotation_color').value == "2")?("yellow"):("green")),
		      	zIndex: 1,
				label: {
					text: document.getElementById('annotation_name').value,
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
		        color: (document.getElementById('annotation_color').value == "3")?("red"):((document.getElementById('annotation_color').value == "2")?("yellow"):("green")),
		      	zIndex: 1,
				label: {
					text: document.getElementById('annotation_name').value,
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
		    
		    tooltip: {
		        /* positioner: function (labelWidth, labelHeight, point) {
		            return { x: point.plotX, y: point.plotY - 20 };
		        }, */
		        formatter: function() {
		            return (new Date(this.point.x)).toDateString() + ': <br>Intensity: ' + this.point.y  + '<br>Comment: <b>' + this.point.myData + '</b>';
		        }
		    },
		    
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
		    	dashStyle: 'longdash',
		        data: [{
		            y: 1,
		            myData: 'firstPoint'
		        }, {
		        	x: Date.UTC(2016, 1, 1),
		            y: 7,
		            myData: 'secondPoint'
		        }, {
		        	x: Date.UTC(2017, 1, 1),
		            y: 4,
		            myData: 'thirdPoint'
		        }],
		        pointStart: Date.UTC(2015, 1, 1),
		        //pointInterval: 31 * 24 * 3600 * 1000
		    }],
		    
		    plotOptions: {
		        series: {
		        	allowPointSelect: true,
		            lineWidth: 1,
		            point: {
		                events: {
		                    'click': function () {
		                    	
		                    	var chart = Highcharts.charts[0];
	                            var selectedPoints = chart.getSelectedPoints();
		                    	
		                        if (this.series.data.length > 1) {
		                            //this.remove();		                            
		                        }
		                        
		                        if(selectedPoints.length > 0) {
		                        	
		                            selectedPoints[0].select();		                            
		                        }
		                        
		                        document.getElementById('point_comment').value = this.myData;
		                        document.getElementById('point_comment').disabled = false;		                        
		                        document.getElementById('update_point').disabled = false;
		                        
		                        if(chart.series[0].data.length > 1)
		                        	document.getElementById('delete_point').disabled = false;
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

function buildChart2() {
	
	var prov = document.getElementsByName("prov");
	var app = document.getElementsByName("app");
	var insur = document.getElementsByName("insur");
	var fin = document.getElementsByName("fin");
	var info = document.getElementsByName("info");
	var social = document.getElementsByName("social");
	var react = document.getElementsByName("react");
	var thera = document.getElementsByName("thera");
	var medic = document.getElementsByName("medic");
	
	debugger;
	
	var data1 = [];
	var data2 = [null, null, null, null, null];

	for(var i = 0; i < 5; i++) {
	   if(prov[i].checked) {
	       data1.push(parseInt(prov[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data1.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(app[i].checked) {
	       data1.push(parseInt(app[i].value));
		   break;
	   }
	   
	   if(i == 4)
		   data1.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(insur[i].checked) {
	       data1.push(parseInt(insur[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data1.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(fin[i].checked) {
	       data1.push(parseInt(fin[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data1.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(info[i].checked) {
	       data1.push(parseInt(info[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data1.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(social[i].checked) {
	       data2.push(parseInt(social[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data2.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(react[i].checked) {
	       data2.push(parseInt(react[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data2.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(thera[i].checked) {
	       data2.push(parseInt(thera[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data2.push(null);
	}
	
	for(var i = 0; i < 5; i++) {
	   if(medic[i].checked) {
	       data2.push(parseInt(medic[i].value));
	       break;
	   }
	   
	   if(i == 4)
		   data2.push(null);
	}
	
	
	var xaxis = ['Find provider', 'Make appointment', 'Insurance cover', 'Financial accessibility', 'Inform others', 'Social withdrawal', 'People\'s reactions', 'Therapeutic care', 'Medication treatment'];
	var yaxis1 = ['Very easy', 'Easy', 'Neutral', 'Hard', 'Very hard'];
	var yaxis2 = ['Very low', 'Low', 'Neutral', 'High', 'Very high'];	
		
	  Highcharts.chart('container2', {
		  
		  	chart: {
		  		backgroundColor:'rgba(255, 255, 255, 0.5)'	
		  	},
		  	
		  	xAxis: [{
		  		categories: xaxis
		  	}],
		  	
		  	yAxis: [{
		  		type: 'category',
		  		categories: yaxis1,	
		  		title: {
		  			text: ''
		  		},
		  		min: 0,
		  		max: 4
		  	},{
		  		type: 'category',
		  		categories: yaxis2,	
		  		opposite: true,
		  		title: {
		  			text: ''
		  		},
		  		min: 0,
		  		max: 4
		  	}],
		  	
		  	series: [{
		  		type: 'column',
		  		data: data1
		  	},{
		  		yAxis: 1,
		  		type: 'column',
		  		data: data2
		  	}],
		  	
		  	title: {
		        text: ''
		    },
		    
		    subtitle: {
		        text: ''
		    },
		    
		    plotOptions: {
		        column: {
			        minPointLength: 3
			    }
		    },
		    
		    tooltip: {
		        formatter: function () {
		            var txt = this.series.xAxis.categories[this.point.x] + ' <br> ' + this.series.name + ' : ' + this.series.yAxis.categories[this.point.y];

		            return txt;
		        }

		    },
		    
		    exporting: {
		    	buttons: {
		        	contextButton: {
		        		verticalAlign: 'bottom',
		            }
		        }
		    },
		    
		  	credits: {
		        enabled: false
	    	},
	  });
}

window.onload = function() {
	
	buildChart();
	buildChart2();
	
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
<form action="capture" method="get" id="submit_form">
	<div class="w3-padding">
	     <div class="w3-row">
	     	<br><br><br>
			  <div id="container" style="height: 400px"></div>
			  
			  <table style="width: 100%;">
			  	<tr>
			  		<td style="width: 50%; vertical-align: top;">
			  			<h4>General information</h4>			  
							  <table>
							  	<tr>
							  		<td>
							  			<label>Number of care providers: &nbsp;</label>
							  		</td>
							  		<td>
							  			<input type="number" id="number_care_providers" name="num_prov" min="0" max="1000" value="0">&nbsp;&nbsp;&nbsp;&nbsp;
							  		</td>
							  		<td>
							  			<label>Number of insurance providers: &nbsp;</label>
							  		</td>		
							  		<td>
							  			<input type="number" id="number_insurance_providers" name="num_insur" min="0" max="1000" value="0">
							  		</td>
							  	</tr>
							  	<tr>
							  		<td>
							  			<label>Dollars spent: &nbsp;</label> $ <label id="dollars_spent_text">0</label>
							  		</td>
							  		<td>
							  			<input type="range" id="dollars_spent" name="doll_spent" min="0" max="500000" value="0" onchange="document.getElementById('dollars_spent_text').textContent = Math.ceil(this.value/1000) * 1000">&nbsp;&nbsp;&nbsp;
							  		</td>
							  		<td>
							  			<label>Number of changes in meds: &nbsp;</label>
							  		</td>		
							  		<td>
							  			<input type="number" id="changes_meds" name="num_meds" min="0" max="1000" value="0">
							  		</td>
							  	</tr>
							  	<tr>
							  		<td>
							  			<label>Addiction</label>
							  		</td>
							  		<td>
							  			<input type="checkbox" id="addiction" name="addict">&nbsp;&nbsp;&nbsp;
							  		</td>
							  		<td>
							  			<label>% of family members with mental illness: &nbsp;</label>
							  		</td>		
							  		<td>
							  			<input type="number" id="percent_family" name="perc_family" min="0" max="100" value="0">
							  		</td>
							  	</tr>							  	
							  </table>
						  <br>
						  <table style="width: 100%;">						  	
						  	<tr>
						  		<td>
						  		</td>
						  		<td>
						  			Very easy&nbsp;&nbsp;&nbsp;Easy&nbsp;&nbsp;&nbsp;Neutral&nbsp;&nbsp;&nbsp;&nbsp;Hard&nbsp;&nbsp;&nbsp;Very hard
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Ease of finding provider: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="prov1" name="prov" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="prov2" name="prov" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="prov3" name="prov" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="prov4" name="prov" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="prov5" name="prov" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Ease of making an appointment: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="app1" name="app" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="app2" name="app" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="app3" name="app" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="app4" name="app" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="app5" name="app" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Ease of having insurance cover MH: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="insur1" name="insur" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="insur2" name="insur" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="insur3" name="insur" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="insur4" name="insur" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="insur5" name="insur" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Ease of financial accessibility: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="fin1" name="fin" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="fin1" name="fin" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="fin1" name="fin" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="fin1" name="fin" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="fin1" name="fin" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Ease of informing others: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="info1" name="info" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="info2" name="info" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="info3" name="info" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="info4" name="info" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="info5" name="info" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  		</td>
						  		<td>
						  			Very low&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Low&nbsp;&nbsp;&nbsp;Neutral&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;High&nbsp;&nbsp;&nbsp;Very high
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Severity of social withdrawal: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="social1" name="social" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="social2" name="social" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="social3" name="social" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="social4" name="social" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="social5" name="social" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Intensity of people's reactions: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="react1" name="react" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="react2" name="react" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="react3" name="react" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="react4" name="react" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="react5" name="react" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Quality of therapeutic care: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="thera1" name="thera" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="thera2" name="thera" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="thera3" name="thera" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="thera4" name="thera" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="thera5" name="thera" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Quality of medication treatment: </label>
						  		</td>
						  		<td>
						  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="medic1" name="medic" value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="medic2" name="medic" value="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="medic3" name="medic" value="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="medic4" name="medic" value="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  			<input type="radio" id="medic5" name="medic" value="4">
						  		<br><br>
						  		</td>
						  	</tr>
						  	<tr>
						  		<td>
						  			<label>Current phase of journey: </label>
						  		</td>
						  		<td style="padding-top: 20px;">
						  			<select id="journey_phase" name="phase" style="font-size: 14px;">
									  <option value="1">1. Symptoms noticed</option>
									  <option value="2">2. Coping</option>
									  <option value="3">3. Seeking professional help</option>
									  <option value="4">4. Seeing therapist</option>
									  <option value="5">5. Changing therapists</option>
									  <option value="6">6. Starting drug therapy</option>
									  <option value="7">7. Cured/managed</option>
									  <option value="8">8. Relapse</option>
									</select>
									&nbsp;&nbsp;
									<input type="button" value="Generate" onclick="buildChart2()">
									<input type="button" value="Submit" onclick="submit()">
									<br><br>
						  		</td>
						  	</tr>
						  </table>
						  
						  	<script>
								function submit() {
									
									alert('Saving to database');
									
								    document.getElementById("submit_form").submit();
								}
							</script>
						  						  
			  		</td>
			  		<td style="width: 50%; vertical-align: top;">
			  			<h4>Add annotations</h4>		  			  
						  <table>
						  	<tr>			  		
						  		<td>
						  			<label>Annotation name: &nbsp;</label>
						  		</td>
						  		<td>
						  			<input type="text" id="annotation_name" style="width: 95%"> &nbsp;
						  		</td>			  		
						  		<td>
						  			<label>Importance (1-low) (3-high): &nbsp;</label>
						  		</td>
						  		<td>
						  			<input type="number" id="annotation_color" min="1" max="3" value="1">
						  		</td>			  					  	
						  	</tr>			  
						  	<tr>			  		
						  		<td>
						  			<label>Annotation date:</label>
						  		</td>
						  		<td>
						  			<input type="date" id="annotation_startdate" onchange="document.getElementById('add_plotLine').disabled = false; document.getElementById('annotation_enddate').value = document.getElementById('annotation_startdate').value;">
						  		</td>
						  		<td>
						  			<button id="add_plotLine" onclick="addPlotLine()" disabled="disabled">Add annotation</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  		</td>
						  		<td>
						  			<label style="display: none;">Annotation end date:</label>
						  		</td>
						  		<td>
						  			<input style="display: none;" type="date" id="annotation_enddate">
						  		</td>			  					  			  		
						  	</tr>
						  	</table>
						  <br>
					  	<h4>Point properties</h4>			  
						  <table>
							  	<tr>
							  		<td style="vertical-align: top;">
							  			<label>Point comments: &nbsp;</label>
							  		</td>
							  		<td>
							  			<textarea id="point_comment" cols="40" rows="5" disabled="disabled"></textarea>
							  		</td>
							  		<td style="vertical-align: top; padding-left: 10px">
							  			<button id="update_point" onclick="updatePoint()" style="width: 100%" disabled="disabled">Update point</button><br>
							  			<button id="delete_point" onclick="deletePoint()" style="width: 100%" disabled="disabled">Delete point</button>
							  		</td>
							  	</tr>
						  </table>
						  <br><br>
						  
						  <div id="container2" style="height: 350px"></div>	
			  		</td>			  		
			  	</tr>
			  </table>
				<br>
		  </div>
		
      </div>
     
</form>
      
<!-- Footer -->
<footer class="w3-container w3-theme-d3 w3-padding-16">
  <h5>1,000 Journeys</h5>
</footer>

<footer class="w3-container w3-theme-d5">
  <p>Powered by <a href="http://affectmh.org" target="_blank">Affect</a></p>
</footer>

</body>
</html>