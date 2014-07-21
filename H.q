.H.CONNTIMEOUT:0;
.H.H:`alias xkey flip `alias`host`name`handle!(0#`;0#`;0#`;0#0i);
.H.h:{.H.H[x][`handle]};
.H.n:{.H.H[x][`name]};

.H.pc:{.H.H:update handle:0Ni from .H.H where handle=x}; 

///
//is remote select
.H.is_select:{(count[x] in 5 6 7)and(?)~first x};

///
//is remote update
.H.is_update:{(count[x]=5)and(!)~first x};

///
//remote evaluate functional select/update
.H.remote_evaluate:{(.H.h x 1)@(eval;@[x;1;.H.n])};

///
//is valid table
.H.is_configured_remote:{$[(1 = count x 1)and(11h = abs type x 1);not null .H.h first x 1;0b]};

///
//do remote execution?
.H.is_remote_exec:{$[.H.is_select[x] or .H.is_update[x];.H.is_configured_remote[x];0b]};

///
//step through parse tree, evaluating remote queries where necessary then evaluate what remains
.H.E:{
    r:.H.remote_evaluate{$[(0h~type x)and not .H.is_remote_exec x;.z.s'[x];.H.is_remote_exec x;.H.E x;x]}'[x];
    $[11h=abs type r;enlist r;r]};
.H.evaluate:{eval{$[.H.is_remote_exec x;.H.E x;1=count x;x;.z.s'[x]]}parse x}

///
//Evaluate string
.H.e:{@[.H.evaluate;x;{'"err - ",x}]}


///
//Initialize
.H.init:{
	//attempt to populate mapping of handles
	.H.H:.H.H upsert flip `alias`host`name!("sss";",")0:hsym`$getenv`HDOTKCONFIGFILE;
	.H.H:update alias^name, handle:.Q.fu[(hopen')](hsym')host from .H.H; //need to set timeouts and trap errors, probably have to roll our own .Q.fu
	.z.pc:$[{`~@[value;`.z.pc;`]}[];.H.pc;{x y;.H.pc y}[.z.pc]]; //hacky
	};

@[.H.init;`;`err];
