#!/usr/bin/perl
#use CGI::Carp qw(fatalsToBrowser);
#use CGI;

#my %Input;
#my $query = new CGI;


#print $query->header,
#      $query->start_html();


$prenumFile=$ENV{'QUERY_STRING'};

print $prenumFile;

@arraynumFile=split(/&&/,$prenumFile);

print @arraynumFile;

$numFile=$arraynumFile[0];

print $numFile;

$outdir=$arraynumFile[1];

print $outdir;

print "Content-type: text/html\n\n";

 print qq�
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Evolution - inspired Genome Mining Tool</title>
    <link rel="shortcut icon" href="images2/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images2/favicon.ico" type="image/x-icon">
    <!-- Bootstrap -->
    <link href="/newevomining/css2/bootstrap.min.css" rel="stylesheet">
    <link href="/newevomining/css2/estilo.css" rel="stylesheet" type="text/css">
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-63898104-1', 'auto');
  ga('send', 'pageview');

</script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
 
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
    function target_popup(form) {
    window.open('', 'formpopup', 'width=400,height=200,resizeable,scrollbars');
    form.target = 'formpopup';
   }
   </script>
  </head>
  <body>

  <!-- header -->
  <div class="container-fluid" id="banner"><img src="/newevomining/images2/banner.png" width="940" height="140"></div>
  <!-- header -->
  <div class="container"> <!-- CONTENEDOR PRINCIPAL 12col -->
    <div class="col-md-12">
      <table class="table table-bordered" id="centrado">
        <tr>
          <td>
            <div class="col-md-8">
              <object height='60' type='image/svg+xml' data='/newevomining/SVG/89274980.input.svg'>   
                <img src='test.png' alt='Blue Square'/>
                </object>
		<br> On Tree, Roll the mouse wheel to zoom in and out of the image.
		</div>
           
          </td>
        </tr>
      </table>
    </div>
    <div class="col-md-9">
      <table class="table table-bordered">
        <tr>
          <td>
            <object type="image/svg+xml" name="viewport" data="/newevomining/blast/seqf/tree/testFibo/$numFile.p.svg" width="100%" height="500"></object>
            <script type="text/javascript">
            $(document).ready(function() {
            $('svg#outer').svgPan('viewport');
            });
            </script>
          </td>
        </tr>
      </table>
    </div>
      <div class="col-md-3">
        <table class="table table-bordered">
          <tr>
            <td>
              <h4 id="verde">Color Code</h4>
                <form action="commentlog.pl" onsubmit="target_popup(this)" target="_blank" method="post">
                <div class="ratio">
                      <body>
    <canvas id="myCanvas" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'red';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'red';
      context.stroke();
    </script> Orthologs from Central Metabolism
                    </br>
                    <canvas id="myCanvas2" width="12" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas2');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'blue';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'blue';
      context.stroke();
    </script> Known recruitments
                    </br>
                    <canvas id="myCanvas3" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas3');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = 'cyan';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = 'cyan';
      context.stroke();
    </script> EvoMining Hits (Detected by antiSMASH/Clusterfinder)
     </br>
                    <canvas id="myCanvas4" width="11" height="18"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas4');
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 3;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
      context.fillStyle = '#a5bb47';
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = '#a5bb47';
      context.stroke();
    </script> EvoMining Predictions
                    </br>
                     <br>
                  
		  
                </div>
               <hr>
Send us your comments:
<p><label>E-mail: <input name="email" type="text" size="20" maxlength="254" /></label></p>
<p><label>Comment:<br /><textarea name="Comment" rows="3" cols="20"></textarea></label></p>
<p><input type="submit" value="Send Comment"  /></p>
</fieldset>

<input type='hidden' name="required" value="email,Comment" />
<input type="hidden" name="env_report" value="REMOTE_HOST,HTTP_USER_AGENT" />
<input type="hidden" name="hidden" value="Referring_Page_Link,Referring_Page_Title" />
<input type="hidden" name="Referring_Page_Link" value="http://www.google.com.mx/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0CB0QFjAAahUKEwjHnbS5y4jGAhVODZIKHfzYANE&url=http%3A%2F%2Frevcom.us%2Fcommentform-en.php&ei=Nf55VYevI86ayAT8sYOIDQ&usg=AFQjCNFStLEMrNFcowXzUW7P3ZxteK5duA&bvm=bv.95277229,d.aWw">

<input type='hidden' name="redirect" value="http://revcom.us/commentsthanks.php" />
<input type="hidden" name="Referring_Page_Title" value="" />
<input type="hidden" name="subject" value="Comments Re: " />

                </form>
            </td>
          </tr>
        </table>
      </div>
    
  </div>  <!-- CONTENEDOR PRINCIPAL 12col -->


  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
�;
 


