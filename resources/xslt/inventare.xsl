<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="3.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:import href="shared/base.xsl"/>
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="currentIx"/>
    <xsl:param name="amount"/>
    <xsl:param name="progress"/>
    <xsl:variable name="iiif">https://iiif.acdh.oeaw.ac.at/rita/</xsl:variable>
    <xsl:variable name="signatur">
        <xsl:value-of select=".//tei:institution/text()"/>, <xsl:value-of select=".//tei:repository[1]/text()"/>, <xsl:value-of select=".//tei:msIdentifier/tei:idno[1]/text()"/>
    </xsl:variable>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.18/b-1.5.4/b-colvis-1.5.4/b-html5-1.5.4/b-print-1.5.4/fh-3.1.4/r-2.2.2/datatables.css"/>
        
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.18/b-1.5.4/b-colvis-1.5.4/b-html5-1.5.4/b-print-1.5.4/fh-3.1.4/r-2.2.2/datatables.js"/>
        <!--  https://github.com/jhyland87/DataTables-Keep-Conditions  -->
        <script src="../resources/js/datatables/dataTables.keepConditions.min.js"/>
        
        
        <div class="card">
            <div class="card card-header">
                <div class="row">
                    
                    <div class="col-md-12">
                        <h2 align="center">
                            <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                            <a>
                                <i class="fas fa-info" title="show more info about the document" data-toggle="modal" data-target="#exampleModalLong"/>
                            </a>
                            | 
                            <a href="{$path2source}">
                                <i class="fas fa-download" title="show TEI source"/>
                            </a>
                        </h2>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div>
                    <div id="datatable">
                        <table id="myTable" class="table table-striped table-condensed table-hover">
                            <thead>
                                <tr>
                                    <xsl:for-each select=".//tei:table[@xml:id='myTable']//tei:row[@style='header']//tei:cell">
                                        <th>
                                            <xsl:value-of select="./text()"/>
                                        </th>
                                    </xsl:for-each>
                                </tr>
                            </thead>
                            <tfoot style="display:none">
                                <tr>
                                    <xsl:for-each select=".//tei:table[@xml:id='myTable']//tei:row[@style='footer']//tei:cell">
                                        <th>
                                            <xsl:value-of select="./text()"/>
                                        </th>
                                    </xsl:for-each>
                                </tr>
                            </tfoot>
                            <tbody id="myTableBody" style="display:none">
                                <xsl:for-each select=".//tei:table[@xml:id='myTable']//tei:row[not(@style)]">
                                    <tr>
                                        <xsl:apply-templates select="tei:cell"/>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
                <div class="card-footer">
                    <p style="text-align:center;">
                        <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                            <div class="footnotes">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:text>fn</xsl:text>
                                        <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                    </xsl:attribute>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>#fna_</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <sup>
                                            <xsl:number level="any" format="1" count="tei:note[./tei:p]"/>
                                        </sup>
                                    </a>
                                </xsl:element>
                                <xsl:apply-templates/>
                            </div>
                        </xsl:for-each>
                    </p>
                    <p>
                        <hr/>
                        <h3>Zitierhinweis</h3>
                        <blockquote class="blockquote">
                            <cite title="Source Title">
                                Michael Span, <xsl:value-of select="//tei:titleStmt/tei:title/text()"/>, hg. v. Michael Span und Michael Prokosch, In: Reading in the Alps, https://rita.acdh.oeaw.ac.at</cite>
                        </blockquote>                    
                    </p>
                </div>
            </div>
            <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">
                                <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                    <xsl:apply-templates/>
                                    <br/>
                                </xsl:for-each>
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">x</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped">
                                <tbody>
                                    <xsl:if test="//tei:msIdentifier">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:msIdentifie">Signatur</abbr>
                                            </th>
                                            <td>
                                                <xsl:for-each select="//tei:msIdentifier/child::*">
                                                    <abbr>
                                                        <xsl:attribute name="title">
                                                            <xsl:value-of select="name()"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="."/>
                                                    </abbr>
                                                    <br/>
                                                </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="//tei:msContents">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:msContents">Regest</abbr>
                                            </th>
                                            <td>
                                                <xsl:apply-templates select="//tei:msContents"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="//tei:supportDesc/tei:extent">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:supportDesc/tei:extent">Extent</abbr>
                                            </th>
                                            <td>
                                                <xsl:apply-templates select="//tei:supportDesc/tei:extent"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <th>Verantwortlich</th>
                                        <td>
                                            <xsl:for-each select="//tei:author">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                    <xsl:if test="//tei:titleStmt/tei:respStmt">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:titleStmt/tei:respStmt">responsible</abbr>
                                            </th>
                                            <td>
                                                <xsl:for-each select="//tei:titleStmt/tei:respStmt">
                                                    <p>
                                                        <xsl:apply-templates/>
                                                    </p>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <th>
                                            <abbr title="//tei:availability//tei:p[1]">License</abbr>
                                        </th>
                                        <xsl:choose>
                                            <xsl:when test="//tei:licence[@target]">
                                                <td align="center">
                                                    <a class="navlink" target="_blank">
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                    </a>
                                                </td>
                                            </xsl:when>
                                            <xsl:when test="//tei:licence">
                                                <td>
                                                    <xsl:apply-templates select="//tei:licence"/>
                                                </td>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <td>no license provided</td>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </tr>
                                    <tr>
                                        <th>
                                            Hinweis
                                        </th>
                                        <td>
                                            <p>Die Tabelle kann im gesamten durchsucht werden. Dazu den gewünschten Begriff im "Suchen" Feld <strong>rechts oberhalb der Tabelle</strong> eintragen.</p> 
                                            <p>Darüber hinaus kann auch gezielt in den einzelnen Spalten gesucht werden. Dazu den gewünschten Begriff in das Suchefeld <strong>am Ende der Spalte</strong> eingeben.</p>
                                            <p>Die (gefilterten) Ergebnisse können als Excel-Tabelle oder als PDF heruntergeladen, bzw. in den Zwischenspeicher gelegt werden. Dazu auf den entpsrechenden Button <strong>links oberhalb der Tabelle</strong> klicken.</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                var table = $('#myTable').DataTable({
                fixedHeader: true,
                "language": {
                "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
                },
                keepConditions: true,
                "pageLength": 10,
                dom: 'Bfrtip',
                buttons: [
                'copy', 'excel', 'pdf', 'colvis'
                ]
                });
                
                $(document).ready(function() {
                $("#myTableBody").show({});
                $('#myTable tfoot th').each( function () {
                var title = $(this).text();
                $(this).html( '<input type="text"/>' );
                });
                $("#myTable tfoot").show();
                table.columns().every( function () {
                var that = this;
                
                $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                that
                .search( this.value )
                .draw();
                }
                } );
                } );
                });
                
                
            </script>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='footnote text']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:variable name="doc-path">
            <xsl:value-of select="substring-after(./@target, '#')"/>
        </xsl:variable>
        <xsl:variable name="doc-id">
            <xsl:value-of select="substring-after($doc-path, '/')"/>
        </xsl:variable>
        <xsl:variable name="doc-col">
            <xsl:value-of select="substring-before($doc-path, '/')"/>
        </xsl:variable>
        <xsl:variable name="to-transcript">
            <xsl:value-of select="concat('show.html?document=', $doc-id, '&amp;directory=', $doc-col)"/>
        </xsl:variable>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="$to-transcript"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
</xsl:stylesheet>