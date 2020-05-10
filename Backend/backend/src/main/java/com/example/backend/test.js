
findPts(18.053970, 59.436784)
function findPts(latt, lonn) {
    var unitSelected = "km"
	var o = latt * Math.PI / 180;
	var i = lonn * Math.PI / 180;
	var h = 5 * 0.609344;
	var m = 5 * 0.609344;
	if (unitSelected == "mi") {
		console.log("Miles choice detected");
		h = h / 0.609344;
		m = m / 0.609344;
		$("#unitswitch").html("mi");
	};
	var k = Math.PI / 180 * ((120 - 60) * Math.random() + 60);
	var f = 0.85;
	var p = f * m / (2 + 2 * Math.sin(k / 2));
	var c = 4000 * Math.cos(o);
	var d = 2 * Math.random() * Math.PI;
	var n = p * Math.cos(d) / 4000 + o;
	var g = i + p * Math.sin(d) / c;
	var l = p * Math.cos(d + k) / 4000 + o;
	var e = i + p * Math.sin(d + k) / c;
	LatLng2 = [(n * 180 / Math.PI), (g * 180 / Math.PI)];
	LatLng3 = [(l * 180 / Math.PI), (e * 180 / Math.PI)];
    miles = h;
    console.log(LatLng2)
    console.log(LatLng3)
}