#!/usr/bin/perl -w
#####################################################
# CODIGO PARA UPLOAD-FILE
#
#####################################################

#use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Statistics::Basic qw(:all);
############################## def-DBM #################################
use Fcntl ; use DB_File ; $tipoDB = "DB_File" ; $RWC = O_CREAT|O_RDWR
;
############################## def-SUB  ################################
my $tfm2 = "mi_hashNUMVia.db" ;
$hand2 = tie my %hashNUMVia, $tipoDB , "$tfm2" , $RWC , 0644 ;
print "$! \nerror tie para $tfm2 \n" if ($hand2 eq "");


$apacheCGIpath="/home/evoMining/newevomining";


#los diez
#--- Generados con /var/www/newevomining/DB/reparaHEADER.pl------------------ 
#my $tfm1A = "hashOrdenNombres1_10.db" ;
#$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm1A \n" if ($hand1A eq "");##

#my $tfm2A = "hashOrdenNombres2_10.db" ;
#$hand2A = tie my %hashOrdenNOMBRES, $tipoDB , "$tfm2A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm2A \n" if ($hand2A eq "");

#my $tfm3A = "hashOrdenNombres3_10.db" ;
#$hand3A = tie my %hashOrdenNOMBRES2, $tipoDB , "$tfm3A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm3A \n" if ($hand3A eq "");
#----------------------------------------------------------------------------
#--- Generados con /var/www/newevomining/DB/reparaHEADER.pl------------------ 
my $tfm1A = "hashOrdenNombres1_old.db" ;
$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , 0 , 0644 ;
print "$! \nerror tie para $tfm1A \n" if ($hand1A eq "");#

my $tfm2A = "hashOrdenNombres2_old.db" ;
$hand2A = tie my %hashOrdenNOMBRES, $tipoDB , "$tfm2A" , 0 , 0644 ;
print "$! \nerror tie para $tfm2A \n" if ($hand2A eq "");

my $tfm3A = "hashOrdenNombres3_old.db" ;
$hand3A = tie my %hashOrdenNOMBRES2, $tipoDB , "$tfm3A" , 0 , 0644 ;
print "$! \nerror tie para $tfm3A \n" if ($hand3A eq "");
#----------------------------------------------------------------------------

#mil genomas
#--- Generados con /var/www/newevomining/DB/reparaHEADER.pl------------------ 
#my $tfm1A = "hashOrdenNombres1ALL.db" ;
#$hand1A = tie my %hashNOMBRES, $tipoDB , "$tfm1A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm1A \n" if (!$hand1A);

#my $tfm2A = "hashOrdenNombres2ALL.db" ;
#$hand2A = tie my %hashOrdenNOMBRES, $tipoDB , "$tfm2A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm2A \n" if (!$hand2A);

#my $tfm3A = "hashOrdenNombres3ALL.db" ;
#$hand3A = tie my %hashOrdenNOMBRES2, $tipoDB , "$tfm3A" , 0 , 0644 ;
##print "$! \nerror tie para $tfm3A \n" if (!$hand3A);
#----------------------------------------------------------------------------




my %Input;

my $query = new CGI;
print $query->header,
      $query->start_html(-style => {-src => '/html/evoMining/css/tabla.css'} );
my @pairs = $query->param;

foreach my $pair(@pairs){
$Input{$pair} = $query->param($pair);
}	



#--------------------------------------
$date = `date`;
@divDate=split(/ /,$date);

