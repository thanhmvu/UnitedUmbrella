function render_graph(data, labels) {

	var maxData = Math.max.apply( null, data );

	// constants that determine the sizes of all the elements
	const Y_OFFSET = 50, COLUMN_WIDTH = 50, COLUMN_INTERVAL = 10, COLUMN_HEIGHT = 5;
	const 
		// WIDTH = X_OFFSET + (COLUMN_WIDTH + COLUMN_INTERVAL) * labels.length,
		WIDTH = $('#graph1').width(),
	 	HEIGHT = 2650,
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
	var svg = d3.select("#graph1").append("svg").attr("height", HEIGHT).attr("width", WIDTH);

	// draw the bar chart
	svg.selectAll("rect")
		.data(data)
		.enter().append("rect")
		.attr("class", ".bartext")
		.attr("height", function(d,i){return d*COLUMN_HEIGHT;})
		.attr("width", COLUMN_WIDTH)
		.attr("fill",function(d,i) {return rainbow(i);})
		.attr("x", function(d,i){return X_OFFSET+i*(COLUMN_WIDTH + COLUMN_INTERVAL);})
		.attr("y",function(d,i){return HEIGHT-Y_OFFSET-(d*COLUMN_HEIGHT);});

	// draw the x-axis
	svg.append("g")
		.attr("class","x axis")
		.attr("transform","translate(0," + (HEIGHT-Y_OFFSET+10) + ")")
		.call(xAxis);

	// graph title
	svg.append("text")
		.attr("x", (WIDTH / 2))             
		.attr("y", 30)
		.attr("text-anchor", "middle")  
		.style("font-size", "32px")   
		.style('fill', 'black')
		.text("Number of Schools by LEA_TYPE");

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
