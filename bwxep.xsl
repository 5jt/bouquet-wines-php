<?xml version="1.0" encoding="UTF-8"?>
<!--
	XSL-FO for bouquetwines.com winelist
	Stephen Taylor • Lambent Technology • sjt@lambenttechnology.com
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:variable name="price-break">
		<xsl:value-of select="format-number(winelist/pricebreak, '##0.00')"/>
	</xsl:variable>
	<xsl:variable name="vat-rate"><xsl:value-of select="winelist/vatrate"/></xsl:variable>

	<xsl:param name="rnd">0.05</xsl:param> <!-- round to 5p -->


	<xsl:template match="winelist">
		<fo:root>

			<!-- page layout -->
			<fo:layout-master-set>
				<fo:simple-page-master
														margin-top="30pt" 	margin-bottom="30pt"
														margin-left="30pt" 	margin-right="30pt"
														page-width="210mm"	page-height="297mm"
														master-name="A4"
														>
					<fo:region-body 	margin-top="32pt"		margin-bottom="32pt"
														margin-left="112pt"	margin-right="0pt"
														/>
					<fo:region-before	extent="30pt"/>
					<fo:region-after	extent="30pt"/>
				</fo:simple-page-master>
			</fo:layout-master-set>

			<!-- page content -->
			<fo:page-sequence master-reference="A4"
												font-family="Garamond"
												initial-page-number="1" language="en" country="gb"
												>

				<!-- page headers -->
				<fo:static-content	flow-name="xsl-region-before"
														color="gray"
														font-family="Lucida Sans"
														>
					<fo:block text-align-last="justify">
						<fo:inline font-size="9pt" letter-spacing="0.2em">
							BOU<fo:inline color="maroon" font-style="italic">Q</fo:inline>UET WINES
						</fo:inline>
						<fo:leader leader-pattern="space"/>
						<fo:inline font-size="8pt">www.bouquetwines.com</fo:inline>
					</fo:block>
					<fo:block-container
							absolute-position="absolute"
							left="12pt" top="2in"
							max-width="60pt"
						>
						<fo:block
								font-size="8pt"
								letter-spacing="0.2em"
								line-height="3em"
								padding-top="36pt"
								text-align="left"
								text-transform="uppercase"
							>
							<fo:retrieve-marker retrieve-class-name="sectionid"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- page footers -->
				<fo:static-content	flow-name="xsl-region-after"
					color="gray"
					text-align="right"
					>
					<fo:block>
						<fo:inline
							font-size="12pt"
							font-style="italic"
							space-end="3pt"
							>
							<fo:retrieve-marker retrieve-class-name="season"/>
						</fo:inline>
						<fo:inline
							font-family="Lucida Sans"
							font-size="8pt"
							letter-spacing="0.1em"
							text-transform="uppercase"
							>
							Page <fo:page-number/>
						</fo:inline>
					</fo:block>
				</fo:static-content>

				<!-- main text block -->
				<fo:flow flow-name="xsl-region-body">
					<!--<xsl:apply-templates select="*[@medium!='web']"/>-->
					<xsl:apply-templates select="introduction[@medium='print']"/>
					<xsl:call-template name="page-break"/>

					<xsl:apply-templates select="wines/style[@id='white']">
						<xsl:with-param name="break">page</xsl:with-param>
						<xsl:with-param name="header-text">
							Best Buys wines for up to £<xsl:value-of select="$price-break"/> a bottle
						</xsl:with-param>
						<xsl:with-param name="price-op" select="'up to'"/>
					</xsl:apply-templates>

					<xsl:apply-templates select="wines/style[@id='rosé']">
						<xsl:with-param name="break">page</xsl:with-param>
					</xsl:apply-templates>

					<xsl:apply-templates select="wines/style[@id='sweet']"/>

					<xsl:apply-templates select="wines/style[@id='red']">
						<xsl:with-param name="break">page</xsl:with-param>
						<xsl:with-param name="price-op" select="'up to'"/>
					</xsl:apply-templates>

					<xsl:apply-templates select="wines/style[@id='sparkling']">
						<xsl:with-param name="break">page</xsl:with-param>
						<xsl:with-param name="header-text">
							Champagne &amp; sparkling
						</xsl:with-param>
					</xsl:apply-templates>

					<xsl:apply-templates select="wines/style[@id='white']">
						<xsl:with-param name="break">page</xsl:with-param>
						<xsl:with-param name="header-text">
							Main list wines for over £<xsl:value-of select="$price-break"/> a bottle
						</xsl:with-param>
						<xsl:with-param name="price-op" select="'above'"/>
					</xsl:apply-templates>

					<xsl:apply-templates select="wines/style[@id='red']">
						<xsl:with-param name="break">page</xsl:with-param>
						<xsl:with-param name="price-op" select="'above'"/>
					</xsl:apply-templates>

				</fo:flow>

			</fo:page-sequence>

		</fo:root>
	</xsl:template>


	<xsl:template match="season">
		<fo:block>
			<fo:marker marker-class-name="season"><xsl:value-of select="."/></fo:marker>
		</fo:block>
	</xsl:template>

	<xsl:template match="introduction">
		<fo:block>
			<fo:marker marker-class-name="sectionid"/><!-- blank for introduction -->
		</fo:block>
		<fo:block
			font-family="Lucida Sans"
			font-size="7pt"
			letter-spacing="0.2em"
			line-height="2em"
			margin-left="3.8in"
			margin-top="18pt"
			linefeed-treatment="preserve"
			text-transform="uppercase"
			><fo:inline font-size="16pt" font-weight="bold" letter-spacing="0.2em">
			BOU<fo:inline color="maroon" font-style="italic">Q</fo:inline>UET
			WINES</fo:inline>
			16 Holland Park Avenue
			London W11 3QU
			020 3689 7930
			sparkling@msn.com
		</fo:block>
		<fo:block
			font-family="Lucida Sans"
			font-size="8pt"
			font-weight="bold"
			margin-left="-36pt"
			margin-top="36pt"
		>
		WINE LIST
		</fo:block>
		<fo:block
			font-size="48pt"
			font-style="italic"
			margin-left="-36pt"
			margin-bottom="36pt"
		>
			<xsl:value-of select="../season"/>
		</fo:block>
		<xsl:apply-templates/>
	</xsl:template>

	<!-- para -->
	<xsl:template match="para">
		<fo:block
			space-before="12pt"
			line-height="16pt"
			margin-right="36pt"
			text-align="justify"
			>
			<!-- <xsl:apply-templates select="@break"/> -->
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<!-- list -->
	<xsl:template match="list">
		<fo:list-block
			line-height="16pt"
			margin-right="36pt"
			provisional-distance-between-starts="9pt"
			provisional-label-separation="3pt"
			space-before="6pt"
			text-align="justify"
			>
			<xsl:apply-templates select="li"/>
		</fo:list-block>
	</xsl:template>

	<xsl:template match="li">
		<fo:list-item
			>
			<fo:list-item-label end-indent="label-end()">
				<fo:block>&#x2022;</fo:block> <!-- bullet -->
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:apply-templates/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

	<!-- signature -->
	<xsl:template match="signature">
		<fo:block margin-bottom="12pt" margin-right="0.5in" text-align="right">
			<fo:external-graphic src="url(sigandpic.jpg)"/>
		</fo:block>
	</xsl:template>

	<!-- style -->
	<xsl:template	match="style">
		<xsl:param name="break">none</xsl:param>
		<xsl:param name="header-text">none</xsl:param>
		<xsl:param name="price-op"/>
		<xsl:param name="duty">
			<xsl:choose>
				<xsl:when test="@id='sparkling'">
					<xsl:value-of select="/winelist/duty/sparkling"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="/winelist/duty/still"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<fo:block	color="maroon"
							font-family="Lucida Sans"
							font-size="13pt"
							keep-with-next.within-page="always"
							letter-spacing="0.1em"
							margin-top="24pt"	margin-bottom="0.3em"
							margin-left="0pt" margin-right="5em"
							text-align="center"
							text-transform="uppercase"
					>
			<xsl:if test="$break='page'"><xsl:call-template name="page-break"/></xsl:if>
			<xsl:value-of select="@name"/>
		</fo:block>

		<xsl:if test="$header-text != 'none'">
			<fo:block>
				<fo:marker marker-class-name="sectionid"><xsl:value-of select="$header-text"/></fo:marker>
			</fo:block>
		</xsl:if>

		<xsl:apply-templates select="wine">
			<xsl:with-param name="duty"><xsl:value-of select="$duty"/></xsl:with-param>
			<xsl:with-param name="price-op"><xsl:value-of select="$price-op"/></xsl:with-param>
		</xsl:apply-templates>

	</xsl:template>


	<!-- page breaks -->
	<xsl:template name="page-break">
		<xsl:attribute name="break-before">page</xsl:attribute>
	</xsl:template>



	<xsl:template match="wine">
		<xsl:param name="duty">0.00</xsl:param>
		<xsl:param name="price-op">none</xsl:param>
		<xsl:param name="case-plus-vat"     select="($duty + caseprice)* (1 + $vat-rate div 100)"/>
