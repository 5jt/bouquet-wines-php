<?php

/* PHP library.php for bouquetwines.com
   Stephen Taylor • sjt@lambenttechnology.com
   18/01/2010
   06/10/2016
 */

///////////////////////////////////////////////////////////////////////////////
function XslTransform ($xmldoc, $xsldoc, $parms='') { // results of an XSLT transform

  $xml = new DOMDocument;
# $xml->load($xmldoc); // xmlns attribute breaks XSLT
  $str = preg_replace('/<html([^>]+)>/i','<html>',file_get_contents($xmldoc));
  // but that leaves unidentified HTML entities, eg &nbsp;
  $xml->loadXML(numeric_entities($str));


  $xsl = new DOMDocument;
  $xsl->load($xsldoc);

  $proc = new XSLTProcessor;
  $proc->importStyleSheet($xsl);

  if (is_array($parms)) {$proc->setParameter('',$parms);}

  $html = $proc->transformToXml($xml);

  if (0 != count($html)) {return $html;}
  else
  {
  return <<<EOF
<p class="error">XSLT error</p>
<dl>
	<dt>XML</dt><dd>$xmldoc</dd>
	<dt>XSL</dt><dd>$xsldoc</dd>
	<dt>imgsrc</dt><dd>{$parms['imgsrc']}</dd>
</dl>
EOF;
	}
}
function numeric_entities($string)
{//from http://uk2.php.net/manual/en/function.get-html-translation-table.php
	$mapping	= array();
	$ents			= get_html_translation_table(HTML_ENTITIES,ENT_NOQUOTES);
	$specs		= get_html_translation_table(HTML_SPECIALCHARS,ENT_NOQUOTES);
	foreach (array_diff($ents,$specs) as $char => $entity)
		{$mapping[$entity] = '&#' . ord($char) . ';';}
	return str_replace(array_keys($mapping), $mapping, $string);
}
function seasonOf($datetime)
{
  $seasons = array(
    'Winter','Winter',
    'Spring','Spring','Spring',
    'Summer','Summer','Summer',
    'Autumn','Autumn','Autumn'
    ,'Winter'
    );
  return array(
    'this-season'=>$seasons[$datetime[mon]],
    'this-year'=>(string) $datetime[year]
    );
}
?>