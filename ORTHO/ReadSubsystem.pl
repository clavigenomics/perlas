

#!/usr/bin/perl
#use strict;   I cannot import variables using strict :( :( 
use warnings;
use globals;

## Leer por subsistema Replicar el trabajo de RAST
## Leer por Fig (A quién pertenece ese fig) F
###################################################################
## Archivos tsv

#my $dir="/home/nelly/CLAVIBACTER";

###################################################################
my $Mode;
#$Mode= "S"; 
#$Mode= "E"; #Dado un EC number Cual es su Fig
$Mode= "F"; ## Dado un Fig Cual es su funcion
#my %SUBSYSTEM; 

###################################################################

sub readSubsystem;
sub readFigs;
sub readList;
###################################################################
##################### MAin    #####################################
###################################################################
my $list=listas($NUM,$LIST);  #$list stores in a string the genomes that will be used
my @LISTA=split(",",$list);

my $FUNCTION_PATH="$dir/$NAME/FUNCTION";
unlink( $FUNCTION_PATH);
`rm -r $FUNCTION_PATH`;
`mkdir $FUNCTION_PATH`;
print "$FUNCTION_PATH\n";


foreach my $num (@LISTA){
	EscribeSalida($num);
	}
####################################################################
####################################################################
sub EscribeSalida {
	my $num=shift;
	my %FIG; #Fig, Category, SubCategory # Subsystem #Role 
	my @CORE;
	my @COMPLEMENT;

	my $ReactionFile="$dir/$num.tsv";  ## File cvs from RAST with ALL the reactions (From the spreadsheet reaction)
	#my $FigsFile="$dir/$num.figs"; ## File with the figs or feachures id for wich we want the function
	my $genome_file="$dir/$num.faa";

	my $core_file="$dir/$NAME/FASTAINTERporORG/$num.interFastatodos";
	print"\n En lista $dir/$NAME/FASTAINTERporORG/$num.interFastatodos\n";

	my @Genome=readList($genome_file);
	@CORE=readList($core_file);  ## Fills Querys with the querys figs  ##Cambiarlo al interFAsta todos
	@COMPLEMENT=complement(\@Genome,\@CORE);

	#foreach my $gen (@Genome){print "$gen\n";}
	#foreach my $gen (@CORE){print "$gen\n";}
	#foreach my $gen (@COMPLEMENT){print "$gen\n";}

	readSubsystem($ReactionFile,\%FIG);  #Stores en FIGCORE los figs del genoma

	if ($Mode =~/F/){
#		HeadF(); #Gene	#Subsystem	#Role	# 
		my $core=1; my $complement=0;
		mainFig($num,\%FIG,\@CORE,$core);   #escribe Salida
		mainFig($num,\%FIG,\@COMPLEMENT,$complement);   #escribe Salida
		}
}
###################################################################
sub complement{
	my $refContent=shift;
	my $refCore=shift;
        my @Complement;

	foreach $id (@{$refContent}){
#	print "$id \n";
		if($id~~@{$refCore}){
	#		print ("$id not in complement\n")
			}
		else{
			push(@Complement,$id);
#		print "$id is in complement\n";
			}

		}
	return @Complement;
	}

sub listas{
	my $NUM=shift;
	my $LIST=shift;
	my $lista="";

	if ($LIST){ 
		print "Lista de genomas deseados $LIST";
		$lista=$LIST;
		}
	else {
		for( my $COUNT=1;$COUNT <= $NUM ;$COUNT++){
			$lista.=$COUNT;
			if($COUNT<$NUM){
				$lista.=",";
				}
			}
		}
	return $lista;
		
	}
#_______________________________________________________________________________________________

sub readList{

	my $input=shift;
	my @LContent;
	open (LISTA,"$input") or die "could not open file $input $!";
        my @Genome=<LISTA>;
	foreach my $line (@Genome) {
		chomp $line;
		if ($line=~/>/ ){
		$line=~s/\|\d*$//g;
		$line=~s/>//g;
		#print("#$line#\n");
			push(@LContent,$line)
			}
		};
	return @LContent;
}
#____________________________________________________________________



