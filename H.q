.H.CONNTIMEOUT:0;
.H.H:`alias xkey flip `alias`host`name`allowupdate`handle!(0#`;0#`;0#`;0#0b;0#0i);
.H.h:{.H.H[x][`handle]};
.H.n:{.H.H[x][`name]};

.H.pc:{.H.H:update handle:0Ni from .H.H where handle=x}; 

///
//is remote select
.H.is:{$[(count[x] in 5 6 7)and(?)~first x;.H.v x;0b]};

///
//is remote update
.H.iu:{$[(count[x]=5)and(!)~first x;.H.v x;0b]};

///
//remote evaluate functional select/update
.H.re:{(.H.h x 1)@(eval;@[x;1;.H.n])};

///
//is valid table
.H.v:{$[(-11h=type x 1);not null .H.h x 1;0b]}

///
//do remote execution?
.H.dr:{any(.H.is;.H.iu)@\:x}


///
//can we find a way to extract the indices of all the remote selects? (unlikely)
.H.g:{
	desc //will order a list of indices by depth I think
	//where .H.is Q
	};

///
//evaluate a parse tree based on being able to find indices of remote selects
//.ev:{eval Q .[;;.H.re]/ .H.g Q:parse x};

///
//
.H.er:{$[11h=abs type r:.H.re{$[(0h~type x)and not .H.dr x;.z.s'[x];.H.dr x;.H.er x;x]}'[x];enlist r;r]};

///
//step through parse tree, evaluating remote selects where necessary
.H.ev:{eval{$[.H.dr x;.H.er x;1=count x;x;.z.s'[x]]}parse x}

///
//Evaluate string
.H.e:{@[.H.ev;x;{'"err - ",x}]}


///
//Initialize
.H.init:{
	//attempt to populate mapping of handles
	.H.H:.H.H upsert flip `alias`host`name`allowupdate!("sssb";",")0:hsym`$getenv`HDOTKCONFIGFILE;
	.H.H:update alias^name, handle:.Q.fu[(hopen')](hsym')host from .H.H; //need to set timeouts and trap errors, probably have to roll our own .Q.fu
	.z.pc:$[{`~@[value;`.z.pc;`]}[];.H.pc;{x y;.H.pc y}[.z.pc]]; //hacky
	};

@[.H.init;`;`err];
