#pragma checksum "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\_PostSuccessPopUp.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "59ee5dae3d181efcd8ec1f64d3e3cff30e383966"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home__PostSuccessPopUp), @"mvc.1.0.view", @"/Views/Home/_PostSuccessPopUp.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"59ee5dae3d181efcd8ec1f64d3e3cff30e383966", @"/Views/Home/_PostSuccessPopUp.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"6ea59a34af991f172abef7c894b4ab93a398505a", @"/Views/_ViewImports.cshtml")]
    public class Views_Home__PostSuccessPopUp : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<CohireAPI.PostJobs.Model.PostJobModel>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "Index", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"
<div class=""modal-dialog modal-lg"" id=""postModal1"" data-bs-backdrop=""static"" data-bs-keyboard=""false"" tabindex=""-1"" aria-labelledby=""exampleModalLabel1"" aria-hidden=""true"">
    <div class=""modal-dialog modal-dialog-centered"">
        <div class=""modal-content rounded-4 p-4 border-0"">
            <div class=""modal-header d-flex align-items-center justify-content-start border-0 p-0 mb-3"">
                <a href=""#"" class=""text-muted text-decoration-none material-icons"" data-bs-toggle=""modal"" data-bs-target=""#postModal"">arrow_back_ios_new</a>
");
            WriteLiteral(@"                <h5 class=""modal-title text-muted ms-3 ln-0""><span class=""md-10"">your post sucessfully posted </span></h5>

            </div>



            <div class=""modal-footer justify-content-start px-1 py-1 bg-white shadow-sm rounded-5"">
                <div class=""rounded-4 m-0 px-3 py-2 d-flex align-items-center justify-content-between w-75"">
                </div>
                <div class=""rounded-4 m-0 px-3 py-2 d-flex align-items-center justify-content-between w-75"" data-bs-dismiss=""modal"">
                    <a data-bs-dismiss=""modal"" href=""#"" class=""btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center""><span class=""material-icons me-2 md-16""></span>Cancel</a>
                </div>
                <div class=""ms-auto m-0"" data-bs-toggle=""modal"" data-bs-target=""#commentModal1"">
                    <a data-bs-dismiss=""modal"" href=""#"" class=""btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center""><span class=""material-icons me-2 m");
            WriteLiteral("d-16\">send</span>Post</a>\r\n                </div>\r\n            </div>\r\n\r\n        </div>\r\n    </div>\r\n</div>\r\n<div>\r\n    ");
#nullable restore
#line 30 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\_PostSuccessPopUp.cshtml"
Write(Html.ActionLink("Edit", "Edit", new { /* id = Model.PrimaryKey */ }));

#line default
#line hidden
#nullable disable
            WriteLiteral(" |\r\n    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("a", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "59ee5dae3d181efcd8ec1f64d3e3cff30e3839665569", async() => {
                WriteLiteral("Back to List");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.AnchorTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_AnchorTagHelper.Action = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n</div>\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<CohireAPI.PostJobs.Model.PostJobModel> Html { get; private set; }
    }
}
#pragma warning restore 1591