<!--	<xsl:param name="case-plus-vat"     select="$duty + caseprice * (1 + $vat-rate div 100)"/> -->
<!--	<xsl:param name="case-plus-vat"     select="caseprice * (1 + $vat-rate div 100)"/> -->
		<xsl:param name="show-case-price"   select="format-number($rnd*round(($case-plus-vat div  1) div $rnd),'##0.00')"/>
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

		<!-- name, domain, caseprice -->
		<fo:block
							font-size="14pt"
							font-style="italic"
							keep-together.within-page="always"
							keep-with-next.within-page="always"
							letter-spacing="0.05em"
							space-before="18pt"	space-after="6pt"
							start-indent="0pt"	end-indent="0pt"
							text-align-last="justify"
		>
			<xsl:apply-templates select="name"/>
			<fo:leader leader-pattern="space"/>
			<xsl:apply-templates select="caseprice"><xsl:with-param name="show-case-price" select="$show-case-price"/></xsl:apply-templates>
		</fo:block>

		<!-- description -->
		<fo:block
							font-size="10pt"
							hyphenate="true"
							hyphenation-character="-"
							keep-together.within-page="always"
							line-height="1.3em"
							space-before="0in"	space-after="0pt"
							start-indent="14pt"	end-indent="72pt"
							text-align="justify"
		>
			<xsl:apply-templates select="description">
				<xsl:with-param name="show-case-price"   select="$show-case-price"/>
				<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
				<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
			</xsl:apply-templates>
		</fo:block>

	</xsl:template>

	<xsl:template match="description">
		<xsl:param name="show-case-price"/>
		<xsl:param name="show-bottle-price"/>
		<xsl:param name="show-magnum-price"/>
		<xsl:apply-templates>
			<xsl:with-param name="show-case-price"   select="$show-case-price"/>
			<xsl:with-param name="show-bottle-price" select="$show-bottle-price"/>
			<xsl:with-param name="show-magnum-price" select="$show-magnum-price"/>
		</xsl:apply-templates>
	</xsl:template>



	<!-- inline styles -->
	<xsl:template match="acronym">
		<fo:inline font-size="9pt" letter-spacing="0.1em"><xsl:value-of select="."/></fo:inline>
	</xsl:template>

	<xsl:template match="bold">
		<fo:inline font-weight="bold"><xsl:apply-templates/></fo:inline>
	</xsl:template>

	<xsl:template match="caseprice"><xsl:param name="show-case-price"/>
		<fo:inline font-size="10pt" font-style="normal">£<xsl:value-of select="$show-case-price"/></fo:inline>
	</xsl:template>

	<xsl:template match="bottleprice"><xsl:param name="show-bottle-price"/>
		<fo:inline font-size="10pt" font-style="normal">£<xsl:value-of select="$show-bottle-price"/></fo:inline>
	</xsl:template>

	<xsl:template match="magnumprice"><xsl:param name="show-magnum-price"/>
		<fo:inline font-size="10pt" font-style="normal">£<xsl:value-of select="$show-magnum-price"/></fo:inline>
	</xsl:template>

	<xsl:template match="domain">
		<fo:inline	color="gray"
								font-family="Lucida Sans"
								font-size="7pt"
								font-style="normal"
								letter-spacing="0.1em"
								text-transform="uppercase"
								>
			<xsl:value-of select="."/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="italic">
		<fo:inline font-style="italic"><xsl:apply-templates/></fo:inline>
	</xsl:template>

	<xsl:template match="person">
		<fo:inline color="maroon"><xsl:value-of select="."/></fo:inline>
	</xsl:template>

	<xsl:template match="phrase">
		<fo:inline font-style="italic"><xsl:apply-templates/></fo:inline>
	</xsl:template>

	<xsl:template match="smallcaps">
		<fo:inline font-size="80%" letter-spacing="0.1em" text-transform="uppercase"><xsl:value-of select="."/></fo:inline>
	</xsl:template>

	<xsl:template match="sup">
		<fo:inline baseline-shift="super" font-size="8pt"><xsl:apply-templates/></fo:inline>
	</xsl:template>


</xsl:stylesheet>