###################################################################
############################ Subs #####################################
#Category	Subcategory	Subsystem	Role/EC	Features
sub HeadF{
	print("Fig\tCategory\tSubcategory\tSubsystem\tRole\tEC\n");
	}

sub readFigs{ # Read wich figs are given in search of function.- fills the array QUERYS
	my $input=shift;
	my @ARRAY;
	my @LContent;
	open (LISTA,"$input") or die "Could not open file $input : $!";
	my @Figs=<LISTA>;
	foreach my $fig (@Figs) {
		chomp $fig;
		#print "#$fig#\n";
		push(@ARRAY,$fig);
		}
	return @ARRAY;
	}


sub readSubsystem{ ## Get the full reaction and function information from the organism
	my $input=shift;
	my $refFig=shift;
	my @LContent;
	open (LISTA,"$input") or die "Could not open file $input : $!";

	#my @Reactions=<LISTA>;
	while( my $line = <LISTA>) {
		$line=~ s/\r//g;   ##Linea salvadora de Cristian para quitar basura que interfiere con el chomp
		chomp ($line);
		#print ">$line#\n";
		my @Parts=split("\t",$line);
		chomp @Parts;
		my $Category=$Parts[0];
		my $Subcategory=$Parts[1];
		my $Subsystem=$Parts[2];
		my @Roles=split(/\(/,$Parts[3]);
		my $Role=$Roles[0];
		my $EC="";
		if($Roles[1]){
			$EC=$Roles[1];
			$EC=~s/\)//;
			}
	
		my @Features=split(",",$Parts[4]);


			
		foreach my $feach(@Features){
			if($feach=~/fig/){
				chomp $feach;	
				$feach=~s/^\s*//;	
				$feach=~s/\n//;	
				$refFig->{$feach} = [$Category,$Subcategory,$Subsystem,$Role,$EC]; 
				}
			}

		}
		
	close LISTA;
	}

sub mainFig{  ## Returns the function for each gene (Sorted by Fig number)
	my $num=shift;
	my $refFig=shift;
	my $refQUERYS=shift;
	my $core=shift;
	my @QUERYS=@{$refQUERYS};

	my @UNSORTED;
	my @SORTED;
	my %PEGS;

	if ($core==1){	open (OUTFILE,">$dir/$NAME/FUNCTION/$num.core.function") or die "Could not open CORE function file $!";}
	if ($core==0){	open (OUTFILE,">$dir/$NAME/FUNCTION/$num.complement.function") or die "Could not open COMPLEMENT function file $!";}
	

	#foreach my $fig (keys %$refFig){
	foreach my $fig (@QUERYS){
#		print ">$fig<\n";
		my $peg= $fig;
		if ($peg=~/peg/ ){$peg=~s/.+peg.//;}
		else{ $peg=~s/.+rna.//;	}

		push(@UNSORTED,$peg);
		$PEGS{$peg}=$fig;
		#print "$peg, => #$PEGS{$peg}#\n";
		}

	@SORTED = sort { $a <=> $b } @UNSORTED;

	foreach my $peg (@SORTED){
		my $fig=$PEGS{$peg};
		if (exists $refFig->{$fig}){
			my $Category=$refFig->{$fig}[0]; 
			my $Subcategory=$refFig->{$fig}[1]; 
			my $Subsystem=$refFig->{$fig}[2]; 
			my $Role=$refFig->{$fig}[3]; 
			my $EC=$refFig->{$fig}[4]; 
		
			#print "$fig\t$Category\t$Subcategory\t$Subsystem\t$Role\t$EC\n";
			print OUTFILE "$fig\t$Category\t$Subcategory\t$Subsystem\t$Role\t$EC\n";
			}
		else{ print OUTFILE "$fig No function asigned in this reaction file\n";}
		}
	close OUTFILE;
	}

