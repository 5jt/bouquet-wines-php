<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="common.xsl" />

	<!--
		wines stylesheet for www.bouquetwines.com
		Stephen Taylor • Lambent Technology • sjt@lambenttechnology.com
	-->

	<xsl:param name="page-title"></xsl:param>
	<xsl:param name="price-op">none</xsl:param>
	<xsl:param name="wine-style">sparkling</xsl:param>
	<xsl:param name="rnd">0.05</xsl:param> <!-- round to 5p -->

	<xsl:variable name="duty">
		<xsl:choose>
			<xsl:when test="$wine-style='sparkling'">
				<xsl:value-of select="winelist/duty/sparkling"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="winelist/duty/still"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="price-break"><xsl:value-of select="winelist/pricebreak"/></xsl:variable>
	<xsl:variable name="vat-rate"><xsl:value-of select="winelist/vatrate"/></xsl:variable>


	<xsl:template match="winelist"><!--root-->
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="aboutme|duty|order|links|introduction|season" /><!--ignore-->

	<xsl:template match="style">
		<xsl:if test="@id=$wine-style"><!-- because match="style[@id=$wine-style]" fails-->
			<h1 style="margin-bottom: 2em"><xsl:value-of select="$page-title"/></h1>
			<xsl:apply-templates>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>


	<xsl:template match="wine">
<!--	<xsl:param name="case-plus-vat"     select="caseprice * (1 + $vat-rate div 100)"/> -->
<!--	<xsl:param name="case-plus-vat"     select="$duty + caseprice * (1 + $vat-rate div 100)"/> -->
		<xsl:param name="case-plus-vat"     select="($duty+ caseprice)* (1 + $vat-rate div 100)"/>
		<xsl:param name="show-case-price"   select="format-number($rnd*round(($case-plus-vat div  1) div $rnd),'##0.00')"/>
<!--	<xsl:param name="show-bottle-price" select="format-number(0.05*round(($case-plus-vat div 12) div 0.05),'##0.00')"/> -->
		<xsl:param name="raw-bottle-price"  select=              "$rnd*round(($case-plus-vat div 12) div $rnd)"/>
		<xsl:param name="bottle-roundup"    select="$rnd * number($case-plus-vat &gt; (12*$raw-bottle-price))"/>
		<xsl:param name="show-bottle-price" select="format-number($raw-bottle-price + $bottle-roundup,'##0.00')"/>
		<xsl:param name="show-magnum-price" select="format-number($rnd*round(($case-plus-vat div  6) div $rnd),'##0.00')"/>

		<xsl:choose>
			<xsl:when test="$price-op='up to'">
				<xsl:if test="$show-bottle-price &lt;= $price-break">
					<xsl:call-template name="show-this-wine">
						<xsl:with-param name="show-case-price"   select="$show-case-price"/>
						<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
						<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$price-op='above'">
				<xsl:if test="$show-bottle-price &gt; $price-break">
					<xsl:call-template name="show-this-wine">
						<xsl:with-param name="show-case-price"   select="$show-case-price"/>
						<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
						<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="show-this-wine">
					<xsl:with-param name="show-case-price"   select="$show-case-price"/>
					<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
					<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="show-this-wine">
		<xsl:param name="show-case-price"/>
		<xsl:param name="show-bottle-price"/>
		<xsl:param name="show-magnum-price"/>

		<p class="price">£<xsl:value-of select="$show-case-price"/></p>
		<h2><xsl:apply-templates select="name"/></h2>
		<p class="comment">
			<xsl:apply-templates select="description">
				<xsl:with-param name="show-case-price"   select="$show-case-price"/>
				<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
				<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
			</xsl:apply-templates>
		</p>

	</xsl:template>


	<xsl:template match="description/caseprice"><xsl:param name="show-case-price"/>£<xsl:value-of select="$show-case-price"/></xsl:template>

	<xsl:template match="bottleprice"><xsl:param name="show-bottle-price"/>£<xsl:value-of select="$show-bottle-price"/></xsl:template>

	<xsl:template match="magnumprice"><xsl:param name="show-magnum-price"/>£<xsl:value-of select="$show-magnum-price"/></xsl:template>

	<xsl:template match="domain">
			<span class="domain"><xsl:apply-templates/></span>
	</xsl:template>


</xsl:stylesheet>