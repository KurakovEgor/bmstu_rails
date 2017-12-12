<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <xsl:variable name="error" select="hash/error"/>
    <xsl:variable name="sequences" select="hash/sequences"/>
    <xsl:variable name="longest-seq" select="hash/longest-seq"/>
    <h1>Результаты:</h1>
    <p>
      <i>Самая длинная последовательность совершенных чисел: </i>
      <xsl:choose>
        <xsl:when test="count($longest-seq/longest-seq) = 0">
          'Не нашлось самой длинной последовательности'
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$longest-seq/longest-seq">
            <xsl:value-of select="." />
            <xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </p>
    <xsl:choose>
      <xsl:when test="not($error/@nil)">
        <p id="error">
          <xsl:value-of select="$error"></xsl:value-of>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <table>
          <thead>
            <tr>
              <th>№</th>
              <th>Последовательность</th>
            </tr>
          </thead>
          <tbody>
            <xsl:choose>
              <xsl:when test="count($sequences/sequence) = 0">
                <tr><td></td><td>Не нашлось ни одной последовательности</td></tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="$sequences/sequence">
                  <tr>
                    <td>
                      <xsl:value-of select="position()"></xsl:value-of>
                    </td>
                    <td>
                      <xsl:for-each select="./sequence">
                        <xsl:value-of select="." />
                        <xsl:if test="position() != last()">, </xsl:if>
                      </xsl:for-each>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </tbody>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>