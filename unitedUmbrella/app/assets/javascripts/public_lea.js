function render_graph(lea_type) {

	// the input data
	var data = lea_type;
	var labels = ["CS","SD","IU","OCCCTC","SJCI","COMCTC","STATE","SPJ"];
	var maxData = Math.max.apply( null, data );
	console.log(data);

	// constants that determine the sizes of all the elements
	const X_OFFSET = 50, Y_OFFSET = 50, COLUMN_WIDTH = 50, COLUMN_INTERVAL = 10, COLUMN_HEIGHT = 5;
	const 
		WIDTH = X_OFFSET + (COLUMN_WIDTH + COLUMN_INTERVAL) * labels.length,
	 	HEIGHT = 3150;
	 console.log("height is: " + HEIGHT);

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

	svg.selectAll("text")
		.data(data)
		.enter().append("text")
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
