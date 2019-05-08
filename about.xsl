<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="common.xsl" />

<!--
	About page for bouquetwines.com winelist
	Stephen Taylor • Lambent Technology • sjt@lambenttechnology.com
-->

	<xsl:output method="xml" omit-xml-declaration="yes"/>

	<xsl:template match="winelist"><!--root-->
		<img class="rpic" src="annetupker.jpg" alt="Anne Tupker MW" title="Anne Tupker MW" />
		<h1 style="margin-bottom: 2em">About me</h1>
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="aboutme/para">
		<p style="margin-right: 3em; text-align: justify;">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="aboutme/address">
		<address><xsl:apply-templates/></address>
	</xsl:template>

	<xsl:template match="duty|introduction|links|order|season|wines" /><!--ignore-->

</xsl:stylesheet>