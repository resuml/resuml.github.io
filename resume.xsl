<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
  <xsl:output encoding="UTF-8" indent="yes"/>

  <xsl:template match="/resume">
    <html>
      <head>
        <title><xsl:value-of select="demographics/name"/> | Resume</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
        <link rel="stylesheet" href="resume.css"/>
        <link rel="stylesheet" href="resume-print.css"/>
        <link rel="shortcut icon" type="image/png" href="/favicon.png">
          <xsl:attribute name="href">
            <xsl:call-template name="icon-link">
              <xsl:with-param name="source" select="demographics"/>
              <xsl:with-param name="size" select="'64'"/>
            </xsl:call-template>
          </xsl:attribute>
        </link>
      </head>
      <body>
        <div id="print">
          <a class="modal-trigger btn-small waves-effect waves-light" href="#modalPrint"><i class="material-icons left">print</i> Print</a>
        </div>
        <div class="container">
          <div class="row">
            <div class="col s10 offset-s1">
              <xsl:apply-templates/>
            </div>
          </div>
        </div>
          <div id="modalPrint" class="modal">
            <div class="modal-content">
              <h5>Please select the sections you would like to print:</h5>
              <div id="print-sections" class="row"></div>
            </div>
            <div class="modal-footer">
              <a class="modal-close waves-effect waves-green btn-flat">Close</a>
              <a class="waves-effect waves-light btn-small" onclick="printSections();"><i class="material-icons left">print</i> Print</a>
            </div>
          </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
        <script src="resume.js"></script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/resume/demographics">
    <div id="demographics" class="row section">
      <div class="header hidden">Contact Information</div>
      <div class="col s10">
        <h1><xsl:value-of select="name"/></h1>
        <h2><xsl:value-of select="title"/></h2>
        <xsl:call-template name="contact"/>
        <p class="description"><xsl:value-of select="description"/></p>
      </div>
      <div class="col s2 center-align">
        <img id="picture" src="{picture}" alt="{name}"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/resume/keywords">
    <div id="keywords" class="row section no-print">
      <xsl:for-each select="./*">
        <div class="header"><xsl:value-of select="@title"/></div>
        <div class="col s12">
          <xsl:call-template name="tags"/>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="/resume/roles">
    <div id="roles" class="row section">
      <div class="header">Experience</div>
      <div class="col s12">
        <xsl:for-each select="role">
          <div class="row role">
            <div class="col s1 center-align">
              <xsl:call-template name="icon"/>
            </div>
            <div class="col s11">
              <h2><xsl:value-of select="title"/></h2>
              <h3 class="employer"><a href="{link}" target="_blank"><xsl:value-of select="employer"/></a></h3>
              <xsl:call-template name="tenure"/>
              <xsl:call-template name="tags"/>
              <xsl:call-template name="description"/>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/resume/education">
    <div id="education" class="row section">
      <div class="header">Education</div>
      <div class="col s12">
        <xsl:for-each select="./degree">
          <div class="row degree">
            <div class="col s1">
              <xsl:call-template name="icon"/>
            </div>
            <div class="col s11">
              <h2 class="title"><xsl:value-of select="title"/></h2>
              <h3 class="institution"><a href="{link}" target="_blank"><xsl:value-of select="institution"/></a></h3>
              <xsl:call-template name="tenure"/>
              <xsl:call-template name="tags"/>
              <xsl:call-template name="description"/>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/resume/projects">
    <div id="projects" class="row section no-print">
      <div class="header">Projects</div>
      <div class="col s12">
        <xsl:for-each select="./project">
          <div class="row project">
            <div class="col s1">
              <xsl:call-template name="icon"/>
            </div>
            <div class="col s11">
              <h2 class="name"><a href="{link}" target="_blank"><xsl:value-of select="name"/></a></h2>
              <p class="date"><xsl:value-of select="date"/></p>
              <xsl:call-template name="tags"/>
              <xsl:call-template name="description"/>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/resume/publications">
    <div id="publications" class="row section no-print">
      <div class="header">Publications</div>
      <div class="col s12">
        <xsl:for-each select="./publication">
          <div class="row publication">
            <div class="col s12">
              <h2 class="name"><a href="{link}" target="_blank"><xsl:value-of select="title"/></a></h2>
              <h3>
                <span class="publisher"><xsl:value-of select="publisher"/></span>
                -
                <span class="date"><xsl:value-of select="available"/></span>
              </h3>
              <xsl:call-template name="description"/>
            </div>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="/resume/credits">
    <div id="credits" class="row">
      <div class="header"></div>
      <div class="col s12">
        <xsl:for-each select="credit">
          <a href="{link}" target="_blank">
            <img alt="{title}">
              <xsl:attribute name="src">
                <xsl:call-template name="icon-link">
                  <xsl:with-param name="source" select="."/>
                  <xsl:with-param name="size" select="'16'"/>
                </xsl:call-template>
              </xsl:attribute>
            </img>
            <xsl:value-of select="title"/>
          </a>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="icon-link">
    <xsl:param name="source"/>
    <xsl:param name="size"/>
    <xsl:variable name="icon-link">
      <xsl:choose>
        <xsl:when test="$source/icon"><xsl:value-of select="$source/icon"/></xsl:when>
        <xsl:otherwise>https://api.faviconkit.com/<xsl:value-of select="substring-after($source/link, '://')"/>/<xsl:value-of select="$size"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$icon-link"/>
  </xsl:template>

  <xsl:template name="icon">
    <a class="icon" href="{link}" target="_blank">
      <img alt="{employer|title|name}">
        <xsl:attribute name="src">
          <xsl:call-template name="icon-link">
            <xsl:with-param name="source" select="."/>
            <xsl:with-param name="size" select="'64'"/>
          </xsl:call-template>
        </xsl:attribute>
      </img>
    </a>
  </xsl:template>

  <xsl:template name="tenure">
    <xsl:variable name="end">
      <xsl:choose>
        <xsl:when test="tenure/end"><xsl:value-of select="tenure/end"/></xsl:when>
        <xsl:otherwise>Current</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <p class="tenure">
      <span class="date"><xsl:value-of select="tenure/start"/></span> →
      <span class="date"><xsl:value-of select="$end"/></span>
      <span class="duration"></span>
    </p>
  </xsl:template>

  <xsl:template name="tags">
    <xsl:variable name="tags" select="(tags|.)"/>

    <div class="tags">
      <xsl:for-each select="$tags/tag">
        <div class="tag"><xsl:value-of select="."/></div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template name="description">
    <p class="description"><xsl:value-of select="description"/></p>
    <ul class="details">
      <xsl:for-each select="details/detail">
        <li><xsl:value-of select="."/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="contact">
    <div id="contact">
      <xsl:if test="address">
        <p class="address"><i class="tiny material-icons">location_on</i> <xsl:value-of select="address"/></p>
      </xsl:if>

      <xsl:if test="phone">
        <p class="phone"><i class="tiny material-icons">local_phone</i> <xsl:value-of select="phone"/></p>
      </xsl:if>

      <xsl:if test="link">
        <p class="homepage"><a href="{link}" target="_blank"><i class="tiny material-icons">insert_link</i> <xsl:value-of select="link"/></a></p>
      </xsl:if>

      <xsl:if test="email">
        <p class="email">
          <a href="mailto:{email}">
            <i class="tiny material-icons">mail_outline</i>
            <xsl:value-of select="email"/>
          </a>
          <xsl:if test="crypto">
            <a class="public-key" href="{crypto/key}" target="_blank">
              <xsl:value-of select="crypto/fingerprint"/>
            </a>
          </xsl:if>
        </p>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>