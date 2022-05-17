f=0;
while(f < numFil){
	c = 0;
	while(c < numCol){
	if(f == 0 || f == numFil-1 || c == 0 || c == numCol-1){
		exterior += y;
	}else{
		interior += y;
	}
	y++ ;
	c++ ;		
	}
	f++ ;
}
