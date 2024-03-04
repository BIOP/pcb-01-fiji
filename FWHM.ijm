// Do a simple FWHM measure
// Either there are no ROIs on the manager and it will do them on the current line selection
// Or if there are ROIs, it will make one measurement per ROI.

// This part of the code handles the logig
nRois = roiManager("count");
imageName = getTitle();

if( nRois == 0 ) {
	if (selectionType() == 5) {
		doFWHM( true );
	} else {
		showMessage("Please make a line profile");
	}
} else {
	for (i = 0; i < nRois; i++) {
		selectImage(imageName);
		roiManager("select", i);
		doFWHM( false );
	}

}

// This part of the code handles the fitting of the current selection
function doFWHM( doShow ) {
	
	imageName = getTitle();
	
	X = getProfile();
	getVoxelSize(px, py, pz, unit);
	// To get everything calibrated already
	xAxis = newArray(X.length);
	
		
	for (k=0; k<X.length; k++) {
		xAxis[k] = k * px;
	}
	
	// Fit the FWHM
	Fit.doFit("Gaussian", xAxis, X);
	xR2 = Fit.rSquared;
	xd   = Fit.p(3);
	
	if( doShow ) {
		Fit.plot;
		rename("Gaussian fitting of curve on "+imageName);
	}
	n = nResults;
	
	// Add the results to a table and display it
	setResult("FWHM ["+unit+"]", n, 2*sqrt(2*log(2))*xd);
	setResult("R^2", n, xR2);
	setResult("Label", n, imageName);
	Stack.getPosition(channel, slice, frame);
	setResult("Channel", n, channel);
	setResult("ROI", n, Roi.getName());
}