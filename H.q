.H.CONNTIMEOUT:0;
.H.H:`alias xkey flip `alias`host`name`allowupdate`handle!(0#`;0#`;0#`;0#0b;0#0i);
.H.h:{.H.H[x][`handle]};
.H.n:{.H.H[x][`name]};

.H.pc:{.H.H:update handle:0Ni from .H.H where handle=x}; 

///
//is remote select
.H.is:{$[(count[x] in 5 6 7)and((?)~x 0)and(-11h=type x 1);not null .H.h x[1];0b]};

///
//is remote update
.H.iu:{$[(count[x]=5)and((!)~x 0)and(-11h=type x 1);not null .H.h x[1];0b]};

///
//remote evaluate functional select/update
.H.re:{(.H.h x 1)@(eval;@[x;1;.H.n])};

///
//can we find a way to extract the indices of all the remote selects? (unlikely)
.H.g:{
	desc //will order a list of indices by depth I think
	//where .H.is Q
	};
///
//evaluate a parse tree based on being able to find indices of remote selects
.H.ev:{eval Q .[;;.H.re]/ .H.g Q:parse x};

.H.e:{
	//TODO
	//@[.H.evaluate;x;`err]
	}

.H.init:{
	//attempt to populate mapping of handles
	.H.H:.H.H upsert flip `alias`host`name`allowupdate!("sssb";",")0:hsym`$getenv`HDOTKCONFIGFILE;
	.H.H:update alias^name, handle:.Q.fu[(hopen')](hsym')host from .H.H; //need to set timeouts and trap errors, probably have to roll our own .Q.fu
	.z.pc:$[{`~@[value;`.z.pc;`]}[];.H.pc;{x y;.H.pc y}[.z.pc]]; //hacky
	};

@[.H.init;`;`err];
