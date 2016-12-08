
// ************** LINE CHART **************** //
function draw_line_chart(data_map, div_id, title) {

    // convert input data into arrays
    var school_names = Object.keys(data_map);

    // constants that determine the sizes of all the elements
    const WIDTH = $(div_id).width(), HEIGHT = 400, Y_OFFSET = 0, X_OFFSET = 10;

    // add title
    $('.inner').append("<div id='title'></div>");
    var svg = d3.select('#title').append("svg").attr("height", 100).attr("width", WIDTH);

    svg.append("text")
    .attr("x", (WIDTH / 2))
    .attr("y", Y_OFFSET/4)
    .attr("text-anchor", "middle")
    .style("font-size", "24px")
    .style('fill', 'black')
    .text(title);


    // create the canvas
    svg = d3.select(div_id).append("svg").attr("height", HEIGHT).attr("width", WIDTH);
    var rainbow = d3.scaleSequential(d3.interpolateRainbow).domain([0,school_names.length]);

    for ( var school_index = 0 ; school_index < school_names.length ; school_index ++ ) {
    	var academic_years = [];
    	var school_enrollments = [];
    	for ( var i = 0, data = data_map[school_names[school_index]] ; i < data.length ; i++ ) {
    		academic_years.push( data[i][0] );
    		school_enrollments.push( data[i][1] );
    	}
        // sort the years
        academic_years.sort( function(a,b){ return a-b } );

        // get the boundary variables
        var maxEnrollment = Math.max.apply(null, school_enrollments);
        var minEnrollment = Math.min.apply(null, school_enrollments);
        var maxYear = academic_years[academic_years.length - 1];
        var minYear = academic_years[0];
        console.log("min e: " + minEnrollment);
        console.log("max e: " + maxEnrollment);

        // construct the axis
        var y = d3.scaleLinear()
        .domain([0, int_ceiling(maxEnrollment)])
        .range([(HEIGHT-Y_OFFSET), 0]);
        var yAxis = d3.axisLeft(y);
        var x = d3.scaleLinear().domain([minYear, maxYear]).range([0,WIDTH*3/4]);
        var xAxis = d3.axisBottom(x);

	    // declare the line graph
	    var line = d3.line(school_enrollments)
	    .x( function(d,i){ return X_OFFSET + x(academic_years[i]); } )
	    .y( function(d,i){ return y(d);} )
	    .curve(d3.curveNatural);

	    // draw the line graph
	    var chartGroup = svg.append("g").attr("transform", "translate(50,50)" );
	    chartGroup.append("path")
	    .attr("fill", "none")
	    .attr("stroke", rainbow(school_index))
	    .attr("d", line(school_enrollments));

	    // add circles to the locations of the data points
	    chartGroup.selectAll("circle")
	    .data(school_enrollments)
	    .enter().append("circle")
	    .attr("cx", function(d,i){ return X_OFFSET + x(academic_years[i]); })
	    .attr("cy", function(d,i){ return y(d); })
	    .attr("r", "2");
    }

    // add x-axis
    chartGroup.append("g")
    .attr("class", "axis x")
    .attr("transform", "translate(" + X_OFFSET + ", " + y(0) + ")")
    .call(xAxis);
    console.log("bottom " + y(0));

    // add y-axis
    chartGroup.append("g")
    .attr("class", "axis y")
    .attr("transform", "translate(" + X_OFFSET + ",0)")
    .call(yAxis);

    // label x-axis
    svg.append("text")
    .attr("class", "x label")
    .attr("text-anchor", "end")
    .attr("x", x(maxYear+1))
    .attr("y", HEIGHT - 10)
    .text("Year");

    // label y-axis
    svg.append("text")
    .attr("class", "y label")
    .attr("text-anchor", "end")
    .attr("y", 6)
    .attr("dy", ".75em")
    .attr("transform", "rotate(-90)")
    .text("Total Elementary Enrollment");

}


function int_ceiling( x ) {
	if ( parseInt(x, 10) % 100 == 0 ) return x;
	return 100 * ( parseInt(x/100,10) + 1 );
}


// ************** BAR CHART **************** //

