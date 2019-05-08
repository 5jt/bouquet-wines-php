<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="common.xsl" />

	<xsl:param name="this-season">{unidentified season}</xsl:param>
	<xsl:param name="this-year">{unidentified year}</xsl:param>

<!--
	home page for bouquetwines.com winelist
	Stephen Taylor • Lambent Technology • sjt@lambenttechnology.com
-->

	<xsl:output method="xml" omit-xml-declaration="yes"/>

	<xsl:template match="winelist"><!--root-->
		<img class="rpic" src="annetupker.jpg" alt="Anne Tupker MW" title="Anne Tupker MW" />
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="season">
		<!-- <p class="display"><xsl:value-of select="."/></p> -->
		<p class="display"><xsl:value-of select="$this-season"/><xsl:text> </xsl:text><xsl:value-of select="$this-year"/></p>
	</xsl:template>

	<xsl:template match="introduction[@medium='web']/para">
		<p style="margin-right: 3em; text-align: justify;">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="signature">
		<p style="margin:0.5em 5em;text-align:right"><img src="signature.gif"/></p>
	</xsl:template>

	<xsl:template match="aboutme|duty|links|order|*[@medium='print']|wines" /><!--ignore-->

</xsl:stylesheet>