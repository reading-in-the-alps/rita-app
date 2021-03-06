<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:import href="shared/base.xsl"/>
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <div class="row" style="text-align:left">
                        <div class="col-md-12" align="center">
                            <h1>
                                <xsl:value-of select="//tei:title[@type='main']"/>                                
                            </h1>
                            <h4>
                                <muted>
                                    <xsl:value-of select="//tei:title[@type='sub']"/>
                                </muted>
                            </h4>
                            von 
                           <h5>
                              <i>
                                    <xsl:value-of select="//tei:author/text()"/>
                                </i>
                           </h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <xsl:apply-templates select="//tei:body"/>
                </div>
                <div class="card-footer text-muted" style="text-align:center">
                    Michael Span,
                    <i>
                        <xsl:value-of select="//tei:title[@type='main']"/>
                    </i>
                    <br/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$path2source"/>
                        </xsl:attribute>
                        TEI
                    </a>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>