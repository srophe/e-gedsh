<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:syriaca="http://syriaca.org"
    xmlns:saxon="http://saxon.sf.net/" xmlns:functx="http://www.functx.com">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="xml"/>

    <xsl:template match="tei:TEI">
        <!-- Do front and back independantly  -->
        
        <!-- Output new TEI record for each div -->
        <xsl:for-each select="//tei:div[@type='entry'] | //tei:front | //tei:back">
            <xsl:variable name="id">
                <xsl:choose>
                    <xsl:when test="self::tei:div[@type='entry']">
                        <xsl:value-of select="tokenize(descendant::tei:ab/tei:idno[1],'/')[last()]"/>                                   
                    </xsl:when>
                    <xsl:when test="self::tei:front">frontMatter</xsl:when>
                    <xsl:when test="self::tei:back">backMatter</xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:result-document method="xml" indent="yes" href="temp/data/tei/{$id}.xml">
                <?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
                <?xml-model href="../../out/odd_GEDSH_draft.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
                <TEI xmlns="http://www.tei-c.org/ns/1.0">
                 <teiHeader>
                     <fileDesc>
                         <titleStmt>
                             <xsl:choose>
                                 <xsl:when test="self::tei:div[@type='entry']">
                                     <title level='a'><xsl:copy-of select="tei:head/node()"/></title>
                                     <author><xsl:copy-of select="tei:byline/child::*"/></author>                                     
                                 </xsl:when>
                                 <xsl:when test="self::tei:front">
                                     <title level='a'>Front Matter</title>
                                 </xsl:when>
                                 <xsl:when test="self::tei:back">
                                     <title level='a'>Back Matter</title>
                                 </xsl:when>
                             </xsl:choose>
                             <sponsor>Beth Mardutho: The Syriac Institute</sponsor>
                             <sponsor>Syriaca.org: The Syriac Reference Portal</sponsor>
                             <sponsor>Jean and Alexander Heard Library, Vanderbilt University</sponsor>
                             <funder>The International Balzan Prize Foundation</funder>
                             <editor role="general" ref="http://syriaca.org/documentation/editors.xml#gkiraz">George A. Kiraz</editor>
                             <editor role="print-edition" ref="http://syriaca.org/documentation/editors.xml#sbrock">Sebastian P. Brock</editor>
                             <editor role="print-edition" ref="http://syriaca.org/documentation/editors.xml#abutts">Aaron M. Butts</editor>
                             <editor role="print-edition" ref="http://syriaca.org/documentation/editors.xml#lvanrompay">Lucas Van Rompay</editor>
                             <editor role="electronic-edition" ref="http://syriaca.org/documentation/editors.xml#upossekel">Ute Possekel</editor>
                             <editor role="electronic-edition" ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</editor>
                             <editor role="electronic-edition" ref="http://syriaca.org/documentation/editors.xml#dmichelson">David A. Michelson</editor>
                             <respStmt>
                                 <resp>Data cleaning, editorial proofreading, and TEI editing by</resp>
                                 <name ref="http://syriaca.org/documentation/editors.xml#upossekel">Ute S. Posssekel</name>
                             </respStmt>
                             <respStmt>
                                 <resp>Data cleaning and initial valid TEI encoding by</resp>
                                 <name ref="http://syriaca.org/documentation/editors.xml#dmichelson">David Michelson</name>
                             </respStmt>
                             <respStmt> 
                                 <resp>XSLT transformations by</resp>
                                 <name ref="http://syriaca.org/documentation/editors.xml#wsalesky">Winona Salesky</name>
                             </respStmt>
                             <respStmt>
                                 <resp>Data cleaning, editorial proofreading, TEI schema, and TEI encoding and editing by</resp>
                                 <name ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</name>
                             </respStmt>
                             <respStmt>
                                 <resp>Conversion to semantic XML by</resp>
                                 <name ref="http://syriaca.org/documentation/editors.xml#gkiraz">George A. Kiraz</name>
                             </respStmt>
                         </titleStmt>
                         <editionStmt>
                             <edition n="1.0">Electronic Edition Draft Version 1.0</edition>
                         </editionStmt>
                         <publicationStmt>
                             <authority>Published by Gorgias Press LLC, 954 River Road, Piscataway, NJ 08854 USA www.gorgiaspress.com for Beth Mardutho: The Syriac Institute</authority>
                             <authority>Published with the collaboration of Syriaca.org: The Syriac Reference Portal</authority>
                             <authority>Published and hosted with the collaboration of the Jean and Alexander Heard Library, Vanderbilt University</authority>
                             <availability status="restricted">
                                 <p>Copyright ©2011 by Beth Mardutho: The Syriac Institute</p>
                                 <licence target="https://creativecommons.org/licenses/by-nc/4.0/">
                                     <p>Distributed under an Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License.</p>
                                 </licence>
                             </availability>
                             <date>2016-09-22-16:00</date>
                         </publicationStmt>
                         <seriesStmt>
                             <xsl:copy-of select="//tei:teiHeader/descendant::tei:titleStmt/tei:title[@level='m']"/>
                             <xsl:copy-of select="//tei:teiHeader/descendant::tei:titleStmt/tei:editor"/>
                             <xsl:copy-of select="//tei:teiHeader/descendant::tei:titleStmt/tei:respStmt"/>
                         </seriesStmt>
                         <sourceDesc>
                             <biblStruct>
                                 <monogr>
                                     <title level="m">Gorgias Encyclopedic Dictionary of the Syriac Heritage</title>
                                     <editor>Sebastian P. Brock</editor>
                                     <editor>Aaron M. Butts</editor>
                                     <editor>George A. Kiraz</editor>
                                     <editor>Lucas Van Rompay</editor>
                                     <imprint>
                                         <pubPlace>Piscataway, N.J.</pubPlace>
                                         <publisher>Gorgias Press for Beth Mardutho: The Syriac Institute</publisher>
                                         <date>2011</date>
                                         <note>Copyright ©2011 by Beth Mardutho: The Syriac Institute</note>
                                         <note>ISBN: 978-1-59333-714-8</note>
                                     </imprint>
                                 </monogr>
                             </biblStruct>
                         </sourceDesc>
                     </fileDesc>
                     <revisionDesc status="uncorrected-draft">
                         <change who="http://syriaca.org/documentation/editors.xml#wsalesky" n="1.0" when="{current-date()}">Article record broken out form original electronic edition</change>
                     </revisionDesc>
                 </teiHeader>
                 <text>
                         <xsl:choose>
                             <xsl:when test="self::tei:div[@type='entry']">
                                 <body><xsl:copy-of select="."/></body>
                             </xsl:when>
                             <xsl:when test="self::tei:front">
                                 <front>
                                     <xsl:copy-of select="//tei:titlePage"/>
                                 </front>
                                 <body><xsl:copy-of select="node()[not(self::tei:titlePage)]"/></body>
                             </xsl:when>
                             <xsl:when test="self::tei:back">
                                 <body><xsl:copy-of select="node()"/></body> 
                             </xsl:when>
                         </xsl:choose>
                 </text>
             </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
