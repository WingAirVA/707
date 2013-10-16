aircraft.livery.init("Aircraft/707/Models/LiveriesTT");

# Not the best place but liveries are independent to the aircraft

var isEC = func {

    var mpOther = props.globals.getNode("/ai/models").getChildren("multiplayer");
    var otherNr = size(mpOther);
	var am = getprop("/b707/refuelling/arial-master") or 0;

    # find EC-137D
    for(var v = 0; v < otherNr; v += 1) {

       if (mpOther[v].getNode("sim/model/path").getValue() == "Aircraft/707/Models/EC-137D.xml" and
           mpOther[v].getNode("id").getValue() >= 0 ) {

           if (mpOther[v].getNode("sim/multiplay/generic/int[12]").getValue() != nil){
		   		if(mpOther[v].getNode("sim/multiplay/generic/int[12]").getValue() == 1){
					setprop("/b707/refuelling/contact",1);
				}elsif(mpOther[v].getNode("sim/multiplay/generic/int[12]").getValue() == 2){
					setprop("/b707/refuelling/ready",1);
				}else{
					setprop("/b707/refuelling/contact",0);
					setprop("/b707/refuelling/ready",0);
				}
           }
       }
    }
	
	if(am) settimer( gotRefuellingMsg, 1.1);
}

setlistener( "/b707/refuelling/arial-master", func{ 
	isEC();
});
