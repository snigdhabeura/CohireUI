#pragma checksum "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Authentication\ProfilePage.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "33e271c001e114fd8d090fbf224d8c559de82dd1"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Authentication_ProfilePage), @"mvc.1.0.view", @"/Views/Authentication/ProfilePage.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"33e271c001e114fd8d090fbf224d8c559de82dd1", @"/Views/Authentication/ProfilePage.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"6ea59a34af991f172abef7c894b4ab93a398505a", @"/Views/_ViewImports.cshtml")]
    public class Views_Authentication_ProfilePage : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 2 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Authentication\ProfilePage.cshtml"
  
    ViewData["Title"] = "ProfilePage";

#line default
#line hidden
#nullable disable
#nullable restore
#line 5 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Authentication\ProfilePage.cshtml"
  
    Context.Request.Cookies.TryGetValue("Username", out string value);

#line default
#line hidden
#nullable disable
            WriteLiteral("<h1>Hi ");
#nullable restore
#line 8 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Authentication\ProfilePage.cshtml"
  Write(Html.Raw(value));

#line default
#line hidden
#nullable disable
            WriteLiteral(", Welcome to cohyre. This is your ProfilePage.</h1>\r\n\r\n");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
