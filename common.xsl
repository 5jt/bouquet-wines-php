<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--
		common XSL templates for bouquetwines.com
		Stephen Taylor • Lambent Technology • sjt@lambenttechnology.com
		19/01/2010 00:20:29
	-->

	<!-- ignore top-level BouquetML elements -->
	<xsl:template match="vatrate|pricebreak"/>


	<!-- replicate XHTML elements with attributes and contents -->
	<xsl:template match="a|acronym|br|cite|em|sup">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>

	<!-- general attribute template: replicate the attribute -->
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>


	<!-- map BouquetML elements to XHTML elements -->
	<xsl:template match="bold">
			<strong><xsl:apply-templates/></strong>
	</xsl:template>

	<xsl:template match="italic">
			<em><xsl:apply-templates/></em>
	</xsl:template>


	<!-- map BouquetML elements to XHTML spans with CSS classes -->
	<xsl:template match="person|phrase|smallcaps">
			<span class="{name()}"><xsl:apply-templates/></span>
	</xsl:template>

</xsl:stylesheet>