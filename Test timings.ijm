#@ File imageFile 

start = getTime();
// Open normally
open(imageFile);
time = (getTime() - start);
print( "Time to open large series with the default: "+round(time) +" ms");

// Duplicate
start = getTime();
run("Duplicate...", "duplicate");
time = (getTime() - start);
print( "Time to duplicate series: "+round(time) +" ms");

start = getTime();
run("TIFF Virtual Stack...", "open=["+imageFile+"]");
time = (getTime() - start) ;
print( "Time to open virtual stack: "+round(time) +" ms");

// Duplicate
start = getTime();
run("Duplicate...", "duplicate");
time = (getTime() - start);
print( "Time to duplicate vritual stack: "+round(time) +" ms");
