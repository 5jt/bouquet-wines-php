<?php
/* script for bouquetwines.com
   Stephen Taylor • sjt@lambenttechnology.com
   2010.01.18
   2016.11.01 * cast result of $xml->pricebreak
 */

require ('library.php');

$src = 'winelist.xml';

$xml = new SimpleXMLElement(file_get_contents($src));
$BRK = (float)$xml->pricebreak; // 2016.11.01
$brk = number_format($BRK, $BRK==floor($BRK) ? 0 : 2);

// In $map 'style' values match ids of style elements in BouquetMl document,
// and 'op' values are tested for in wine.xsl
$map = array (
							'home'		=> array('ttl'=>'Home'),
							'white1'	=> array('ttl'=>'Whites',                 'style'=>'white',    'op'=>'up to'),
//              'rosé'    => array('ttl'=>'Rosé',                   'style'=>'rosé',     'op'=>'up to'),
							'rosé'		=> array('ttl'=>'Rosé',                   'style'=>'rosé',                  ),
//							'sweet'		=> array('ttl'=>'Sweet wine',             'style'=>'sweet'                  ),
							'red1'		=> array('ttl'=>'Reds',    	              'style'=>'red',      'op'=>'up to'),
							'spark'		=> array('ttl'=>'Champagnes & proseccos', 'style'=>'sparkling'              ),
							'white2'	=> array('ttl'=>'Whites',                 'style'=>'white',    'op'=>'above'),
							'red2'		=> array('ttl'=>'Reds',                   'style'=>'red',      'op'=>'above'),
							'about'		=> array('ttl'=>'About me'),
							'order'		=> array('ttl'=>'Order wine'),
							);

$nav = '';
$vars = array('pg'=>'home');
$tits = array();

foreach ($map as $pag => $arr)
{
  $tits[$pag] = ($arr['ttl']).( array_key_exists('op', $arr) ? " {$arr['op']} £{$brk}" : '' );
	$ttl = htmlspecialchars($tits[$pag]);
	$nav .= "<li><a href=\"?pg={$pag}\" class=\"{$pag}\">{$ttl}</a></li>\n";
}

if (isset ($_SERVER['QUERY_STRING'])) {parse_str($_SERVER['QUERY_STRING'], $vars);}
$pg			= array_key_exists($vars['pg'], $map) ? $vars['pg'] : 'home' ;
$title	= ($pg == 'home' ? '' : htmlspecialchars($tits[$pg]).' | ') . 'Bouquet Wines';

switch ($pg)
{
	case 'home':
	case 'about':
	case 'order':
		$main = XslTransform($src, "$pg.xsl",seasonOf(getdate())); // eponymous XSL
		break;

	default:
# 	$main='<p>My wines here</p>';
		$prms = array('wine-style' => $map[$pg]['style'], 'page-title' => $tits[$pg]);
		if (array_key_exists('op', $map[$pg])) {$prms['price-op'] = $map[$pg]['op'];}
		$main = XslTransform($src, "wine.xsl", $prms);
		break;
}

$html = <<<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
    <link rel="stylesheet" type="text/css" href="styles.css" />
    <meta name="author" content="Anne Tupker" />
    <meta name="description" content="Bouquet Wines is a London vintner. Its owner, Anne Tupker, a Master of Wine, offers a hand-picked selection of great wines from Europe and the New World." />
    <meta name="generator" content="UltraEdit-32" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="keywords" content="wine,white wine,red wine,champagne,prosecco,tasting,tutored tasting, food and wine matching,restaurant wine list" />
    <title>$title</title>
  </head>
  <body class="$pg">
    <form id="search" onsubmit="return goFind(this.searchstring.value)">
      <input type="text" name="searchstring" value="Search this site" class="initial" onclick="clearField(this)" />
      <input type="submit" value="Search" />
      <script language="javascript" type="text/javascript" href="library.js"></script>
    </form>
    <div id="BANNER">
      <a class="sans" href="?pg=home" title="Bouquet Wines home">Bou<span id="LOG2">q</span>uet Wines</a><br />
      <span id="TAG">I tasted thousands — and chose these</span>
    </div>
    <div id="NAV" class="sans">
      <ul>
      	$nav
      </ul>
    </div>
    <div id="MAIN" style="line-height:1.4em">
    	$main
    </div>
    <div id="RUBRIC">
      Web design <a href="http://www.lambenttechnology.com">Lambent Technology</a>
    </div>
  </body>
</html>
EOF;

echo ($html);
?>