function draw_bar_chart(data_map, div_id, title) {

	var labels = Object.keys(data_map);
	var data = Object.values(data_map);
	var maxData = Math.max.apply( null, data );

	// constants that determine the sizes of all the elements
	const Y_OFFSET = 50, COLUMN_WIDTH = 50, COLUMN_INTERVAL = 10, COLUMN_HEIGHT = 1;
	const 
		// WIDTH = X_OFFSET + (COLUMN_WIDTH + COLUMN_INTERVAL) * labels.length,
		WIDTH = $(div_id).width(),
	 	HEIGHT = COLUMN_HEIGHT * maxData + Y_OFFSET*3;
	 	GRAPH_WIDTH = (COLUMN_WIDTH + COLUMN_INTERVAL) * labels.length,
	 	X_OFFSET = (WIDTH - GRAPH_WIDTH)/2;

	// scale the x-axis
	var rainbow = d3.scaleSequential(d3.interpolateRainbow).domain([0,labels.length]);
	var labelEndpoints = labelEndpointsPosition(X_OFFSET, COLUMN_WIDTH, COLUMN_INTERVAL, labels.length );
	var x = d3.scaleOrdinal().domain(labels).range(
		createArrayRange(labelEndpoints[0], labelEndpoints[1], COLUMN_WIDTH + COLUMN_INTERVAL)
	);
	var xAxis = d3.axisBottom(x);

	// create svg
	var svg = d3.select(div_id).append("svg").attr("height", HEIGHT).attr("width", WIDTH);

	// draw the bar chart
	svg.selectAll("rect")
		.data(data)
		.enter().append("rect")
		.attr("class", ".bartext")
		.attr("height", function(d,i){return d*COLUMN_HEIGHT;})
		.attr("width", COLUMN_WIDTH)
		.attr("fill",function(d,i) {return rainbow(i);})
		.attr("x", function(d,i){return X_OFFSET+i*(COLUMN_WIDTH + COLUMN_INTERVAL);})
		.attr("y",function(d,i){return HEIGHT - Y_OFFSET -(d*COLUMN_HEIGHT);});

	// draw the x-axis
	svg.append("g")
		.attr("class","x axis")
		.attr("transform","translate(0," + (HEIGHT-Y_OFFSET+10) + ")")
		.call(xAxis);

	// graph title
	svg.append("text")
		.attr("x", (WIDTH / 2))             
		.attr("y", Y_OFFSET)
		.attr("text-anchor", "middle")  
		.style("font-size", "24px")   
		.style('fill', 'black')
		.text(title);

	// add labels
	svg.selectAll("text.labels").
		data(data)
		.enter().append("text")
		.attr("x", function(d,i){
			var offset = 0;
			if ( d > 99 ) offset = COLUMN_WIDTH/8;
			else if ( d > 9 ) offset = COLUMN_WIDTH/4;
			else offset = COLUMN_WIDTH/2;
			return offset + X_OFFSET+i*(COLUMN_WIDTH + COLUMN_INTERVAL)
		;})
		.attr("y", function(d,i){return HEIGHT-Y_OFFSET-(d*COLUMN_HEIGHT);} )
		.attr("dx", "0.3em")
		.attr("dy", -5)
		.style('fill', 'black')
	 	.text(String);
}

// create an array of numbers of the form x = start + i*interval
// where start <= x <= end
function createArrayRange( start, end, interval ) {
	arr = []
	for ( var x = start ; x <= end ; x+= interval ) {
		arr.push(x);
	}
	return arr;
}

// find the x-position of the first and last labels
// each label should be at the center of the corresponding
function labelEndpointsPosition( xOffset, columnWidth, columnInterval, numberOfColumns ) {
	var start = xOffset + columnWidth / 2;
	var end = xOffset + (columnWidth + columnInterval) * numberOfColumns - columnInterval - columnWidth / 2;
	return [start, end]
}



// ************** PIE CHART **************** //
function draw_pie_chart(data_map, div_id) {
	// variables to determine the canvas size
	var width = 400;
	var height = 400;
	var radius = 150;
	var color = d3.scaleOrdinal(d3.schemeCategory20);
	var svg = d3.select(div_id)
	  .append('svg')
	  .attr('width', width)
	  .attr('height', height)
	  .append('g')
	  .attr('transform', 'translate(' + (width / 2) +
	    ',' + (height / 2) + ')');
	var arc = d3.arc().innerRadius(0).outerRadius(radius);
	var labelArc = d3.arc().outerRadius(radius + 50).innerRadius(radius);
	var pie = d3.pie()
	  .value(function(d) { return d.count; })
	  .sort(null);

	// draw the pie chart
    var g = svg.selectAll(".arc")
    	.data(pie(data_map))
    	.enter().append("g")
    	.attr("class", "arc");
    g.append("path")
    	.attr("d", arc)
    	.style("fill", function(d){ return color(d.data.label); });

    // add value inside the pies
    g.append("text")
    	.attr("transform", function(d){ 
    		return "translate(" + labelArc.centroid(d) + ")"; 
    	})
    	.attr("dy", ".35em")
    	.attr("text-anchor", "middle")
    	.attr("class", "outsideLabel")
    	.text( function(d) { return d.data.label; });

    // add labels outside the pies
    g.append("text")
    	.attr("transform", function(d) {
    		return "translate(" + arc.centroid(d) + ")";
    	})
    	.attr("class", "insideLabel")
    	.text(function(d){ return d.data.count; } );
}
