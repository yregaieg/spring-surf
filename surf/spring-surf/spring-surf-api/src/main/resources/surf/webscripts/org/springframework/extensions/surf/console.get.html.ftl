<#import "/org/springframework/extensions/surf/webframework.lib.html.ftl" as wsLib/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <@wsLib.head>${msg("surf.index.title")}</@wsLib.head>
   <body>
      <div>
      <@wsLib.header>Command Console</@wsLib.header>

      <!-- General Reports -->
      <#if failures?size &gt; 0>
      <br/>
      <table>
         <tr><td><a href="${url.serviceContext}/index/failures">(+${failures?size} failed)</td></tr>
      </table>
      </#if>

      <br/>

      <!-- outer table -->
      <table width="100%" cellspacing="0">
      <tr>
      <td valign="top" align="left" class="outer">

      <!-- SURF OBJECTS -->
      <table>
         <tr>
            <td colspan="3" class="header" align="center">
                Surf Objects
            </td>
         </tr>
         <tr>
            <td colspan="3"><br/></td>
         </tr>

         <#list sitedata.objectTypeIds as objectTypeId>
            <#assign scalarTypeName = sitedata.getObjectTypeName(objectTypeId)>
            <#assign noun = "object">
            <#assign objects = sitedata.getObjects(objectTypeId)>
            <#if objects?size &gt; 0><#assign noun="objects"></#if>
            <tr>
               <td nowrap><img src="${url.context}/res/images/icons/objects/${objectTypeId}.png"></td>
               <td width="100%">${scalarTypeName}</td>
               <td align="right">${objects?size}</td>
            </tr>
         </#list>
      </table>

      <!-- outer table -->
      </td>
      <td valign="top" align="left" class="outer">

      <!-- WEB SCRIPTS -->
      <table>
         <tr>
            <td colspan="3" class="header" align="center">
               Web Scripts
            </td>
         </tr>
         <tr>
            <td colspan="3"><br/></td>
         </tr>

         <tr>
            <td nowrap><img src="${url.context}/res/images/icons/webscript.png"></td>
            <td width="100%">Web Scripts</td>
            <td align="right">${webscripts?size}</td>
         </tr>
         <tr>
            <td colspan="3">
               <#if rootfamily.children?size &gt; 0>
               <table>
                  <#list rootfamily.children as childpath>
                  <tr><td>
                     <a href="${url.serviceContext}/index/family${childpath.path}">Browse '${childpath.name}' Web Scripts</a>
                  </td></tr>
                  </#list>
               </table>
               <br/>
               </#if>
               <br/>
               <table>
                  <tr><td><a href="${url.serviceContext}/index/all">Browse all Web Scripts</a></td></tr>
                  <tr><td><a href="${url.serviceContext}/index/uri/">Browse by Web Script URI</a></td></tr>
                  <tr><td><a href="${url.serviceContext}/index/package/">Browse by Web Script Package</a></td></tr>
               </table>

               <table>
                  <tr><td><a href="${url.serviceContext}/index/lifecycle/">Browse by Web Script Lifecycle</a></td></tr>
                  <#if failures?size &gt; 0>
                  <tr><td><a href="${url.serviceContext}/index/failures">Browse failed Web Scripts</a></td></tr>
                  </#if>
               </table>
            </td>
         </tr>
      </table>

      <!-- outer table -->
      </td>
      <td valign="top" align="left" class="outer">

      <!-- TEMPLATES -->
      <table>
         <tr>
            <td colspan="3" class="header" align="center">
                Templates
            </td>
         </tr>
         <tr>
            <td colspan="3"><br/></td>
         </tr>
         <tr>
            <td nowrap><img src="${url.context}/res/images/icons/template.png"></td>
            <td width="100%">Templates</td>
            <td align="right">0</td>
         </tr>
         <tr>
            <td colspan="3">
                <br/>
                Browse Templates by Path
            </td>
         </tr>
      </table>

      <!-- outer table -->
      </td>
      <td valign="top" align="left" class="outer">

      <!-- MISCELLANEOUS -->
      <table>
         <tr>
            <td colspan="2" class="header" align="center">Documentation</td>
         </tr>
         <tr>
            <td colspan="2"><br/></td>
         </tr>
         <tr>
            <td colspan="2">
               <@wsLib.onlinedoc/>
               <br/>
            </td>
         </tr>

         <tr>
            <td colspan="2" class="header" align="center">Options</td>
         </tr>
         <tr>
            <td colspan="2"><br/></td>
         </tr>
         <tr>
            <td colspan="2">
               <!-- General Commands -->
               <input type="button" name="startJsDebugger" value="Start/Stop JavaScript Debugger" onclick="window.location.href='${url.serviceContext}/api/javascript/debugger'"/><br/>
               <input type="button" name="goModuleDeployment" value="Module Deployment" onclick="window.location.href='${url.serviceContext}/modules/deploy'"/><br/>
               <form action="${url.serviceContext}/caches/dependency/clear" method="post">
                   <input type="submit" name="submit" value="Clear Dependency Caches"/>
               </form>
               <input type="button" name="goCacheReport" value="Cache Report" onclick="window.location.href='${url.serviceContext}/caches/report'"/><br/>
               <#if surfbugEnabled??>
                   <br/>
                   <span class="mainSubTitle">SurfBug</span>
                   <table>
                     <tr align="left"><td>Current Status: <#if surfbugEnabled>Enabled<#else>Disabled</#if></td></tr>
                   </table>
                   <form action="${url.serviceContext}/surfBugStatus" method="post">
                       <table><tr><td>
                       <#if surfbugEnabled>
                           <input type="hidden" name="statusUpdate" value="disabled"/>
                           <input type="submit" name="submit" value="Disable SurfBug"/>
                       <#else>
                           <input type="hidden" name="statusUpdate" value="enabled"/>
                           <input type="submit" name="submit" value="Enable SurfBug"/>
                       </#if>
                       </td></tr></table>
                   </form>
               </#if>
             </td>
         </tr>
      </table>

      <!-- outer table -->
      </td>
      </tr>
      <tr>
         <td class="outer" align="center">
            <br/>
            <form action="${url.serviceContext}${url.match}" method="post">
               <input type="hidden" name="reset" value="objects"/>
               <input type="submit" name="submit" value="Refresh Object Registry"/>
            </form>
         </td>
         <td class="outer" align="center">
            <br/>
            <form action="${url.serviceContext}${url.match}" method="post">
               <input type="hidden" name="reset" value="webscripts"/>
               <input type="submit" name="submit" value="Refresh Web Scripts"/>
            </form>
         </td>
         <td class="outer" align="center">
            <br/>
            <form action="${url.serviceContext}${url.match}" method="post">
               <input type="hidden" name="reset" value="templates"/>
               <input type="submit" name="submit" value="Refresh Templates"/>
            </form>
         </td>
         <td class="outer" align="center">
            <br/>
            <form action="${url.serviceContext}${url.match}" method="post">
               <input type="hidden" name="reset" value="all"/>
               <input type="submit" name="submit" value="Reset All"/>
            </form>
         </td>
      </tr>
      
      </table>
      </div>
      
   </body>
</html>