$pid_fecha=$$."_".$divDate[0].$divDate[1].$divDate[2].$divDate[$#divDate];
$outdir="$pid_fecha";

chomp($outdir);
system "mkdir $outdir";
$la="$apacheCGIpath/$outdir/blast/";
mkdir( $la ) or die "Couldn't create $la directory, $!";
mkdir ("$apacheCGIpath/$outdir/blast/seqf");
#
mkdir ("$apacheCGIpath/$outdir/blast/seqf/tree");
mkdir ("$apacheCGIpath/$outdir/FASTASparaNP");
mkdir ("$apacheCGIpath/$outdir/NewFASTASparaNP");
#--------------------------------------




$max=129;

#Directorio donde queremos estacionar los archivos
my $dir = "$apacheCGIpath/DB";
my $dirDB = "$apacheCGIpath/DB";
my $dirPB = "$apacheCGIpath/PasosBioSin";
my $blastdir = "/opt/ncbi-blast-2.2.28+/bin/";
my $OUTblast = "$apacheCGIpath/$outdir/blast";

#------- Rutas Centrales --------------
my $viaMet="ALL_curado.fasta";
#my $viaMet="ALL_curado020715.fasta";
#my $viaMet="tRAPs_EvoMining.fa";


#-------- BD de Genomas------------------
# Genomas 
#my $db = "GENOMESDB_230220015HEADER.fasta";

# Genomas de Nelly
#my $db = "NellyDaniel/11Oct2015HEADER.fasta";
#my $db = "TodosActinosHEADER.fasta";#mil genomas

#los diez
#my $db = "losDiez/tenGenomes.fasta"; #diez genomas 250116

#los casi200
my $db = "losCasi200/losCasi200HEADER.fasta"; #200 genomas 250116

#los casi200 filtrados
#my $db = "losCasi200/filtrados/losCasi200filtradosHEADER.fasta"; #200 genomas 250116







my $dbb = "GENOMESDB_230220015HEADER.fasta.db";
#my $dbb = "TodosActinosHEADER.fasta.db";
 ($eval,$score2)=recepcion_de_archivo(); #Iniciar la recepcion del archivo



#Array con extensiones de archivos que podemos recibir
my @extensiones = ('gif','jpg','jpeg','prot_fasta.2ConNombre','prot_fasta.2', 'fasta');
#my $db = "prueba.db";
#my $db = "ALL_curadoHEADER2.db";

open (LALO, ">$outdir/lalo");
$cont=0;
$valida=1;
$cuentaVia=1;
open (CHECK, ">$outdir/check.hash");
open (VIAS, "$dirPB/$viaMet");
$cuantasViasvan=0;
while (<VIAS>){
chomp;
#print CHECK "$_\n";
  if($_ =~ />/){
    $_ =~ s/>//;
  # print CHECK "$_\n"; 
    @viaPaso= split (/\|/, $_);
    $llaveViaPaso="$viaPaso[0]_$viaPaso[1]";
   #  print CHECK "-$llaveViaPaso\n";
     if(!exists $hashViaPaso{$llaveViaPaso}){ 
    #  print CHECK "PASOOOOOO$llaveViaPaso\n";
      if($ViaAnterior ne $viaPaso[0]){
       #$llaveViaPaso="$viaPaso[0]_0";                #
       # print CHECK "$cuentaVia**$llaveViaPaso*anterior: +++$ViaAnterior, actual:$viaPaso[0]\n";       
      
       $hashCeros{$cuentaVia}=$cuentaVia; # Esta seccion es para agregar unla columna vacia entre cada via en el HIT PLOT
       # $cuentaVia++;                          #
      }
      $cuantasViasvan++;
      $hashViaPaso{$llaveViaPaso}=$cuentaVia; ## contiee los detalles de las vias "3PGA_AMINOACIDS|4" y el valor es el numero de la columna de la tablaheatplot
      $hashDetallesvias{$cuentaVia}=$llaveViaPaso;# contiene lo mismo del hash anterior pero invertido en llave valor
      $hashNUMVia{$cuentaVia}=$viaPaso[2];#$viaPaso[0]? esto ser[ia para el nombre del paso
      $hashDescripcionvia{$llaveViaPaso}=$viaPaso[2];
     # print CHECK "$cuantasViasvan-$llaveViaPaso -aa-->  $cuentaVia ===$hashViaPaso{$llaveViaPaso} ---- $viaPaso[2]\n";
      $cuentaVia++;
      $ViaAnterior=$viaPaso[0];
     }     

  }

}

#close CHECK;
#--------- Indexa bd para blast --------------------------
#print "<h1>Indexando nuevo Genoma...</h1>";
###
#system "$blastdir/makeblastdb -dbtype prot -in $dir/$db -out $dirDB/$dbb";
# se ejecuto en lina de comando con lo siguiente: makeblastdb -dbtype prot -in GENOMES_DBrepaired.fasta -out GENOMES_DBrepaired.db
#print "<h1>Done...</h1>";
#print "<h1>Blast  Central Met./NP VS Genome DB...</h1>";

#system "$blastdir/blastp -db $dirDB/$dbb -query $dirPB/$viaMet -outfmt 6 -num_threads 4 -evalue $eval -out $OUTblast/pscp.blast";

#se ejecuto en lina de comando con lo siguiente:blastp -db DB/GENOMES_DBrepaired.db -query PasosBioSin/GlycolysisnewHEADER.fasta -outfmt 6 -num_threads 4 -evalue 0.0001 -out pscp.blast 
#blastp -db GENOMESDB_300120015.db -query ../PasosBioSin/ALL_curadoHEADER.fast -outfmt 6 -num_threads 4 -evalue 0.0001 -out ../blast/pscp30012015.blast
###################weekend############################system "$blastdir/blastp -db $dirDB/$db -query $dirPB/$viaMet -outfmt 6 -evalue $eval -out $OUTblast/pscp.blast";

#print "<h1>Done...</h1>"; cu
# print  "<h1>Concatenando blast...</h1>";
	
#  system "cat $OUTblast/$file_name\ConNombre.blast $OUTblast/centralMetVSgenomeBASE.blast  >  $OUTblast/centralMetVSgenomeW$file_name\ConNombre.blast";
#  print  "<h1>aRCHIVO Concatenado:$file_name.out</h1>";

#open (BLA, "/var/www/newevomining/blast/pscp.blast");
#while (<BLA>){
#chomp;
#@datblast=split("\t", $_);


#}#
#close BLA;

#---------------------pinta tabla--------------
#open (BLA, "/var/www/newevomining/blast/pscp10rep3.blast");
#open (BLA, "/var/www/newevomining/$OUTblast/pscp.blast");
#open (BLA, "/var/www/newevomining/blast/pscpPAU070915.blast");
#open (BLA, "/var/www/newevomining/blast/pscpNellyDaniel240915.blast");
#open (BLA, "/var/www/newevomining/blast/pscpTodosActinoscemg.blast");
#open (BLA, "$apacheCGIpath/blast/pscplosdiez.blast"); #250116
open (BLA, "$apacheCGIpath/blast/pscporigina190216.blast") or die $!; #250116
#open (BLA, "$apacheCGIpath/blast/pscp150316Casi200.blast") or die $!; #150316

#open (BLA, "$apacheCGIpath/blast/pscp11OctubreTodos.blast");
$directory="$apacheCGIpath/$outdir/log.blast";

open (LOG, ">$directory") or die $directory;
$co=1;
while (<BLA>){
chomp;
  @datblast=split("\t", $_);
  @datpasosBIO=split(/\|/, $datblast[0]);
  @datGenomas=split(/\|/, $datblast[1]);
 # print "$datblast[0]***$datblast[1]\n";
 # print "$datpasosBIO[1]_$datGenomas[5]\n";
 $porcentaje=$datblast[9]*100/$datblast[7];
 $cuatrillave=$datpasosBIO[0]."_".$datpasosBIO[1]."_".$datGenomas[1]."_".$datGenomas[5]; # esto es para qeu se selecciones un solo un GI por genoma, por via y por paso, sin redundancia entre esos 4 criterios
   
  if(!exists $hashUniqGI{$cuatrillave}){
    if ($datblast[11] >= $score2 and $porcentaje >50){
     #if(!exists $hashUniqGI{$trillave}){
      $llaveNVia="$datpasosBIO[0]_$datpasosBIO[1]";
      #$hashViaPaso{$llaveNVia}
      $llave="$hashViaPaso{$llaveNVia}"."_"."$datGenomas[5]";
      print LOG "$hashGenomas{$llave}\n";#"$llaveNVia--->$hashViaPaso{$llaveNVia}-->$llave\n";
      $hashGenomas{$llave}++;
      $hashGIs{$llave}=$hashGIs{$llave}."\t".$datGenomas[1];
      $hashUniqGI{$cuatrillave}=$datblast[2]; #indexa los detalles de la via, y el GI al valor del % de identidfad obtenido del blast
     
      if( !exists$hashpasos{$hashViaPaso{$llaveNVia}}){
        $hashpasos{$co} =$hashViaPaso{$llaveNVia}; #quiza haya que concatenar el numero al a via cuando se agreguen las demas vias
        $co++;
      }
     #print LOG "$_\n";
     #}
    }
    
  }#end if $hashUniqGI{$cuatrillave}
  

 
}#end while

print LOG "\n\n____________________________________\n\n\n";
$contador=0;
open (NUEVO, ">$apacheCGIpath/$outdir/busca.Gintroducido") or die $!;
$firsttime=1; # esta bandera indica qeu hay un organismo mas ademas de los registrados en el hash y es la primera vez que entra en el proceso
$cuentaOrgdemas=101;
$cuentaOrgdemas=237;

foreach my $x (keys %hashGenomas){
 #print "-----------------\n";
 @datllave=split("_", $x );
    
    print LOG "$x*****$datllave[0]\n";
    if(!exists $hashNOMBRES{$datllave[1]}){
      $hashNOMBRES{$datllave[1]}=$datllave[1];
        ######### first time ?????#######
	 #if($firsttime==1){
          #  $cuentaOrgdemas=130;
         #   $firsttime=0;
         #}
         #else{
	 $contadordeGenomas++;
           $cuentaOrgdemas++;
         #}
	################################## 
	$hashOrdenNOMBRES2{$cuentaOrgdemas}=$datllave[1];
	$hashOrdenNOMBRES{$datllave[1]}=$cuentaOrgdemas;
	#print NUEVO " $hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}--$hashNOMBRES{$datllave[1]}--$datllave[1]/ $hashNOMBRES{$datllave[1]} / [$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]--$hashGenomas{$x}/$xllave:$cuentaOrgdemas, valor:$datllave[1] hashgenomas:$x\n";
	$hashNOMBRESActual{$cuentaOrgdemas}=1; 
        print LOG "siiiiii entro[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]\n";
    } 
    else{
    $contadordeGenomas++;
    $hashNOMBRESActual{$datllave[1]}=1;
    #print NUEVO "EXISTEEEEEN[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}--$hashNOMBRES{$datllave[1]}--$datllave[1]][$datllave[0]]-$hashNOMBRES{$datllave[1]}}][$datllave[0]-$hashGenomas{$x}/$xllave:$cuentaOrgdemas, valor:$datllave[1] hashgenomas:$x\n";
      #$hashNOMBRES{$datllave[1]} =~ s/ //g;
      if(!exists $hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}){
        $hashNOMBRES{$datllave[1]} =~ s/ //g;
      }
      print LOG "noooooo entro[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]-$hashNOMBRES{$datllave[1]}-$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}-\n";
    }
    #$hashNOMBRESActual{$datllave[1]}=1; #registra los nombres qeu provienen del blast para posteterioemente compraralos con el hashNombres
    #print NUEVO "$cuentaOrgdemas**$datllave[1]/*/[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]--$hashGenomas{$x}/$x\n";#"$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}__$datllave[0]**$datllave[1]\n";#**$hashGenomas{$x}++\n";#$hashGIs{$x}\n";
    $numGenoma2{$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}}="$datllave[1]";
    $tabla[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashGenomas{$x}";
    $tabla2[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashGIs{$x}";
    $tablanombrevia[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]="$hashDetallesvias{$datllave[0]}--$hashDescripcionvia{$hashDetallesvias{$datllave[0]}}/$hashNOMBRES{$datllave[1]}";
   #
#	print LOG "/$x/$#{$tabla[1]}+$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}+$datllave[0]+$tabla[$hashOrdenNOMBRES{$hashNOMBRES{$datllave[1]}}][$datllave[0]]\n";
$arrpasos[$datllave[0]]=$arrpasos[$datllave[0]].",".$hashGenomas{$x};

$sumarray[$datllave[0]]=$sumarray[$datllave[0]]+$hashGenomas{$x};
#print "$numGenoma{$datllave[1]}, $datllave[0]] =$hashGenomas{$x}\n ";
#<STDIN>;
}#end foreach %hashGenomas
print LOG "TERMINO EN:$cuentaOrgdemas. total:$contadordeGenomas.\n";
#close LOG;
#print LOG "**filas $#tabla2 columnas $#{$tabla2[1]}\n";
####################################################
##    CALCULO DE DESVIACION ESTANDAR
##
  $contstd=1;
  #print "<h1>$sumarray[1]</h1>";
  foreach my $x ( @arrpasos ){
     @arregloPROm=split(",",$x);
      my @v1  = vector(@arregloPROm);
      my $std = stddev(@v1);
    #  $arrSTD[$contstd]=$std;
    
 
   $numgenomas=$#tabla;
   $promediO=$sumarray[$contstd]/$numgenomas;
 
   $arrSTD[$contstd]=$promediO+$std;
   $sumPROM='';
   $contstd++;
}
##
##
######################################################
print qq |

<div class="encabezado">
<div class="expanded">Expanded enzyme families</div>
</p>
<form method="post" action="/cgi-bin/newevomining/evomBlastNp2.0.pl"
name="foma">
<table BORDER="0" CELLSPACING="0" ALIGN="center"  WIDTH="15">
<div class="subtitulo" ALIGN="center">Blast option:</div>
	<div class="campo1">e-value:</div>
    <div class="campo-1"><textarea style="width: 65px; height: 25px;" cols="1" rows="1" name="evalue">0.0001</textarea></div>
    <div class="campo2">Minimum Score:</div>
    <div class="campo2-2"><textarea style="width: 50px; height: 25px;" cols="1" rows="1" name="score">100</textarea></div>
    <input type="hidden" name="pidfecha" value="$outdir">
    <div class="boton"><button  value="Submit" name="Submit">SUBMIT</button></div>
</table>
<br>
</form>
|;

#print scalar keys %hashGenomas;
close BLA;
###print  LOG "paso 1 filas $#tabla comunas $#{$tabla[1]}\n";
#print "<h1>$tabla2[3][1]</h1>"; 
print qq|<table cellpadding="1" cellspacing="0" class="tabla">|;
#print "<tr>";
$tope=$#tabla+1;

for (my $x=0; $x<=$tope; $x++){#***filas****
#print LOG "$x--$hashOrdenNOMBRES2{$x}-$#{$tabla[1]}\n";
    if(!exists $hashNOMBRESActual{$x}){
       print NUEVO "$hashOrdenNOMBRES2{$x}\n";
       #next;
    }
    if(!exists $hashOrdenNOMBRES2{$x}){
      next;
    }
print "<tr>";
#if($x ==0){
    
    #print "<td>$numGenoma2{$x}</td>";
    # print "<td>$x</td>";
      if(exists $hashNOMBRES{$hashOrdenNOMBRES2{$x}}){
        print qq|<td>$hashNOMBRES{$hashOrdenNOMBRES2{$x}}</td>|;
	#print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
	
      }
      else{
        print qq|<td>//$hashOrdenNOMBRES2{$x}</td>|;
        #print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
      }
      #print qq|<td>/*$hashOrdenNOMBRES2{$x}*/$#{$tabla[1]}/$tope/$x/$y/$hashOrdenNOMBRES{$hashOrdenNOMBRES2{$x}}/$x</td>|;
     #print LOG 
 #   }
# print LOG "$#{$tabla[1]}\n";
  for(my $y=1; $y<=$#{$tabla[1]}; $y++){ #columnas******
    if(!$tabla[$x][$y] ){
      $tabla[$x][$y]=0;
    }
    if(exists $hashCeros{$y}){
     print qq |<td  bgcolor="#585858"></td>|; #escribe division de vias en tabla
    }
    
   if($tabla[$x][$y] >= $arrSTD[$y]){
    # print qq| <td bgcolor= "#8A0808" >$tabla[$x][$y]</td>|;
     $tabla2[$x][$y] =~ s/E/ E/g;# para los casos en qeu no viene co GI agrega un espacio, pues sal[ian pegados
    print qq |<td bgcolor= "#a02b2b" title=" $tablanombrevia[$x][$y] / $tabla2[$x][$y]" >$tabla[$x][$y]</td>|;
    $tabla3[$x][$y]=$tabla2[$x][$y]; ######selecciona ROJOS del heatplot en tabla3 para el caso de qeu se ocupe mas adelante
     $keyExpanded="$x_$y";
     $hashEXPANDED{$keyExpanded}=1;
   }
   else {
      if ($x == $tope){ 
        # print "<td>$arrSTD[$y]</td>"; #IMPRIME ULTIMA FILA COM DATOS
       }
       else {
        print qq |<td title=" $tablanombrevia[$x][$y] / $tabla2[$x][$y]">$tabla[$x][$y]</td>|;
      #  print LOG "***$tabla[$x][$y]-$x-$y\n";
      }
   } 
  }#end for columnas=  
  print "</tr>";
#pLOGrint "</table>";
}#end for filas
print "</table>";
open(SALE, ">$apacheCGIpath/$outdir/vacio.hash");
$tope2=$#tabla2+1;
####print LOG "paso antes columas $tabla2{$tabla2[1]} filas $tope2\n";
#------------------EXTRAE gi y genera fastas-----------------
for(my $y=1; $y<=$#{$tabla2[1]}; $y++){ #columnas******

# print "++columna $y \n";
   for (my $x=0; $x<=$tope2; $x++){#***filas****
      ####print LOG "-columna $y  fila $x $tabla2[$x][$y]\n";
       ###selecciona ROJOS del heatplot##@losGIs=split("\t",$tabla3[$x][$y]);
       $keyExpanded2="$x_$y";
       #if(exists $hashEXPANDED{$keyExpanded2}){
         @losGIs=split("\t",$tabla2[$x][$y]);
	 
       #}
       #####selecciona ROJOS del heatplot#if($tabla3[$x][$y] eq ''){
       #####selecciona ROJOS del heatplot#  next;
       #####selecciona ROJOS del heatplot#}
       foreach my $r (@losGIs){
         if($r){
	   $Allgis{$r}=1;
	  print SALE "SIIIIIIIIII*$r*\n";
	 }
       }
   }
   $siH=0; 
    open (FAST, "$dirDB/$db") or die "$! $dirDB/$db";
   #open (FAST, "$dirDB/GENOMESDB_300120015repaired.fasta") or die $!;
  # open (FASTA, ">/var/www/newevomining/FASTASparaNP/$hashpasos{$y}.fasta"; 
   open (FASTA, ">$apacheCGIpath/$outdir/FASTASparaNP/$y.fasta") or die  $!;
   while(<FAST>){
   chomp;
   
     #if($_ !~ />gi/){
     #  $_=">gi|$_|";  #Para los casos en qeu el identificador viene de RAST y no trae la palabra >gi|id| 
     #}
     print LALO "$_\n----\n";
     #if($_ =~ />gi\|(\w+)\|/){
     if($_ =~ />gi\|(\d+\.\d+\.\d+)\|.+/){
       $Header=$_;
      print LALO "HEADER $1----$Header\n";
       if(exists $Allgis{$1}){
         $siH=1;
	 print FASTA "$_\n";
       }
       else{
         $siH=0;
       }
     }
     else{
      if ($siH ==1){
        print FASTA "$_\n";
      }
     }
   
   
   
   }
   close FAST;
   close FASTA;
   %Allgis='';
   close LOG;
   close CHECK;
}

close SALE;
#--------------------------
#<table>
#<tr>
#<td>Celda 1</td>
#<td>Celda 2</td>
#<td>Celda 3</td>
#</tr>
#<tr>
#<td>Celda 4</td>
#<td>Celda 5</td>
#<td>Celda 6</td>
#</tr>
#</table>

#---------------------------


#0---------------------end pinta tabla---------

#1.- calcular numero de hits (homologos) por genoma por pasos biosinteticos
#2.- calcular media y desviacion estandar para cada paso biosintetico 
  #2.1.- la media + la deviacion estandar es el punto de corte para seleccionar los que se analizan en el siguente paso
#3.- visualizar en tabla 
#4.- mouse over de GI de cada hit porgenoma y paso biosintetico


exit(1);






#######################################################
# funciones para upload
#######################################################
sub recepcion_de_archivo{

my $evalue = $Input{'evalue'};
my $score1 = $Input{'score'};
#my $nombre_en_servidor = $Input{'archivo'};

$evalue =~ s/ /_/gi;
$evalue =~ s!^.*(\\|\/)!!;
$score1=~ s/ /_/gi;
$score1 =~ s!^.*(\\|\/)!!;


my $extension_correcta = 1;

#foreach (@extensiones){
#if($nombre_en_servidor =~ /\.$_$/i){
#$extension_correcta = 1;
#last;
#}
#}


#if($extension_correcta){3
#
##Abrimos el nuevo archivo
#open (OUTFILE, ">$dir/$nombre_en_servidor") || die "$! $dir No se puedo crear el archivo";
#binmode(OUTFILE); #Para no tener problemas en Windows#
#
##Transferimos byte por byte el archivo
#while (my $bytesread = read($Input{'archivo'}, my $buffer, 1024)) {
#print OUTFILE $buffer;
#}

##Cerramos el archivo creado
#close (OUTFILE);#
#
#}else{
#print "Content-type: text/html\n\n";
#print "<h1>Extension incorrecta</h1>";
#print "Sólo se reciben archivo con extension:";
#print join(",", @extensiones);
#exit(0);
#}
return $evalue,$score1;

} #sub recepcion_de_archivo
